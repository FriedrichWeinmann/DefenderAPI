function ConvertFrom-RestSubnet {
	<#
	.SYNOPSIS
		Converts subnet objects to look nice.
	
	.DESCRIPTION
		Converts subnet objects to look nice.
	
	.PARAMETER InputObject
		The rest response representing a subnet
	
	.EXAMPLE
		PS C:\> Invoke-RestRequest -Path "subnet/$idString" -ErrorAction Stop | ConvertFrom-RestSubnet

		Retrieves the specified subnet and converts it into something userfriendly
	#>
	[CmdletBinding()]
	param (
		[Parameter(ValueFromPipeline = $true)]
		$InputObject
	)

	process {
		if (-not $InputObject) { return }

		[PSCustomObject]@{
			PSTypeName      = 'DefenderAPI.Mdca.Subnet'
			ID              = $InputObject._id
			Name            = $InputObject.Name
			Subnets         = $InputObject.subnets.originalString
			SubnetsOriginal = $InputObject.subnets
			Location        = $InputObject.location
			Organization    = $InputObject.organization
			Tags            = $InputObject.tags.name
			TagsOriginal    = $InputObject.tags
			Category        = $InputObject.Category -as [SubnetCategory]
			LastModified    = $InputObject.LastModified
		}
	}
}