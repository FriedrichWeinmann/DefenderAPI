#requires -Module AutoRest

$global:_arCommands = @{ }

#region Endpoint
# $webClient = [System.Net.WebClient]::new()
# $swagger = $webClient.DownloadString("https://api.securitycenter.microsoft.com/swagger/v1/swagger.json")
# [System.IO.File]::WriteAllText("$PSScriptRoot\mde.swagger.json", $swagger)

$paramConvertFromARSwagger = @{
	Path          = "$PSScriptRoot\mde.swagger.json"
	RestCommand   = 'Invoke-DefenderAPIRequest'
	ModulePrefix  = 'Md'
	PathPrefix    = '/api'
	TransformPath = "$PSScriptRoot\overridesMde"
	ConvertToHashtableCommand = 'ConvertTo-HashTable'
}

$paramExportARCommand = @{
	Path            = "$PSScriptRoot\..\DefenderAPI\functions\MDE"
	GroupByEndpoint = $true
}

# Clear Previous Commands
Get-ChildItem -Path "$PSScriptRoot\..\DefenderAPI\functions\MDE\*" | ForEach-Object {
	Remove-Item -LiteralPath $_.FullName -Recurse -Force
}

# Build from Swagger & overrides
$commands = ConvertFrom-ARSwagger @paramConvertFromARSwagger
foreach ($command in $commands) {
	$command.PassThruActions = $true
	if ($command.Parameters.Authorization.Type -eq 'Header') {
		$command.Parameters.Remove('Authorization')
	}
}
$commands | Export-ARCommand @paramExportARCommand
$global:_arCommands['Endpoint'] = $commands
#endregion Endpoint

#region M365
<#
# Currently no swagger file source
$swagger = $webClient.DownloadString("https://api.security.microsoft.com/swagger/v1/swagger.json")
[System.IO.File]::WriteAllText("$PSScriptRoot\M365.swagger.json", $swagger)

$paramConvertFromARSwagger = @{
	Path          = "$PSScriptRoot\M365.swagger.json"
	RestCommand   = 'Invoke-MdRequest'
	ModulePrefix  = 'Md'
	PathPrefix    = '/api'
	TransformPath = "$PSScriptRoot\overridesM365"
	ServiceName   = 'Security'
}

$paramExportARCommand = @{
	Path            = "$PSScriptRoot\..\DefenderAPI\functions\M365"
	GroupByEndpoint = $true
}

# Clear Previous Commands
Get-ChildItem -Path "$PSScriptRoot\..\DefenderAPI\functions\M365\*" | ForEach-Object {
	Remove-Item -LiteralPath $_.FullName -Recurse -Force
}

# Build from Swagger & overrides
$commands = ConvertFrom-ARSwagger @paramConvertFromARSwagger
$commands | Export-ARCommand @paramExportARCommand
$global:_arCommands['M365'] = $commands
#>
#endregion M365

# Build list of commands from filename to include manual commands
$commandNames = (Get-ChildItem "$PSScriptRoot\..\DefenderAPI\functions" -Recurse -Filter *.ps1).BaseName
Update-ModuleManifest -Path "$PSScriptRoot\..\DefenderAPI\DefenderAPI.psd1" -FunctionsToExport $commandNames