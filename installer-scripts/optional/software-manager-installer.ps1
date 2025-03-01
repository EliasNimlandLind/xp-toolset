
$scriptDir = $PSScriptRoot

Import-Module "$scriptDir\base-installer.psm1"

$sourceDirectory = "$scriptDir\..\scripts\software-manager"
$destinationDirectory = "C:\Users\Public\scripts\ExecuteOnStartup"

Copy-Scripts -SourceDirectory $sourceDirectory -DestinationDirectory $destinationDirectory