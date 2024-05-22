function Get-MdcaSubnet {
	<#
	.SYNOPSIS
		Returns the available / configured subnets.
	
	.DESCRIPTION
		Returns the available / configured subnets.

		Note: Filter parameters are currently non-functional.
	
	.PARAMETER ID
		ID of a subnet to retrieve.
	
	.PARAMETER SortField
		Field by which to sort the results.
	
	.PARAMETER Descending
		Whether to sort in a descending order
	
	.PARAMETER Skip
		Skip the first X results
		Using this parameter disables the automatic paging feature.
	
	.PARAMETER Limit
		Maximum number of subnets to return.
		Using this parameter disables the automatic paging feature.
	
	.PARAMETER Filter
		A full filter to specify with the request
	
	.PARAMETER IncludeCategory
		Only return subnets that contain any of the specified categories.
	
	.PARAMETER ExcludeCategory
		Do not return subnets that contain any of the specified categories.
	
	.PARAMETER IncludeTag
		Only return subnets that contain any of the specified tags.
	
	.PARAMETER ExcludeTag
		Do not return subnets that contain any of the specified tags.
	
	.PARAMETER BuiltIn
		Specify whether built-in only or custom only subnets should be returned
	
	.EXAMPLE
		PS C:\> Get-MdcaSubnet

		Returns all subnets from MDCA
	#>
	[CmdletBinding(DefaultParameterSetName = 'default')]
	Param (
		[Parameter(Mandatory = $true, ParameterSetName = 'identity', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[Alias('_id')]
		[string[]]
		$ID,

		[ValidateSet('category', 'tags', 'name')]
		[string]
		$SortField,

		[switch]
		$Descending,

		[int]
		$Skip,

		[int]
		$Limit,

		[Parameter(ParameterSetName = 'Filter')]
		[hashtable]
		$Filter,

		[Parameter(ParameterSetName = 'Condition')]
		[SubnetCategory[]]
		$IncludeCategory,

		[Parameter(ParameterSetName = 'Condition')]
		[SubnetCategory[]]
		$ExcludeCategory,

		[Parameter(ParameterSetName = 'Condition')]
		[string[]]
		$IncludeTag,

		[Parameter(ParameterSetName = 'Condition')]
		[string[]]
		$ExcludeTag,

		[Parameter(ParameterSetName = 'Condition')]
		[bool]
		$BuiltIn
	)
	
	begin {
		Assert-DefenderAPIConnection -Service MDCA -Cmdlet $PSCmdlet
	}
	process {

		if ($ID) {
			foreach ($idString in $ID) {
				try { Invoke-EntraRequest -Service 'DefenderAPI.MDCA' -Path "subnet/$idString" -ErrorAction Stop | ConvertFrom-RestSubnet }
				catch { $PSCmdlet.WriteError($_) }
			}
			return
		}

		$body = @{ }
		if ($SortField) {
			$body.sortField = $SortField
			$body.sortDirection = 'asc'
			if ($Descending) { $body.sortDirection = 'dsc' }
		}
		$noPaging = $false
		if ($PSBoundParameters.ContainsKey("Skip")) { $body.skip = $Skip; $noPaging = $true }
		if ($PSBoundParameters.ContainsKey("Limit")) { $body.limit = $Limit; $noPaging = $true }

		#region Filters
		# TODO: Figure out why filters are ignored
		switch ($PSCmdlet.ParameterSetName) {
			'Filter' { $body.filters = $Filter }
			'Condition' {
				$filterHash = @{}
				if ($IncludeCategory -or $ExcludeCategory) {
					$filterHash.category = @{}
					if ($IncludeCategory) {
						$filterHash.category.eq = @($IncludeCategory | ForEach-Object { [int]$_ })
					}
					if ($ExcludeCategory) {
						$filterHash.category.neq = @($ExcludeCategory | ForEach-Object { [int]$_ })
					}
				}
				if ($IncludeTag -or $ExcludeTag) {
					$filterHash.tags = @{ }
					if ($IncludeTag) { $filterHash.tags.eq = $IncludeTag }
					if ($ExcludeTag) { $filterHash.tags.neq = $ExcludeTag }
				}
				if ($PSBoundParameters.ContainsKey("BuiltIn")) {
					$filterHash.builtIn = @{ eq = $BuiltIn }
				}
				$body.filters = $filterHash
			}
		}
		#endregion Filters

		do {
			$result = Invoke-EntraRequest -Service 'DefenderAPI.MDCA' -Path 'subnet/' -Body $body -Raw
			$body.skip = @($result.data).Count + $body.skip
			$result.data | ConvertFrom-RestSubnet
		}
		while ($result.hasNext -and -not $noPaging)
	}
}