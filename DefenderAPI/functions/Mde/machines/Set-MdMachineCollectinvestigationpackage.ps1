function Set-MdMachineCollectinvestigationpackage {
<#
.SYNOPSIS
    Actions - Collect investigation package

.DESCRIPTION
    Collect investigation package from a machine

.PARAMETER Comment
    A comment to associate to the collection

.PARAMETER MachineID
    The ID of the machine to collect the investigation from

.EXAMPLE
    PS C:\> Set-MdMachineCollectinvestigationpackage -Comment $comment -MachineID $machineid

    Collect investigation package from a machine

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
			Path = 'machines/{MachineID}/collectInvestigationPackage' -Replace '{MachineID}',$MachineID
			Method = 'post'
			
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}