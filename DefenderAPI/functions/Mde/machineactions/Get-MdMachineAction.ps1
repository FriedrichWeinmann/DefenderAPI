function Get-MdMachineAction {
<#
.SYNOPSIS
    Actions - Get list of machine actions

.DESCRIPTION
    Retrieve from Windows Defender ATP the most recent machine actions

    Scopes required (delegate auth): Machine.Read

.PARAMETER Top
    Returns only the first n results.

.PARAMETER Orderby
    Sorts the results.

.PARAMETER Select
    Selects which properties to include in the response, defaults to all.

.PARAMETER Filter
    Filters the results, using OData syntax.

.PARAMETER MachineActionID
    The identifier of the machine action to retrieve

.PARAMETER Count
    Includes a count of the matching results in the response.

.PARAMETER Skip
    Skips the first n results.

.EXAMPLE
    PS C:\> Get-MdMachineAction -MachineActionID $machineactionid

    Retrieve from Windows Defender ATP a specific machine action

.EXAMPLE
    PS C:\> Get-MdMachineAction

    Retrieve from Windows Defender ATP the most recent machine actions

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-machineaction-object?view=o365-worldwide
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

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetSingleMachineAction')]
        [string]
        $MachineActionID,

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
            'Count' = '$count'
            'Skip' = '$skip'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @('Top','Orderby','Select','Filter','Count','Skip') -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'machineactions'
			Method = 'get'
			RequiredScopes = 'Machine.Read'
			Service = 'DefenderAPI.Endpoint'
		}
		if ($MachineActionID) { $__param.Path += "/$MachineActionID" }
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-EntraRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}