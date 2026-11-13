# Adobe local sign-in reset — release notes

Original: Jim Ierley  
Version 2 edited 11/12/26 @ 7:02 PM by Alvin Bridges

## Version 2

**Review candidate — pending District ITS peer review and Cyber Security approval. Not approved for production.** Any review release must be marked as a pre-release. Download availability does not grant production authorization. See [the approval record](../../docs/APPROVAL.md).

Version 2 is the revised script supplied by Alvin Bridges on 11/12/26, with explanatory `## CHANGED` comments and the requested attribution. Its executable code is preserved. Version 1 is the earlier original script; the supplied original `.txt` and `.ps1` had identical content.

### Downloadable scripts

- [Version 1 — original script](./Adobe-reset-v1.ps1)
- [Version 2 — updated and annotated script](./Adobe-reset-v2.ps1)

Both scripts are intended to be attached as individual `.ps1` assets to the Version 2 GitHub review pre-release. Version 1 is retained for comparison and historical reference. No release or approval is represented as already created.

### Changes from Version 1 to Version 2

1. **Help and parameters.** Adds comment-based PowerShell help with synopsis, deployment guidance, parameters, and exit codes. Adds `[CmdletBinding()]` and a parameter block: `CredentialFilter` defaults to `Adobe*`; `GraceSeconds` defaults to 5 with a range of 0–120; `KeepBackup` is an optional switch. These make credential scope, graceful-close timing, and cache retention configurable, and enable common parameters such as `-Verbose`.

2. **Error handling and tracking.** Changes `$ErrorActionPreference` from `SilentlyContinue` to `Stop`. Adds string lists named `$failures` and `$cleared` to track results. Selected process operations still suppress errors, with a later survivor check. This makes caught cleanup failures reportable instead of always claiming success.

3. **Context guard.** Adds a Windows identity check and exits with code 1 when running as SYSTEM, when LocalAppData is missing, or when its path is beneath SystemRoot. This helps avoid resetting a system profile instead of the affected user's per-user credential vault and cache.

