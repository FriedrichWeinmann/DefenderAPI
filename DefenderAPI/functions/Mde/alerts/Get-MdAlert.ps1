function Get-MdAlert {
<#
.SYNOPSIS
    Alerts - Get list of alerts

.DESCRIPTION
    Retrieve from Windows Defender ATP the most recent alerts

    Scopes required (delegate auth): Alert.Read

.PARAMETER Top
    Returns only the first n results.

.PARAMETER AlertID
    The identifier of the alert to retrieve

.PARAMETER Orderby
    Sorts the results.

.PARAMETER Select
    Selects which properties to include in the response, defaults to all.

.PARAMETER Filter
    Filters the results, using OData syntax.

.PARAMETER Expand
    Expands related entities inline.

.PARAMETER Skip
    Skips the first n results.

.PARAMETER Count
    Includes a count of the matching results in the response.

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

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetSingleAlert')]
        [string]
        $AlertID,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Orderby,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string[]]
        $Select,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Filter,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Expand,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [int32]
        $Skip,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [boolean]
        $Count
    )
    process {
		$__mapping = @{
            'Top' = '$top'
            'Orderby' = '$orderby'
            'Select' = '$select'
            'Filter' = '$filter'
            'Expand' = '$expand'
            'Skip' = '$skip'
            'Count' = '$count'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @('Top','Orderby','Select','Filter','Expand','Skip','Count') -Mapping $__mapping
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