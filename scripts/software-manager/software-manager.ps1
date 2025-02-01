# Define the path to the text file containing the list of software
$softwareListPath = "software-list.txt"

# Check if the file exists
if (!(Test-Path $softwareListPath)) {
    Write-Host "Error: The file $softwareListPath does not exist." -ForegroundColor Red
    exit 1
}

# Read the list of software
$softwares = Get-Content $softwareListPath

foreach ($software in $softwares) {
    if (-not [string]::IsNullOrWhiteSpace($software)) {
        Write-Host "Processing: $software" -ForegroundColor Cyan
        
        # Get installed version
        $installedVersion = (winget list --id "$software" --exact | Select-String "\s([\d\.]+)\s").Matches.Groups[1].Value
        
        # Get latest version from manifest
        $latestVersion = (winget show --id "$software" --exact | Select-String "Version:\s([\d\.]+)").Matches.Groups[1].Value
        
        if ($installedVersion -and $latestVersion) {
            if ([System.Version]$latestVersion -gt [System.Version]$installedVersion) {
                Write-Host "Updating $software to version $latestVersion..." -ForegroundColor Yellow
                winget upgrade --id "$software" --exact --silent
            }
            else {
                Write-Host "$software is already up-to-date." -ForegroundColor Green
            }
        }
        elseif ($installedVersion) {
            Write-Host "$software is already installed and no version info found." -ForegroundColor Green
        }
        else {
            Write-Host "Installing $software..." -ForegroundColor Green
            winget install --id "$software" --exact --silent
        }
    }
}


