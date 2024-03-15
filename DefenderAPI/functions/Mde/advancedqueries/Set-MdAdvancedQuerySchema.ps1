function Set-MdAdvancedQuerySchema {
<#
.SYNOPSIS
    Advanced Hunting Schema

.DESCRIPTION
    Gets the schema for a Windows Defender ATP custom query

.PARAMETER Query
    The query to run

.EXAMPLE
    PS C:\> Set-MdAdvancedQuerySchema -Query $query

    Gets the schema for a Windows Defender ATP custom query

.LINK
    <unknown>
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
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
			Path = 'advancedqueries/schema'
			Method = 'post'
			
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}