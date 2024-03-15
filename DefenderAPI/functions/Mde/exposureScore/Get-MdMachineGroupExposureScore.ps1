﻿function Get-MdMachineGroupExposureScore {
<#
.SYNOPSIS
    Retrieves a collection of alerts related to a given domain address.

.DESCRIPTION
    Retrieves a collection of alerts related to a given domain address.

    Scopes required (delegate auth): Score.Read

.PARAMETER Authorization
    

.EXAMPLE
    PS C:\> Get-MdMachineGroupExposureScore

    <insert description here>

.EXAMPLE
    PS C:\> Get-MdMachineGroupExposureScore -Authorization $authorization

    <insert description here>

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-machine-group-exposure-score?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetProductById')]
        [string]
        $Authorization
    )
    process {
		$__mapping = @{
            'Authorization' = 'Authorization'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @('Authorization') -Mapping $__mapping
			Path = 'exposureScore/byMachineGroups'
			Method = 'get'
			RequiredScopes = 'Score.Read'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}