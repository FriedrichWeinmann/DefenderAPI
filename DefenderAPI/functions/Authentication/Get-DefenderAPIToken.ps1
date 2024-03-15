function Get-DefenderAPIToken {
	<#
	.SYNOPSIS
		Returns the session token of a defender API connection.
	
	.DESCRIPTION
		Returns the session token of a defender API connection.
		The main use for those token objects is calling their "GetHeader()" method to get an authentication header
		that automatically refreshes tokens as needed.
	
	.PARAMETER Service
		The service for which to retrieve the token.
		Defaults to: Endpoint
	
	.EXAMPLE
		PS C:\> Get-DefenderAPIToken
		
		Returns the session token of the Endpoint service connection
	#>
	
	[CmdletBinding()]
	param (
		[PsfArgumentCompleter('DefenderAPI.Service')]
		[PsfValidateSet(TabCompletion = 'DefenderAPI.Service')]
		[string]
		$Service = 'Endpoint'
	)
	process {
		$script:_DefenderTokens.$Service
	}
}