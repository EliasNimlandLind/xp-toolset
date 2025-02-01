function CopyWithOverwrite {
    param (
        [string]$sourceDirectory,
        [string]$destinationDirectory,
        [bool]$deleteSource = $false 
    )

    if (-not (Test-Path -Path $sourceDirectory)) {
        Write-Host "Source directory does not exist."
        return
    }

    if (Test-Path -Path $destinationDirectory) {
        Remove-Item -Path $destinationDirectory -Recurse -Force
        Write-Host "Removed existing directory: $destinationDirectory"
    }

    Copy-Item -Path $sourceDirectory -Destination $destinationDirectory -Recurse
    Write-Host "Copied $sourceDirectory to $destinationDirectory"

    if ($deleteSource -eq $true) {
        Remove-Item -Path $sourceDirectory -Recurse -Force
        Write-Host "Deleted files from source directory: $sourceDirectory"
    }
}

$distributionPath = "distribution"

CopyWithOverwrite -sourceDirectory "./scripts" -destinationDirectory "$distributionPath/scripts"
CopyWithOverwrite -sourceDirectory ".\installer-scripts" -destinationDirectory "$distributionPath/installer-scripts"

$psFiles += Get-ChildItem -Path "$distributionPath/scripts" -Filter "*.ps1" -Recurse

foreach ($file in $psFiles) {
    $exeFilePath = "$($file.DirectoryName)\$($file.BaseName).exe"

    ps2exe -inputFile $file.FullName -outputFile "$exeFilePath"
    if (Test-Path -Path $exeFilePath) {
        Remove-Item -Path $file.FullName -Force
        Write-Host "Deleted: $($file.FullName)"
    }
    else {
        Write-Host "Conversion failed for: $($file.FullName), skipping deletion."
    }
}

Invoke-Expression "ps2exe main-installer.ps1 $distributionPath\main-installer.exe -noConsole"

$zipPath = "$distributionPath.zip"
if (Test-Path -Path $zipPath) {
    Remove-Item -Path $zipPath -Force
}
Compress-Archive -Path $distributionPath -CompressionLevel Optimal -DestinationPath $zipPath
Write-Host "Distribution ZIP file created: $zipPath"
