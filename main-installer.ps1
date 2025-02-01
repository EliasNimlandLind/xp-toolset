# Define a function to invoke installer scripts
function Invoke-InstallerScripts {
    param (
        [string]$Directory
    )

    # Get all .ps1 and .exe files in the specified directory
    $scripts = Get-ChildItem -Path $Directory -Filter "*.*" | Where-Object { $_.Extension -in (".ps1", ".exe") }

    # Initialize progress tracking
    $totalScripts = $scripts.Count
    $currentScriptIndex = 0

    # Loop through each script and run it in a new process
    foreach ($script in $scripts) {
        try {
            Write-Progress -Status "Running installer scripts..." -Activity "Executing: $($script.Name)" -PercentComplete (($currentScriptIndex / $totalScripts) * 100)
            $currentScriptIndex++

            # Handle PowerShell scripts and EXE files differently
            if ($script.Extension -eq ".ps1") {
                # For .ps1 files, start a new PowerShell process
                Start-Process powershell -ArgumentList $script.FullName -Wait -NoNewWindow
            }

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
