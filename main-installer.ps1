function Invoke-InstallerScripts {
    param (
        [string]$Directory
    )

    $scripts = Get-ChildItem -Path $Directory -Filter "*.*" | Where-Object { $_.Extension -in (".ps1") }

    $totalScripts = $scripts.Count
    $currentScriptIndex = 0

    foreach ($script in $scripts) {
        try {
            Write-Progress -Status "Running installer scripts..." -Activity "Executing: $($script.Name)" -PercentComplete (($currentScriptIndex / $totalScripts) * 100)
            $currentScriptIndex++

            if ($script.Extension -eq ".ps1") {
                Start-Process powershell -ArgumentList $script.FullName -NoNewWindow
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
