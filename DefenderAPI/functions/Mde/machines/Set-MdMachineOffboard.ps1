function Set-MdMachineOffboard {
<#
.SYNOPSIS
    Actions - Offboard machine from Microsoft Defender ATP

.DESCRIPTION
    Offboard machine from Microsoft Defender ATP

.PARAMETER Comment
    A comment to associate to the offboarding action

.PARAMETER MachineID
    The ID of the machine to offboard

.EXAMPLE
    PS C:\> Set-MdMachineOffboard -Comment $comment -MachineID $machineid

    Offboard machine from Microsoft Defender ATP

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
			Path = 'machines/{MachineID}/offboard' -Replace '{MachineID}',$MachineID
			Method = 'post'
			
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}