<#
Add all things you want to run before importing the main function code.

WARNING: ONLY provide paths to files!

After building the module, this file will be completely ignored, adding anything but paths to files ...
- Will not work after publishing
- Could break the build process
#>

$moduleRoot = Split-Path (Split-Path $PSScriptRoot)

# Load the strings used in messages
"$moduleRoot\internal\scripts\strings.ps1"

# Load classes
(Get-ChildItem "$moduleRoot\internal\classes\*.ps1" -ErrorAction Ignore).FullName

# Load Tab Expansion
(Get-ChildItem "$moduleRoot\internal\tepp\*.tepp.ps1" -ErrorAction Ignore).FullName

# Load Tab Expansion Assignment
"$moduleRoot\internal\tepp\assignment.ps1"
