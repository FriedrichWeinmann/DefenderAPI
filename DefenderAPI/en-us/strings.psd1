# This is where the strings go, that are written by
# Write-PSFMessage, Stop-PSFFunction or the PSFramework validation scriptblocks
@{
	'Connect-DefenderAPI.Error.MdcaNoTenant'  = 'Error connecting to MDCA: Must specify the "-TenantName" parameter!'

	'New-MdcaSubnet.Create'                   = 'Creating a new subnet: {0}' # $Name

	'Remove-MdcaSubnet.Deleting'              = 'Deleting subnet {0}' # $subnetID

	'Set-MdcaSubnet.DuplicateName'            = 'Error updating {0}: Duplicate name detected ({1} / {2}). The name of a subnet must be changed on each request.' # $ID, $Name, $subnet.name
	'Set-MdcaSubnet.Modify'                   = 'Updating subnet {1} ({0})' # $subnet.name, $Name
	'Set-MdcaSubnet.NotFound'                 = 'Unable to find subnet {0}. Ensure the subnet you are trying to modify actually exists.' # $ID

}