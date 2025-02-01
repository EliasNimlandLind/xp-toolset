# Define a function to invoke installer scripts
function Invoke-InstallerScripts {
    param (
        [string]$Directory
    )

    # Get all .ps1 files in the specified directory
    $scripts = Get-ChildItem -Path $Directory -Filter *.ps1

    # Initialize progress tracking
    $totalScripts = $scripts.Count
    $currentScriptIndex = 0

    # Loop through each script and run it in a new PowerShell process
    foreach ($script in $scripts) {
        try {
            Write-Progress -Status "Running installer scripts..." `
                -Activity "Executing: $($script.Name)" `
                -PercentComplete (($currentScriptIndex / $totalScripts) * 100)
            $currentScriptIndex++

            # Start the process and wait until it completes
            Start-Process powershell -ArgumentList $script.FullName -Wait -NoNewWindow
            Write-Host "Completed script: $($script.FullName)"
        }
        catch {
            Write-Host "Error running script: $($script.FullName) Error details: $_"
        }
    }
}

# Call the function to start running installer scripts
$installerScriptsDirectory = ".\installer-scripts"
Invoke-InstallerScripts -Directory $installerScriptsDirectory
