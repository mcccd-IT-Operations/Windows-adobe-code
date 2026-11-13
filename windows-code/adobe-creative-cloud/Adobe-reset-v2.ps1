## Original: Jim Ierely
## Edited 11/12/26 @ 7:02 PM by Alvin Bridges
## Version: 2 — review candidate.
## Status: Pending District ITS peer and Cyber Security approval.
## Not approved for production. Download availability does not grant approval.
## Comparison baseline: The earlier supplied .ps1 and .txt contain identical
## script content. CHANGED notes below explain differences between those
## files and the newer script pasted into this conversation.
## This final copy preserves the newer script's commands and behavior.

## CHANGED - Documentation and parameters:
## Adds help text describing deployment context, options, and exit codes.
## The earlier script had no parameters. CredentialFilter makes credential
## matching configurable; GraceSeconds controls the graceful-close wait;
## KeepBackup allows local cache files to be renamed instead of deleted.
## CmdletBinding also enables common parameters such as -Verbose.
## KeepBackup does not back up credentials deleted from Credential Manager.
<#
.SYNOPSIS
    Clears the logged-on user's local Adobe sign-in state (Credential Manager
    entries, OOBE opm.db, IdentityCache) so the next launch forces a clean sign-in.

.DESCRIPTION
    Must run in the affected user's context (Intune: "Run this script using the
    logged on credentials" = Yes; ConfigMgr: run with user rights). Running as
    SYSTEM is refused, because the credential vault and %LOCALAPPDATA% are per-user.

    Exit codes: 0 = clean, 1 = wrong context, 2 = one or more items could not be cleared.

.PARAMETER CredentialFilter
    Wildcard matched against the credential target name. Default 'Adobe*'.

.PARAMETER GraceSeconds
    Seconds to let windowed Adobe apps close on their own before force-killing.

.PARAMETER KeepBackup
    Rename files/folders to *.bak-<timestamp> instead of deleting them.
#>
[CmdletBinding()]
param(
    [string]$CredentialFilter = 'Adobe*',
    [ValidateRange(0, 120)][int]$GraceSeconds = 5,
    [switch]$KeepBackup
)

## CHANGED - Error handling and result tracking:
## Replaces SilentlyContinue with Stop so PowerShell errors can be caught.
## Adds separate success/failure lists used by the final report, instead of
## unconditionally printing success. Selected process operations still use
## SilentlyContinue, followed by a check for surviving matching processes.
## Unhandled terminating errors can still bypass the final report.
$ErrorActionPreference = 'Stop'
$failures = New-Object System.Collections.Generic.List[string]
$cleared  = New-Object System.Collections.Generic.List[string]

## CHANGED - Context guard (new section):
## Refuses SYSTEM, missing LocalAppData, and LocalAppData under SystemRoot
## to avoid resetting a system profile instead of the affected user's data.
## The earlier script operated on whichever account launched it unchecked.
## This guard does not prove the account is the intended interactive user;
## deployment must still select that user's credentials and session.
# --- 0. Context guard -------------------------------------------------------
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
if ($identity.IsSystem -or [string]::IsNullOrEmpty($env:LOCALAPPDATA) -or
    $env:LOCALAPPDATA -like "$env:SystemRoot\*") {
    Write-Output "FAILED: running as '$($identity.Name)'. This script must run in the logged-on user's context."
    exit 1
}

## CHANGED - Process scope and discovery:
## The earlier script stopped nine process names without a session filter.
## This version restricts matches to the script's Windows session, excludes
## itself, expands the known-name list, and also looks for executables whose
## path contains an Adobe directory. This catches additional applications
## and helpers that could keep authentication files open.
## Session scoping is not an explicit process-owner check. Path discovery
## depends on readable process paths and the executable's folder name.
# --- 1. Stop Adobe processes in THIS user's session -------------------------
$sessionId = (Get-Process -Id $PID).SessionId
$knownNames = @(
    'Acrobat', 'AcroRd32', 'AcroCEF', 'RdrCEF', 'acrotray', 'AdobeCollabSync',
    'Creative Cloud', 'Creative Cloud Helper', 'Creative Cloud UI Helper',
    'CCXProcess', 'CCLibrary', 'CoreSync', 'AdobeIPCBroker',
    'Adobe Desktop Service', 'Adobe CEF Helper', 'AdobeNotificationClient',
    'Adobe Crash Processor', 'AdobeGCClient'
)

function Get-AdobeUserProcess {
    Get-Process -ErrorAction SilentlyContinue | Where-Object {
        if ($_.SessionId -ne $sessionId -or $_.Id -eq $PID) { return $false }
        if ($knownNames -contains $_.ProcessName) { return $true }
        $path = $null
        try { $path = $_.Path } catch { }
        # Catches node.exe helpers, Photoshop, etc. that live under an Adobe folder
        return ($path -and $path -match '\\Adobe\\')
    }
}

