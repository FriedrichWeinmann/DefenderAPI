﻿function Set-MdMachineactionCancel {
<#
.SYNOPSIS
    Actions - Cancel a single machine action

.DESCRIPTION
    Cancel a specific machine action

.PARAMETER Comment
    A comment to associate to the machine action cancellation

.PARAMETER MachineActionID
    The identifier of the machine action to cancel

.EXAMPLE
    PS C:\> Set-MdMachineactionCancel -Comment $comment -MachineActionID $machineactionid

    Cancel a specific machine action

.LINK
    <unknown>
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Comment,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $MachineActionID
    )
    process {
		$__mapping = @{
            'Comment' = 'Comment'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('Comment') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'machineactions/{MachineActionID}/cancel' -Replace '{MachineActionID}',$MachineActionID
			Method = 'post'
			
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}