function Set-MdMachineRunantivirusscan {
<#
.SYNOPSIS
    Actions - Run antivirus scan

.DESCRIPTION
    Initiate Windows Defender Antivirus scan on a machine

.PARAMETER Comment
    A comment to associate to the scan request

.PARAMETER ScanType
    Type of scan to perform. Allowed values are 'Quick' or 'Full'

.PARAMETER MachineID
    The ID of the machine to scan

.EXAMPLE
    PS C:\> Set-MdMachineRunantivirusscan -Comment $comment -MachineID $machineid

    Initiate Windows Defender Antivirus scan on a machine

.LINK
    <unknown>
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Comment,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $ScanType,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $MachineID
    )
    process {
		$__mapping = @{
            'Comment' = 'Comment'
            'ScanType' = 'Scan Type'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('Comment','ScanType') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'machines/{MachineID}/runAntiVirusScan' -Replace '{MachineID}',$MachineID
			Method = 'post'
			
			Service = 'DefenderAPI.Endpoint'
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-EntraRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}