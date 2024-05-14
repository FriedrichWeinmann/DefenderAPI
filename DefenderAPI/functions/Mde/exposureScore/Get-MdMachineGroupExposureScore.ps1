function Get-MdMachineGroupExposureScore {
<#
.SYNOPSIS
    Retrieves a collection of alerts related to a given domain address.

.DESCRIPTION
    Retrieves a collection of alerts related to a given domain address.

    Scopes required (delegate auth): Score.Read



.EXAMPLE
    PS C:\> Get-MdMachineGroupExposureScore

    <insert description here>

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-machine-group-exposure-score?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (

    )
    process {
		$__mapping = @{

		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'exposureScore/byMachineGroups'
			Method = 'get'
			RequiredScopes = 'Score.Read'
			Service = 'DefenderAPI.Endpoint'
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-EntraRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}