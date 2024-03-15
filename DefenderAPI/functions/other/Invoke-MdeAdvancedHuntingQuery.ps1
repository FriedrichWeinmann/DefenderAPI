function Invoke-MdeAdvancedHuntingQuery {
	<#
	.SYNOPSIS
		Execute an advanced hunting query.
	
	.DESCRIPTION
		Execute an advanced hunting query.

		Requires being connected to the "security" service.
		To establish a connection, use the "Connect-MdeService" command with the parameter '-Service "security"'
		Example:
		Connect-MdeService -Service security -DeviceCode -ClientID $ClientID -TenantID $TenantID
		
		Scopes required (delegate auth): AdvancedHunting.Read
	
	.PARAMETER Query
		The hunting query to execute.
	
	.EXAMPLE
		PS C:\> Invoke-MdeAdvancedHuntingQuery -Query 'DeviceProcessEvents | where InitiatingProcessFileName =~ \"powershell.exe\" | project Timestamp, FileName, InitiatingProcessFileName | order by Timestamp desc | limit 2'

		Executes the query, searching for the latest two powershell processes
	
	.LINK
		https://docs.microsoft.com/en-us/microsoft-365/security/defender/api-advanced-hunting?view=o365-worldwide
	#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
		[string]
		$Query
	)

	process {
		$__mapping = @{
			'Query' = 'Query'
		}
		$__body = $PSBoundParameters | ConvertTo-HashTable -Include @('Query') -Mapping $__mapping
		$__query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
		$__path = 'advancedhunting/run'
	
		Invoke-MdeRequest -Service 'security' -Path $__path -Method post -Body $__body -Query $__query -RequiredScopes 'AdvancedHunting.Read' | ConvertFrom-AdvancedQuery
	}
}