## CHANGED - Graceful application shutdown:
## Requests that windowed applications close, then waits up to GraceSeconds.
## This gives them an opportunity to display save prompts before forced
## termination. Previously all listed processes were immediately killed.
## The wait is limited; unsaved work can still be lost when force is used.
$procs = @(Get-AdobeUserProcess)
if ($procs.Count -gt 0 -and $GraceSeconds -gt 0) {
    # Give windowed apps a chance to close (and prompt to save) before the hard kill
    foreach ($p in $procs) {
        try { if ($p.MainWindowHandle -ne [IntPtr]::Zero) { $null = $p.CloseMainWindow() } } catch { }
    }
    Wait-Process -Id $procs.Id -Timeout $GraceSeconds -ErrorAction SilentlyContinue
}

## CHANGED - Repeated termination and verification:
## Replaces a single force-stop pass and fixed two-second wait with up to
## five sweeps, each followed by a one-second wait. Re-enumeration catches
## helpers that restart while cleanup is underway. Surviving matches are
## recorded as failures, although later restarts can still occur.
# Helpers respawn each other, so sweep until quiet (max 5 passes)
for ($i = 0; $i -lt 5; $i++) {
    $procs = @(Get-AdobeUserProcess)
    if ($procs.Count -eq 0) { break }
    $procs | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 1
}
foreach ($p in @(Get-AdobeUserProcess)) {
    $failures.Add("process still running: $($p.ProcessName) (PID $($p.Id))")
}

## CHANGED - Native Credential Manager access:
## Replaces cmdkey text parsing as the primary method with a C# wrapper for
## Windows CredEnumerateW, CredDeleteW, and CredFree. This avoids dependence
## on translated cmdkey labels and preserves each credential's actual type
## and target for deletion, instead of guessing a display-prefix format.
## The structure maps native credential fields; only type and target are
## returned to PowerShell. Credential blobs are not read or logged.
## List frees the native enumeration buffer in finally; error 1168 means
## no credentials were found. Delete returns a Win32 status for reporting.
## If Add-Type fails, the script attempts the cmdkey fallback below.
## That catch does not cover a later failure inside AdobeCredMan.List().
# --- 2. Purge Adobe entries from the user's Credential Manager --------------
$credApi = $false
try {
    Add-Type -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

public static class AdobeCredMan
{
    [StructLayout(LayoutKind.Sequential)]
    private struct CREDENTIAL
    {
        public int Flags;
        public int Type;
        public IntPtr TargetName;
        public IntPtr Comment;
        public long LastWritten;
        public int CredentialBlobSize;
        public IntPtr CredentialBlob;
        public int Persist;
        public int AttributeCount;
        public IntPtr Attributes;
        public IntPtr TargetAlias;
        public IntPtr UserName;
    }

    [DllImport("advapi32.dll", EntryPoint = "CredEnumerateW", CharSet = CharSet.Unicode, SetLastError = true)]
    private static extern bool CredEnumerate(string filter, int flags, out int count, out IntPtr creds);

    [DllImport("advapi32.dll", EntryPoint = "CredDeleteW", CharSet = CharSet.Unicode, SetLastError = true)]
    private static extern bool CredDelete(string target, int type, int flags);

    [DllImport("advapi32.dll")]
    private static extern void CredFree(IntPtr buffer);

    // Returns "type|targetName" for every credential (filtering is done by the caller)
    public static string[] List()
    {
        int count; IntPtr buffer;
        var result = new List<string>();
        if (!CredEnumerate(null, 0, out count, out buffer))
        {
            int err = Marshal.GetLastWin32Error();
            if (err == 1168) return result.ToArray();   // ERROR_NOT_FOUND: vault is empty
            throw new System.ComponentModel.Win32Exception(err);
        }
        try
        {
            for (int i = 0; i < count; i++)
            {
                IntPtr p = Marshal.ReadIntPtr(buffer, i * IntPtr.Size);
                CREDENTIAL c = (CREDENTIAL)Marshal.PtrToStructure(p, typeof(CREDENTIAL));
                result.Add(c.Type + "|" + Marshal.PtrToStringUni(c.TargetName));
            }
        }
        finally { CredFree(buffer); }
        return result.ToArray();
    }

    // Returns 0 on success, otherwise the Win32 error code
    public static int Delete(string target, int type)
    {
        return CredDelete(target, type, 0) ? 0 : Marshal.GetLastWin32Error();
    }
}
'@
    $credApi = $true
} catch {
    # Add-Type is blocked in Constrained Language Mode (WDAC/AppLocker) - fall back to cmdkey
    $credApi = $false
}

