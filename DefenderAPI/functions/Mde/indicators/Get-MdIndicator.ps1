function Get-MdIndicator {
<#
.SYNOPSIS
    Indicators - Get list of all active indicators

.DESCRIPTION
    Retrieve from Windows Defender ATP list of all active indicators

.PARAMETER Orderby
    Sorts the results.

.PARAMETER Top
    Returns only the first n results.

.PARAMETER Filter
    Filters the results, using OData syntax.

.PARAMETER Skip
    Skips the first n results.

.PARAMETER Select
    Selects which properties to include in the response, defaults to all.

.PARAMETER Count
    Includes a count of the matching results in the response.

.EXAMPLE
    PS C:\> Get-MdIndicator

    Retrieve from Windows Defender ATP list of all active indicators

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Orderby,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [int32]
        $Top,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Filter,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [int32]
        $Skip,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string[]]
        $Select,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [boolean]
        $Count
    )
    process {
		$__mapping = @{
            'Orderby' = '$orderby'
            'Top' = '$top'
            'Filter' = '$filter'
            'Skip' = '$skip'
            'Select' = '$select'
            'Count' = '$count'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @('Orderby','Top','Filter','Skip','Select','Count') -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'indicators'
			Method = 'get'
			
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}