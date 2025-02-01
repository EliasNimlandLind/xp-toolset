# Function to copy a source directory to a destination and overwrite if necessary
function CopyWithOverwrite {
    param (
        [string]$sourceDirectory,
        [string]$destinationDirectory,
        [bool]$deleteSource = $false 
    )

    # Check if source directory exists
    if (-not (Test-Path -Path $sourceDirectory)) {
        Write-Host "Source directory does not exist."
        return
    }

    # Remove the destination if it exists
    if (Test-Path -Path $destinationDirectory) {
        Remove-Item -Path $destinationDirectory -Recurse -Force
        Write-Host "Removed existing directory: $destinationDirectory"
    }

    # Copy the source to the destination
    Copy-Item -Path $sourceDirectory -Destination $destinationDirectory -Recurse
    Write-Host "Copied $sourceDirectory to $destinationDirectory"

    if ($deleteSource -eq $true) {
        Remove-Item -Path $sourceDirectory -Recurse -Force
        Write-Host "Deleted files from source directory: $sourceDirectory"
    }
}

# Example Usage:
$distributionPath = "distribution"

# Define paths and call the function
CopyWithOverwrite -sourceDirectory "./scripts/user-removal" -destinationDirectory "$distributionPath/user-removal"
CopyWithOverwrite -sourceDirectory ".\installer-scripts" -destinationDirectory "$distributionPath/installer-scripts"

$files = Get-ChildItem -Path "$distributionPath/installer-scripts" -Filter "*.ps1"
foreach ($file in $files) {
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

# Create an EXE file based on main-installer.ps1
Invoke-Expression "ps2exe main-installer.ps1 $distributionPath\main-installer.exe -noConsole"

# Create distribution.ZIP
$zipPath = "distribution.zip"
if (Test-Path -Path $zipPath) {
    Remove-Item -Path $zipPath -Force
}

Compress-Archive -Path $distributionPath -CompressionLevel Optimal -DestinationPath $zipPath
Write-Host "Distribution ZIP file created: $zipPath"
