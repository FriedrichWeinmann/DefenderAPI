﻿function Disable-MdMachineIsolation {
<#
.SYNOPSIS
    Undo isolation of a device.

.DESCRIPTION
    Undo isolation of a device.

    Scopes required (delegate auth): Machine.Isolate

.PARAMETER Comment
    A comment to associate to the unisolation

.PARAMETER MachineID
    The ID of the machine to unisolate

.EXAMPLE
    PS C:\> Disable-MdMachineIsolation -Comment $comment -MachineID $machineid

    Unisolate a machine from network

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/unisolate-machine?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Comment,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $MachineID
    )
    process {
		$__mapping = @{
            'Comment' = 'Comment'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('Comment') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'machines/{MachineID}/unisolate' -Replace '{MachineID}',$MachineID
			Method = 'post'
			RequiredScopes = 'Machine.Isolate'
			Service = 'DefenderAPI.Endpoint'
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-EntraRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}