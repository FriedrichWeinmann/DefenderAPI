function Remove-MdcaSubnet {
	<#
	.SYNOPSIS
		Remove a MDCA subnet
	
	.DESCRIPTION
		Remove a MDCA subnet
	
	.PARAMETER ID
		ID of the subnet to remove
	
	.PARAMETER EnableException
		This parameters disables user-friendly warnings and enables the throwing of exceptions.
		This is less user friendly, but allows catching exceptions in calling scripts.

	.PARAMETER WhatIf
		if this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.

	.PARAMETER Confirm
		If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.
	
	.EXAMPLE
		PS C:\> Get-MdcaSubnet | Where-Object Name -eq na | Remove-MdcaSubnet

		Removes the subnet named "na"
	#>
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[Alias('_id')]
		[string[]]
		$ID,

		[switch]
		$EnableException
	)
	
	begin {
		Assert-DefenderAPIConnection -Service MDCA -Cmdlet $PSCmdlet
	}
	process {
		foreach ($subnetID in $ID) {
			Invoke-PSFProtectedCommand -ActionString 'Remove-MdcaSubnet.Deleting' -ActionStringValues $subnetID -Target $subnetID -ScriptBlock {
				$null = Invoke-EntraRequest -Service 'DefenderAPI.MDCA' -Method Delete -Path "subnet/$subnetID" -ErrorAction Stop
			} -EnableException $EnableException -Continue -PSCmdlet $PSCmdlet
		}
	}
}
