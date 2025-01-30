# Define the source and destination directories
$sourceDirectory = ".\user-removal"
$destinationDirectory = "C:\Users\Public\scripts"

# Check if destination directory exists, if not create it
if (-not (Test-Path $destinationDirectory)) {
    New-Item -Path $destinationDirectory -ItemType Directory
}

# Get all files in the source directory
$files = Get-ChildItem -Path $sourceDirectory -File

# Loop through each file and copy it to the destination directory
foreach ($file in $files) {
    $destinationPath = Join-Path -Path $destinationDirectory -ChildPath $file.Name
    Copy-Item -Path $file.FullName -Destination $destinationPath -Force
}