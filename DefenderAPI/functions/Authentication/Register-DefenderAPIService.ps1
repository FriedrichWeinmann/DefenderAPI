function Register-DefenderAPIService {
	<#
	.SYNOPSIS
		Define a new Defender API Service to connect to.
	
	.DESCRIPTION
		Define a new Defender API Service to connect to.
		This allows defining new endpoints to connect to ... or overriding existing endpoints to a different configuration.
	
	.PARAMETER Name
		Name of the Service.
	
	.PARAMETER ServiceUrl
		The base Url requests will use.
	
	.PARAMETER Resource
		The Resource ID. Used when connecting to identify which scopes of an App Registration to use.
	
	.PARAMETER DefaultScopes
		Default scopes to request.
		Used in interactive delegate flows to provide a good default user experience.
		Default scopes should usually include common read scenarios.

	.PARAMETER Header
		Header data to include in each request.
	
	.PARAMETER HelpUrl
		Link for more information about this service.
		Ideally to documentation that helps setting up the connection.
	
	.EXAMPLE
		PS C:\> Register-DefenderAPIService -Name Endpoint -ServiceUrl 'https://api.securitycenter.microsoft.com/api' -Resource 'https://api.securitycenter.microsoft.com'
		
		Registers the defender for endpoint API as a service.
	#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]
		$Name,

		[Parameter(Mandatory = $true)]
		[string]
		$ServiceUrl,

		[Parameter(Mandatory = $true)]
		[string]
		$Resource,

		[AllowEmptyCollection()]
		[string[]]
		$DefaultScopes = @(),

		[hashtable]
		$Header = @{},

		[string]
		$HelpUrl
	)
	process {
		$script:_DefenderEndpoints[$Name] = [PSCustomObject]@{
			PSTypeName    = 'DefenderAPI.Service'
			Name          = $Name
			ServiceUrl    = $ServiceUrl
			Resource      = $Resource
			DefaultScopes = $DefaultScopes
			Header        = $Header
			HelpUrl       = $HelpUrl
		}
	}
}