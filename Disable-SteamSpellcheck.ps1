<#
.SYNOPSIS

Disables Steam spellchecking in text editor

.DESCRIPTION

This script simply disables the spellcheck for Steam and saves the backup
configuration file with the name "UserPrefs.json.bak" in the same directory.

.NOTES

Coded by SSG 2024-07-25 20:14
#>

$ErrorActionPreference = "Stop"
$filename = "$env:LocalAppData\Steam\htmlcache\UserPrefs.json"
$obj = (Get-Content $filename | ConvertFrom-Json)
if ($obj.spellcheck.dictionaries.length -eq 0) {
    Write-Output "Spellcheck is already disabled"
    return
} else {
    Write-Output "Spellcheck is enabled. Disabling"
}
$backupFilename = "$filename.bak"
Write-Output "Creating a backup config file to $backupFilename"
Copy-Item -Force $filename $backupFilename
$obj.spellcheck.dictionaries = @()
$obj | ConvertTo-Json -Depth 100 -Compress | Out-File -Encoding utf8 $filename
Write-Output "Spellcheck disabled successfully"