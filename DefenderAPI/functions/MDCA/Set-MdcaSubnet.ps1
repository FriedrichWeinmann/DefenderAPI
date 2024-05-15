function Set-MdcaSubnet {
	<#
	.SYNOPSIS
		Updates an existing MDCA subnet.
	
	.DESCRIPTION
		Updates an existing MDCA subnet.

		All properties will be overwritten each time!
		Not specifying tags equals to removing all existing tags.

		Note: Each time you update a subnet you must change its name.
	
	.PARAMETER ID
		ID of the subnet to modify.
	
	.PARAMETER Name
		The name to assign to the subnet.
		Note: Each time you update a subnet you must change its name.
	
	.PARAMETER Category
		The category the subnet should have.
	
	.PARAMETER Subnets
		The IP ranges assigned to this subnet
	
	.PARAMETER Organization
		The Organization the subnet is part of
	
	.PARAMETER Tag
		Any tags the subnet should include
	
	.PARAMETER PassThru
		Whether the result should be returned as output
	
	.PARAMETER EnableException
		This parameters disables user-friendly warnings and enables the throwing of exceptions.
		This is less user friendly, but allows catching exceptions in calling scripts.

	.PARAMETER WhatIf
		if this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.

	.PARAMETER Confirm
		If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.
	
	.EXAMPLE
		PS C:\> Get-MdcaSubnet | Where-Object Name -match "^na_{0,1}$" | Set-MdcaSubnet -Subnets '66.66.66.0/24' -Name { ($_.Name + "_") -replace "__" }
		
		Updates the subnet na to _only_ include the iprange '66.66.66.0/24'.
		Alternates the name between "na" and "na_"
	#>
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param (
		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
		[Alias('_id')]
		[string]
		$ID,

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
		$PassThru,

		[switch]
		$EnableException
	)
	
	begin {
		Assert-DefenderAPIConnection -Service MDCA -Cmdlet $PSCmdlet
	}
	process {
		try { $subnet = Get-MdcaSubnet -ID $ID -ErrorAction Stop }
		catch {
			Stop-PSFFunction -String 'Set-MdcaSubnet.NotFound' -StringValues $ID -EnableException $EnableException
			return
		}

		if ($subnet.name -eq $Name) {
			Stop-PSFFunction -String 'Set-MdcaSubnet.DuplicateName' -StringValues $ID, $Name, $subnet.name -EnableException $EnableException
			return
		}

		$body = @{
			name = $Name
			category = [int]$Category
			subnets = $Subnets
		}
		if ($Organization) { $body.organization = $Organization }
		if ($Tag) { $body.tags = $Tag }

		Invoke-PSFProtectedCommand -ActionString 'Set-MdcaSubnet.Modify' -ActionStringValues $subnet.name, $Name -Target $ID -ScriptBlock {
			$null = Invoke-EntraRequest -Service 'DefenderAPI.MDCA' -Method Post -Path "subnet/$ID/update_rule/" -Body $body
		} -EnableException $EnableException -PSCmdlet $PSCmdlet

		if ($PassThru) {
			Get-MdcaSubnet -ID $ID
		}
	}
}