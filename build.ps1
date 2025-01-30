# Copy BAT files to distribution

$sourcePathUserRemoval = "user-removal"
$distributionPathUserRemoval = "distribution/" + $sourcePathUserRemoval 

Copy-Item -Path $sourcePathUserRemoval -Destination $distributionPathUserRemoval -Recurse

$sourcePathInstallerScripts = "installer-scripts"
$distributionPathInstallerScripts = "distribution/" + $sourcePathInstallerScripts 

Copy-Item -Path $sourcePathInstallerScripts -Destination $distributionPathInstallerScripts -Recurse

# Create an EXE file based on main-installer.ps1
Invoke-Expression "ps2exe main-installer.ps1 distribution/main-installer.exe -noConsole"

# Create distribution.ZIP
$zipPath = "distribution.zip"
if (Test-Path -Path $zipPath) {
    Remove-Item -Path $zipPath -Force
}
Compress-Archive -Path distribution -CompressionLevel Optimal -DestinationPath $zipPath
