$ErrorActionPreference = 'SilentlyContinue'

# 1. Stop user-context Adobe processes that hold file locks on opm.db
$adobeProcesses = @(
    "Acrobat",
    "AcroCEF",
    "AdobeCollabSync",
    "Creative Cloud",
    "CCXProcess",
    "CCLibrary",
    "CoreSync",
    "AdobeIPCBroker",
    "Adobe Desktop Service"
)

foreach ($proc in $adobeProcesses) {
    Get-Process -Name $proc | Stop-Process -Force
}

Start-Sleep -Seconds 2

# 2. Purge all Adobe entries from the logged-on user's Windows Credential Manager
$rawTargets = cmdkey /list | Where-Object { $_ -match '^\s*Target:\s*(.+Adobe.+)$' } | ForEach-Object {
    $Matches[1].Trim()
}

foreach ($target in $rawTargets) {
    # Strip Windows LegacyGeneric prefix if present so cmdkey /delete matches the entry
    $cleanTarget = $target -replace '^LegacyGeneric:target=', ''
    cmdkey /delete:"$cleanTarget" | Out-Null
    cmdkey /delete:"$target" | Out-Null
}

# 3. Remove local OOBE database (including SQLite WAL/SHM journals) and IdentityCache
$pathsToRemove = @(
    "$env:LOCALAPPDATA\Adobe\OOBE\opm.db",
    "$env:LOCALAPPDATA\Adobe\OOBE\opm.db-wal",
    "$env:LOCALAPPDATA\Adobe\OOBE\opm.db-shm",
    "$env:LOCALAPPDATA\Adobe\IdentityCache"
)

foreach ($path in $pathsToRemove) {
    if (Test-Path -LiteralPath $path) {
        Remove-Item -LiteralPath $path -Recurse -Force
    }
}

Write-Output "Adobe local authentication cache cleared for user: $env:USERNAME"
exit 0
