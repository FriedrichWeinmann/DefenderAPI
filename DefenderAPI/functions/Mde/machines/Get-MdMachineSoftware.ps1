﻿function Get-MdMachineSoftware {
<#
.SYNOPSIS
    Retrieves a collection of installed software related to a given device ID.

.DESCRIPTION
    Retrieves a collection of installed software related to a given device ID.

    Scopes required (delegate auth): Software.Read

.PARAMETER MachineID
    ID of the machine to read the installed software from.

.EXAMPLE
    PS C:\> Get-MdMachineSoftware -MachineID $machineid

    <insert description here>

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-installed-software?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $MachineID
    )
    process {
		$__mapping = @{

		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'machines/{MachineID}/software' -Replace '{MachineID}',$MachineID
			Method = 'get'
			RequiredScopes = 'Software.Read'
			Service = 'DefenderAPI.Endpoint'
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-EntraRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}