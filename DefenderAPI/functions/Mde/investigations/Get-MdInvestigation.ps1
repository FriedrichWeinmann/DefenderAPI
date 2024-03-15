﻿function Get-MdInvestigation {
<#
.SYNOPSIS
    Actions - Get list of investigation

.DESCRIPTION
    Retrieve from Microsoft Defender ATP the most recent investigations

.PARAMETER InvestigationID
    The identifier of the investigation to retrieve

.PARAMETER Top
    Returns only the first n results.

.PARAMETER Select
    Selects which properties to include in the response, defaults to all.

.PARAMETER Filter
    Filters the results, using OData syntax.

.PARAMETER Count
    Includes a count of the matching results in the response.

.PARAMETER Orderby
    Sorts the results.

.PARAMETER Skip
    Skips the first n results.

.EXAMPLE
    PS C:\> Get-MdInvestigation

    Retrieve from Microsoft Defender ATP the most recent investigations

.EXAMPLE
    PS C:\> Get-MdInvestigation -InvestigationID $investigationid

    Retrieve from Microsoft Defender ATP a specific investigation

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetSingleInvestigation')]
        [string]
        $InvestigationID,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [int32]
        $Top,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string[]]
        $Select,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Filter,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [boolean]
        $Count,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Orderby,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [int32]
        $Skip
    )
    process {
		$__mapping = @{
            'Top' = '$top'
            'Select' = '$select'
            'Filter' = '$filter'
            'Count' = '$count'
            'Orderby' = '$orderby'
            'Skip' = '$skip'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @('Top','Select','Filter','Count','Orderby','Skip') -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'investigations'
			Method = 'get'
			
			
		}
		if ($InvestigationID) { $__param.Path += "/$InvestigationID" }
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}