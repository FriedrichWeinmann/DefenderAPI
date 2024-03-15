function Get-MdSoftwareMachinereference {
<#
.SYNOPSIS
    Retrieve a list of device references that has this software installed.

.DESCRIPTION
    Retrieve a list of device references that has this software installed.

    Scopes required (delegate auth): Software.Read

.PARAMETER SoftwareID
    ID of the software for which to retrieve devices that have it installed.

.EXAMPLE
    PS C:\> Get-MdSoftwareMachinereference -SoftwareID $softwareid

    Retrieve a list of device references that has this software installed.

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-machines-by-software?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $SoftwareID
    )
    process {
		$__mapping = @{

		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'software/{SoftwareID}/machineReferences' -Replace '{SoftwareID}',$SoftwareID
			Method = 'get'
			RequiredScopes = 'Software.Read'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}