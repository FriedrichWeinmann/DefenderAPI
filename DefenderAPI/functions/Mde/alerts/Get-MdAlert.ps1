﻿function Get-MdAlert {
<#
.SYNOPSIS
    Alerts - Get list of alerts

.DESCRIPTION
    Retrieve from Windows Defender ATP the most recent alerts

    Scopes required (delegate auth): Alert.Read

.PARAMETER Top
    Returns only the first n results.

.PARAMETER Orderby
    Sorts the results.

.PARAMETER Select
    Selects which properties to include in the response, defaults to all.

.PARAMETER Filter
    Filters the results, using OData syntax.

.PARAMETER AlertID
    The identifier of the alert to retrieve

.PARAMETER Expand
    Expands related entities inline.

.PARAMETER Count
    Includes a count of the matching results in the response.

.PARAMETER Skip
    Skips the first n results.

.EXAMPLE
    PS C:\> Get-MdAlert -AlertID $alertid

    Retrieve from Windows Defender ATP a specific alert

.EXAMPLE
    PS C:\> Get-MdAlert

    Retrieve from Windows Defender ATP the most recent alerts

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-alerts?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [int32]
        $Top,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Orderby,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string[]]
        $Select,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Filter,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetSingleAlert')]
        [string]
        $AlertID,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Expand,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [boolean]
        $Count,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [int32]
        $Skip
    )
    process {
		$__mapping = @{
            'Top' = '$top'
            'Orderby' = '$orderby'
            'Select' = '$select'
            'Filter' = '$filter'
            'Expand' = '$expand'
            'Count' = '$count'
            'Skip' = '$skip'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @('Top','Orderby','Select','Filter','Expand','Count','Skip') -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'alerts'
			Method = 'get'
			RequiredScopes = 'Alert.Read'
			Service = 'DefenderAPI.Endpoint'
		}
		if ($AlertID) { $__param.Path += "/$AlertID" }
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-EntraRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}