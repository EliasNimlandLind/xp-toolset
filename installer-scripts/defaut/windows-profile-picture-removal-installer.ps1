$scriptDir = $PSScriptRoot

Import-Module "$scriptDir\base-installer.psm1"

$sourceDirectory = "$scriptDir\..\scripts\windows-profile-picture-removal"
$destinationDirectory = "C:\Users\Public\scripts\ExecuteOnOther"

Copy-Scripts -SourceDirectory $sourceDirectory -DestinationDirectory $destinationDirectory
