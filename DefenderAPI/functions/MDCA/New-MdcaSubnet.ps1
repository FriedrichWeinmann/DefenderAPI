function New-MdcaSubnet {
	<#
	.SYNOPSIS
		Create a new MDCA subnet
	
	.DESCRIPTION
		Create a new MDCA subnet
	
	.PARAMETER Name
		Name of the subnet to create
	
	.PARAMETER Category
		The category the subnet should have
	
	.PARAMETER Subnets
		IPRanges / subnets that should be part of this subnet
	
	.PARAMETER Organization
		The organization this subnet is part of
	
	.PARAMETER Tag
		Any tags this subnet should have.
	
	.PARAMETER EnableException
		This parameters disables user-friendly warnings and enables the throwing of exceptions.
		This is less user friendly, but allows catching exceptions in calling scripts.

	.PARAMETER WhatIf
		if this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.

	.PARAMETER Confirm
		If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.
	
	.EXAMPLE
		PS C:\> New-MdcaSubnet -Name "europe" -Category Corporate -Subnets '10.1.0.0/16' -Organization ContosoEU -Tag europe, intranet
		
		Creates a new MDCA subnet
	#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments','')]
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param (
		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
		[string]
		$Name,

		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
		[SubnetCategory]
		$Category,

		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
		[string[]]
		$Subnets,

		[Parameter(ValueFromPipelineByPropertyName = $true)]
		[string]
		$Organization,

		[Parameter(ValueFromPipelineByPropertyName = $true)]
		[Alias('tags')]
		[string[]]
		$Tag,

		[switch]
		$EnableException
	)
	
	begin {
		Assert-DefenderAPIConnection -Service MDCA -Cmdlet $PSCmdlet
	}
	process {
		$body = @{
			name     = $Name
			category = [int]$Category
			subnets  = $Subnets
		}
		if ($Organization) { $body.organization = $Organization }
		if ($Tag) { $body.tags = $Tag }

		Invoke-PSFProtectedCommand -ActionString 'New-MdcaSubnet.Create' -ActionStringValues $Name -Target $Name -ScriptBlock {
			$newID = Invoke-EntraRequest -Service 'DefenderAPI.MDCA' -Method Post -Path "subnet/create_rule/" -Body $body
		} -EnableException $EnableException -PSCmdlet $PSCmdlet

		Get-MdcaSubnet -ID $newID
	}
}