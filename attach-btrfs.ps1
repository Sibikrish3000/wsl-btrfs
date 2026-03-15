$VhdPath = "D:\WSL\ubuntu\btrfs.vhdx"

# Attach VHDX if needed
if (-not (Get-Disk | Where-Object FriendlyName -eq "Msft Virtual Disk")) {
    diskpart /s "$PSScriptRoot\attach.txt"
}

# Force WSL VM to exist
wsl --shutdown
Start-Sleep -Seconds 2
wsl --exec true
Start-Sleep -Seconds 2

# Get disk number
$disk = Get-Disk | Where-Object FriendlyName -eq "Msft Virtual Disk"

if ($disk) {
    wsl --mount "\\.\PHYSICALDRIVE$($disk.Number)" --bare
}