## CHANGED - Configurable credential matching and checked deletion:
## Uses a wildcard against native target names. The default Adobe* matches
## targets beginning with Adobe; the old regex looked for Adobe with at
## least one character on either side. These select different sets, so the
## new default is not equivalent to matching Adobe anywhere in the name.
## Splitting once preserves any additional pipe characters in a target.
## Each deletion records success (including already absent) or an error.
if ($credApi) {
    foreach ($entry in [AdobeCredMan]::List()) {
        $type, $target = $entry -split '\|', 2
        if ($target -notlike $CredentialFilter) { continue }
        $rc = [AdobeCredMan]::Delete($target, [int]$type)
        if ($rc -eq 0 -or $rc -eq 1168) { $cleared.Add("credential: $target") }
        else { $failures.Add("credential '$target' (Win32 error $rc)") }
    }
} else {
    ## CHANGED - cmdkey fallback and follow-up check:
    ## Keeps text parsing available if Add-Type fails, strips a wider range
    ## of alphabetic display prefixes, and applies CredentialFilter after
    ## extracting the name. Re-listing records matching targets still present;
    ## the old version attempted two target forms without checking results.
    ## English-only parsing or an unsuccessful listing can yield no targets
    ## and an apparent success. This does not prove the vault was cleared.
    ## The fallback also does not guarantee the whole script can run under
    ## Constrained Language Mode; other .NET operations may be restricted.
    # Fallback: cmdkey text parsing. English-only ("Target:" is localized on non-English Windows).
    $getTargets = {
        cmd /c 'cmdkey /list' 2>$null | ForEach-Object {
            if ($_ -match '^\s*Target:\s*(.+?)\s*$') { $Matches[1] -replace '^[A-Za-z]+:target=', '' }
        } | Where-Object { $_ -like $CredentialFilter }
    }
    foreach ($target in @(& $getTargets)) {
        $null = cmdkey "/delete:$target" 2>&1
    }
    $remaining = @(& $getTargets)
    foreach ($target in $remaining) { $failures.Add("credential '$target' (cmdkey fallback)") }
    if ($remaining.Count -eq 0) { $cleared.Add('credentials: cmdkey fallback pass complete') }
}

## CHANGED - Cache targets and backup timestamp:
## Retains opm.db, its WAL/SHM files, and IdentityCache, and adds the SQLite
## rollback journal opm.db-journal so that another journal form is covered.
## Creates a shared timestamp for cache backups requested by KeepBackup.
# --- 3. Remove the OOBE database (+ SQLite journals) and IdentityCache ------
$pathsToRemove = @(
    "$env:LOCALAPPDATA\Adobe\OOBE\opm.db",
    "$env:LOCALAPPDATA\Adobe\OOBE\opm.db-wal",
    "$env:LOCALAPPDATA\Adobe\OOBE\opm.db-shm",
    "$env:LOCALAPPDATA\Adobe\OOBE\opm.db-journal",
    "$env:LOCALAPPDATA\Adobe\IdentityCache"
)
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'

## CHANGED - Retried cache cleanup with optional retention:
## The old version attempted each deletion once and suppressed failures.
## This version makes up to three attempts, waiting one second after each
## caught error, to tolerate temporary locks. KeepBackup renames each item
## alongside its original location; otherwise it is recursively deleted.
## A follow-up path check and the last caught error determine the result.
## This checks disappearance of the original path, not a successful Adobe
## sign-in or a consistent/restorable database backup. Force does not bypass
## permissions or file locks. Initial/final Test-Path errors are not caught
## by the inner retry block and can bypass the summary.
foreach ($path in $pathsToRemove) {
    if (-not (Test-Path -LiteralPath $path)) { continue }
    $lastError = $null
    for ($try = 1; $try -le 3; $try++) {
        try {
            if ($KeepBackup) {
                Rename-Item -LiteralPath $path -NewName ((Split-Path -Leaf $path) + ".bak-$stamp") -Force
            } else {
                Remove-Item -LiteralPath $path -Recurse -Force
            }
            $lastError = $null
            break
        } catch {
            $lastError = $_.Exception.Message
            Start-Sleep -Seconds 1
        }
    }
    if ($lastError -or (Test-Path -LiteralPath $path)) { $failures.Add("path '$path' ($lastError)") }
    else { $cleared.Add("path: $path") }
}

## CHANGED - Reporting and meaningful explicit exit codes:
## Replaces unconditional success/exit 0 with a failure-aware summary.
## -Verbose displays recorded successes. Recorded failures produce PARTIAL
## and exit 2; the context guard uses exit 1; no recorded failures gives 0.
## The cleared count is a count of log entries: the cmdkey fallback records
## one completed pass, not one entry per deleted credential. An OK result
## does not independently confirm every Adobe sign-in artifact was removed.
# --- 4. Report ---------------------------------------------------------------
$cleared | ForEach-Object { Write-Verbose "cleared $_" }
if ($failures.Count -gt 0) {
    Write-Output ("PARTIAL for {0}: {1} cleared, {2} failed -> {3}" -f $env:USERNAME, $cleared.Count, $failures.Count, ($failures -join '; '))
    exit 2
}
Write-Output ("OK for {0}: {1} item(s) cleared" -f $env:USERNAME, $cleared.Count)
exit 0
