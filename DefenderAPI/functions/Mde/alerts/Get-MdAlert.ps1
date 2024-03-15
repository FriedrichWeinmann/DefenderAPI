function Get-MdAlert {
<#
.SYNOPSIS
    Alerts - Get list of alerts

.DESCRIPTION
    Retrieve from Windows Defender ATP the most recent alerts

    Scopes required (delegate auth): Alert.Read

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

.PARAMETER AlertID
    The identifier of the alert to retrieve

.PARAMETER Expand
    Expands related entities inline.

.EXAMPLE
    PS C:\> Get-MdAlert

    Retrieve from Windows Defender ATP the most recent alerts

.EXAMPLE
    PS C:\> Get-MdAlert -AlertID $alertid

    Retrieve from Windows Defender ATP a specific alert

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-alerts?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
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
        $Skip,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetSingleAlert')]
        [string]
        $AlertID,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Expand
    )
    process {
		$__mapping = @{
            'Top' = '$top'
            'Select' = '$select'
            'Filter' = '$filter'
            'Count' = '$count'
            'Orderby' = '$orderby'
            'Skip' = '$skip'
            'Expand' = '$expand'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @('Top','Select','Filter','Count','Orderby','Skip','Expand') -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'alerts'
			Method = 'get'
			RequiredScopes = 'Alert.Read'
			
		}
		if ($AlertID) { $__param.Path += "/$AlertID" }
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}