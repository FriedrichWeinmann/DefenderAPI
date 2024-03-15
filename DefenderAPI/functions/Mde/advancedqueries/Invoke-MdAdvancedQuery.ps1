function Invoke-MdAdvancedQuery {
<#
.SYNOPSIS
    Advanced Hunting

.DESCRIPTION
    Run a custom query in Windows Defender ATP

    Scopes required (delegate auth): AdvancedQuery.Read

.PARAMETER Query
    The query to run

.EXAMPLE
    PS C:\> Invoke-MdAdvancedQuery -Query $query

    Run a custom query in Windows Defender ATP

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/run-advanced-query-api?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Query
    )
    process {
		$__mapping = @{
            'Query' = 'Query'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('Query') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'advancedqueries/run'
			Method = 'post'
			RequiredScopes = 'AdvancedQuery.Read'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param | ConvertFrom-AdvancedQuery }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}