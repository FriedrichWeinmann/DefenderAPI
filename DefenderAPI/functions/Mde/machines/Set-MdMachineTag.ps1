﻿function Set-MdMachineTag {
<#
.SYNOPSIS
    Machines - Tag machine

.DESCRIPTION
    Add or remove a tag to/from a machine

.PARAMETER Action
    The action to perform. Value should be one of 'Add' (to add a tag) or 'Remove' (to remove a tag)

.PARAMETER MachineID
    The ID of the machine to which the tag should be added or removed

.PARAMETER Value
    The tag to add or remove

.EXAMPLE
    PS C:\> Set-MdMachineTag -Action $action -MachineID $machineid -Value $value

    Add or remove a tag to/from a machine

.LINK
    <unknown>
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Action,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $MachineID,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Value
    )
    process {
		$__mapping = @{
            'Action' = 'Action'
            'Value' = 'Value'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('Action','Value') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'machines/{MachineID}/tags' -Replace '{MachineID}',$MachineID
			Method = 'post'
			
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}