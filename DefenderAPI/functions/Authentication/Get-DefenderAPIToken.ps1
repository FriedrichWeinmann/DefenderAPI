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
		Defaults to: *
	
	.EXAMPLE
		PS C:\> Get-DefenderAPIToken
		
		Returns all current session tokens
	#>
	
	[CmdletBinding()]
	param (
		[PsfArgumentCompleter('DefenderAPI.Service')]
		[PsfValidateSet(TabCompletion = 'DefenderAPI.Service')]
		[string]
		$Service = '*'
	)
	process {
		$script:_DefenderTokens.Values | Where-Object Service -like $Service
	}
}