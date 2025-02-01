function Copy-Scripts {
    param (
        [string]$SourceDirectory,
        [string]$DestinationDirectory
    )

    # Check if destination directory exists, if not create it
    if (-not (Test-Path $DestinationDirectory)) {
        New-Item -Path $DestinationDirectory -ItemType Directory
    }

    # Get all files in the source directory
    $files = Get-ChildItem -Path $SourceDirectory -File

    # Loop through each file and copy it to the destination directory
    foreach ($file in $files) {
        $destinationPath = Join-Path -Path $DestinationDirectory -ChildPath $file.Name
        Copy-Item -Path $file.FullName -Destination $destinationPath -Force
    }
}