4. **Process scope and discovery.** Replaces `$adobeProcesses` with `$knownNames` and adds `Get-AdobeUserProcess`. The original nine process names remain; newly listed names are `AcroRd32`, `RdrCEF`, `acrotray`, `Creative Cloud Helper`, `Creative Cloud UI Helper`, `Adobe CEF Helper`, `AdobeNotificationClient`, `Adobe Crash Processor`, and `AdobeGCClient`. Matches are restricted to the script's session, exclude the script's own PID, and also include readable executable paths containing `\Adobe\`. This finds more potential file-lock holders while limiting the session affected.

5. **Graceful close before force.** Calls `CloseMainWindow()` for matching windowed processes and waits up to `GraceSeconds` before forced termination. Version 1 immediately forced all listed matches to stop. This allows a limited opportunity for normal closure and save prompts; the eventual force-stop can still discard unsaved work.

6. **Repeated process sweeps.** Replaces one stop pass and a fixed two-second delay with up to five discovery/force-stop sweeps and one-second waits. Afterward, any surviving matching processes are recorded as failures. This handles helpers that restart each other during cleanup.

7. **Native Credential Manager API.** Adds an embedded C# `AdobeCredMan` class through `Add-Type`. Its native credential structure and `CredEnumerateW`, `CredDeleteW`, and `CredFree` declarations enumerate targets with credential types, delete by target and type, and free native enumeration memory in a `finally` block. Only type and target names are returned to PowerShell; credential blobs are not read or logged. Enumeration error 1168 is treated as an empty vault, while other enumeration errors throw. Deletion returns a Win32 status. This avoids translated cmdkey text on the primary path and allows checked deletion.

8. **Credential matching.** Replaces the hard-coded `Target:` regex containing `(.+Adobe.+)` with a configurable wildcard applied to extracted/native target names. The default `Adobe*` selects names beginning with Adobe. This removes the old regex's required characters on both sides of Adobe, but changes the selected set: targets containing Adobe later in their name can now be skipped by default. Native entries are split only at the first pipe so additional pipe characters remain in the target name.

9. **Credential deletion results.** The native path records a cleared credential for return code 0 or 1168, and records other Win32 codes as failures. Version 1 attempted deletion using both a prefix-stripped and original target name without checking results. The native method uses the actual target and credential type instead.

10. **cmdkey fallback.** If `Add-Type` fails, uses a cmdkey fallback. This invokes listing through `cmd /c`, extracts English `Target:` lines, expands prefix removal from the specific `LegacyGeneric:target=` to an alphabetic `type:target=` form, and applies `CredentialFilter` afterward. It deletes each extracted target once, then re-lists targets and records remaining matches as failures. When none remain it records one completed pass. This retains a fallback and adds a follow-up check; it still depends on English labels and does not validate listing exit codes.

11. **Additional SQLite journal.** Keeps `opm.db`, `opm.db-wal`, `opm.db-shm`, and `IdentityCache`, and adds `opm.db-journal`. This includes the rollback-journal form alongside WAL/SHM files.

12. **Optional local cache backups.** Adds a `yyyyMMdd-HHmmss` timestamp. With `KeepBackup`, renames each existing cache item to its original name plus `.bak-<timestamp>` in the same directory instead of deleting it. Credential Manager entries are still deleted and are not backed up. Without this switch, cache items are removed as before.

13. **Cache retries and verification.** Replaces one deletion attempt with up to three rename/delete attempts, a one-second delay after each caught error, and tracking of the last error. Checks whether the original path remains and records success or failure. This tolerates temporary failures and reports unsuccessful operations. Already absent paths are skipped.

14. **Final report and exit codes.** Replaces unconditional success text and exit 0 with verbose per-success output and a result summary. Recorded failures produce `PARTIAL` with counts and details and exit 2; rejected context exits 1; no recorded failures produces `OK` and exits 0. The cleared count counts result messages, so the fallback contributes one completed-pass message rather than one message per credential deleted.

15. **Attribution and section notes.** The distributed Version 2 copy adds the requested author/edit header and `## CHANGED` explanations describing these differences and their purpose. These comments do not change the pasted script's executable behavior.

### Usage

Run Version 2 on Windows in the affected user's context. For example, from PowerShell:

```powershell
.\Adobe-reset-v2.ps1 -Verbose
.\Adobe-reset-v2.ps1 -KeepBackup -GraceSeconds 10 -Verbose
```

For Intune, the supplied script specifies “Run this script using the logged on credentials” = Yes. For ConfigMgr, use the affected user's rights/context. The context guard does not prove the account is the intended interactive user; session filtering is not a process-owner check.

### Known limitations and validation

- The native enumeration call and some other terminating errors are outside result-reporting catch blocks, so they can bypass the documented summary/explicit exit-code paths.
- The cmdkey fallback can report a successful pass when localized labels or listing errors prevent discovery. The fallback does not guarantee the whole script will work in Constrained Language Mode because other .NET operations may be restricted.
- `KeepBackup` does not verify a consistent/restorable SQLite backup, and does not back up deleted credentials. Force does not bypass access controls or file locks.
- Process discovery depends partly on readable executable paths. A helper can restart after the final sweep. The broader discovery can close additional Adobe applications in the selected session.
- `OK` describes the script's implemented checks; it does not verify an end-to-end Adobe sign-in or guarantee that every authentication artifact was cleared.
- Source was inspected and compared. Neither version was executed on Windows as part of this preparation; PowerShell is unavailable in the current Mac environment.

## Version 1

Original script by Jim Ierley, preserved from the supplied original with no functional changes.

- Force-stops nine named Adobe processes, without filtering by session, and waits two seconds.
- Parses English cmdkey `Target:` lines using the Adobe regex; tries deletion with both the stripped and original target names.
- Deletes the local OOBE database, WAL/SHM companion files, and IdentityCache for the executing account.
- Uses `SilentlyContinue`, prints success, and exits 0 without verifying cleanup.

Download: [Adobe-reset-v1.ps1](./Adobe-reset-v1.ps1).