function Get-MdVulnerableMachine {
<#
.SYNOPSIS
    Retrieves a list of devices affected by a vulnerability.

.DESCRIPTION
    Retrieves a list of devices affected by a vulnerability.

    Scopes required (delegate auth): Vulnerability.Read

.PARAMETER VulnerabilityID
    ID of the vulnerability for which to retrieve affected devices.

.EXAMPLE
    PS C:\> Get-MdVulnerableMachine -VulnerabilityID $vulnerabilityid

    Retrieves a list of devices affected by a vulnerability.

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-machines-by-vulnerability?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $VulnerabilityID
    )
    process {
		$__mapping = @{

		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'vulnerabilities/{VulnerabilityID}/machineReferences' -Replace '{VulnerabilityID}',$VulnerabilityID
			Method = 'get'
			RequiredScopes = 'Vulnerability.Read'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}