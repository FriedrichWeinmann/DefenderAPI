function Set-MdMachineRestrictcodeexecution {
<#
.SYNOPSIS
    Actions - Restrict app execution

.DESCRIPTION
    Restrict execution of all applications on the machine except a predefined set

.PARAMETER MachineID
    The ID of the machine to restrict

.PARAMETER Comment
    A comment to associate to the restriction

.EXAMPLE
    PS C:\> Set-MdMachineRestrictcodeexecution -MachineID $machineid -Comment $comment

    Restrict execution of all applications on the machine except a predefined set

.LINK
    <unknown>
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $MachineID,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Comment
    )
    process {
		$__mapping = @{
            'Comment' = 'Comment'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('Comment') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'machines/{MachineID}/restrictCodeExecution' -Replace '{MachineID}',$MachineID
			Method = 'post'
			
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}