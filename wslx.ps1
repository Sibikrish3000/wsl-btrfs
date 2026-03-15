# D:\WSL\ubuntu\wslx.ps1
$isAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Start-Process pwsh `
        -Verb RunAs `
        -ArgumentList "-NoProfile -File `"$PSCommandPath`""
    exit
}

# ---- elevated code below ----

wsl --shutdown
Start-Sleep -Seconds 2

$disk = Get-Disk |
    Where-Object FriendlyName -eq 'Msft Virtual Disk' |
    Select-Object -First 1

if (-not $disk) {
    Write-Error "Msft Virtual Disk not found"
    exit 1
}

wsl --mount "\\.\PHYSICALDRIVE$($disk.Number)" --bare

wsl
