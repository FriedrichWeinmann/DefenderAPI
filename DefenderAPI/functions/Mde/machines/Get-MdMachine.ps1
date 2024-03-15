function Get-MdMachine {
<#
.SYNOPSIS
    Machines - Get list of machines

.DESCRIPTION
    Retrieve from Windows Defender ATP the most recent machines

    Scopes required (delegate auth): Machine.Read

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

.PARAMETER MachineID
    The identifier of the machine to retrieve

.EXAMPLE
    PS C:\> Get-MdMachine

    Retrieve from Windows Defender ATP the most recent machines

.EXAMPLE
    PS C:\> Get-MdMachine -MachineID $machineid

    Retrieve from Windows Defender ATP a specific machine

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-machines?view=o365-worldwide
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

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetSingleMachine')]
        [Alias('Id')]
        [string]
        $MachineID
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
			Path = 'machines'
			Method = 'get'
			RequiredScopes = 'Machine.Read'
			
		}
		if ($MachineID) { $__param.Path += "/$MachineID" }
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}