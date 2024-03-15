function Get-DefenderAPIService {
	<#
	.SYNOPSIS
		Returns the list of available defender API services that can be connected to.
	
	.DESCRIPTION
		Returns the list of available defender API services that can be connected to.
		Includes for each the endpoint/service url and the default requested scopes.
	
	.PARAMETER Name
		Name of the service to return.
		Defaults to: *
	
	.EXAMPLE
		PS C:\> Get-DefenderAPIService

		List all available services.
	#>
	[CmdletBinding()]
	param (
		[PsfArgumentCompleter('DefenderAPI.Service')]
		[string]
		$Name = '*'
	)
	process {
		$script:_DefenderEndpoints.Values | Where-Object Name -like $Name
	}
}