function Get-MdcaAlert {
	<#
	.SYNOPSIS
		List/Retrieve alerts
	
	.DESCRIPTION
		List/Retrieve alerts
		Either a specific alert by ID or a list by filter.
	
	.PARAMETER ID
		ID of the event to retrieve.
	
	.PARAMETER SortField
		Sort results by the specified field.
		By default, results are however sorted as the API backend choses.
		Options: date, severity
	
	.PARAMETER Descending
		By default, results are sorted in an ascending order (if sorting at all).
		This parameter reverses the sorting order.
	
	.PARAMETER Skip
		Skip the first X results.
	
	.PARAMETER Limit
		Return only X results in total.
	
	.PARAMETER Filter
		A custom filter as defined here: https://learn.microsoft.com/en-us/defender-cloud-apps/api-alerts#filters
		Example filter for open alerts of high severity:
		@{
			alertOpen = @{ eq = $true }
			severity = @{ eq = 2 }
		}
	
	.EXAMPLE
		PS C:\> Get-MdcaAlert

		List all alerts.

	.EXAMPLE
		PS C:\> Get-MdcaAlert -ID 909cd095-1677-44eb-98a3-dda1e3c26733

		Retrieve the specified alert
	#>
	[CmdletBinding(DefaultParameterSetName = 'default')]
	param (
		[Parameter(Mandatory = $true, ParameterSetName = 'identity', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[Alias('_id')]
		[string[]]
		$ID,

		[Parameter(ParameterSetName = 'default')]
		[Parameter(ParameterSetName = 'Filter')]
		[ValidateSet('date', 'severity')]
		[string]
		$SortField,

		[Parameter(ParameterSetName = 'default')]
		[Parameter(ParameterSetName = 'Filter')]
		[switch]
		$Descending,

		[Parameter(ParameterSetName = 'default')]
		[Parameter(ParameterSetName = 'Filter')]
		[int]
		$Skip,

		[Parameter(ParameterSetName = 'default')]
		[Parameter(ParameterSetName = 'Filter')]
		[int]
		$Limit,

		[Parameter(ParameterSetName = 'Filter')]
		[hashtable]
		$Filter
	)

	begin {
		Assert-DefenderAPIConnection -Service MDCA -Cmdlet $PSCmdlet
	}
	process {
		#region ID
		if ($ID) {
			foreach ($idString in $ID) {
				try { Invoke-EntraRequest -Service 'DefenderAPI.MDCA' -Path "alerts/$idString" -ErrorAction Stop }
				catch { $PSCmdlet.WriteError($_) }
			}
			return
		}
		#endregion ID

		$body = @{ }
		if ($SortField) {
			$body.sortField = $SortField
			$body.sortDirection = 'asc'
			if ($Descending) { $body.sortDirection = 'dsc' }
		}
		$noPaging = $false
		if ($PSBoundParameters.ContainsKey("Skip")) { $body.skip = $Skip; $noPaging = $true }
		if ($PSBoundParameters.ContainsKey("Limit")) { $body.limit = $Limit; $noPaging = $true }
		if ($Filter) { $body.filters = $Filter }

		do {
			$result = Invoke-EntraRequest -Service 'DefenderAPI.MDCA' -Path alerts -Body $body -Raw
			$body.skip = @($result.data).Count + $body.skip
			$result.data
		}
		while ($result.hasNext -and -not $noPaging)
	}
}