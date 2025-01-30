# Start execution of all installer scripts.
# Start-Process makes all calls seperate processes and "-Wait" 
# is used to wait until completion before executing the next installer. 

$directory = ".\installer-scripts"

# Get all .ps1 files in the subdirectory
$scripts = Get-ChildItem -Path $directory -Filter *.ps1

# Loop through each script and run it in a new PowerShell process
foreach ($script in $scripts) {
    try {
        Write-Host "Starting script: $($script.FullName)"
        Start-Process powershell -ArgumentList $script.FullName -Wait -NoNewWindow
        Write-Host "Completed script: $($script.FullName)"
    }
    catch {
        Write-Host "Error running script: $($script.FullName) Error details: $_"
    }
    Pause
}
