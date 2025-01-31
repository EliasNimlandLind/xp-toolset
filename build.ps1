# Copy BAT files to distribution
function CopyWithOverwrite {
    param (
        [string]$sourcePath,
        [string]$destinationPath
    )

    # Remove the destination if it exists
    if (Test-Path -Path $destinationPath) {
        Remove-Item -Path $destinationPath -Recurse -Force
        Write-Host "Removed existing directory: $destinationPath"
    }

    # Copy the source to the destination
    Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse
    Write-Host "Copied $sourcePath to $destinationPath"
}

$distributionPath = "distribution"
# Define paths and call the function
CopyWithOverwrite -sourcePath "scripts/user-removal" -destinationPath "$distributionPath/user-removal"
CopyWithOverwrite -sourcePath "installer-scripts" -destinationPath "$distributionPath/installer-scripts"

# Create an EXE file based on main-installer.ps1
Invoke-Expression "ps2exe main-installer.ps1 distribution/main-installer.exe -noConsole"

# Create distribution.ZIP
$zipPath = "distribution.zip"
if (Test-Path -Path $zipPath) {
    Remove-Item -Path $zipPath -Force
}
Compress-Archive -Path distribution -CompressionLevel Optimal -DestinationPath $zipPath
