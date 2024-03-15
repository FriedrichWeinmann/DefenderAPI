function Get-MdSoftwareDistribution {
<#
.SYNOPSIS
    Shows the distribution of versions of a software in your organization.

.DESCRIPTION
    Shows the distribution of versions of a software in your organization.

    Scopes required (delegate auth): Software.Read

.PARAMETER Authorization
    

.PARAMETER SoftwareID
    ID of the software for which to retrieve distribution data.

.EXAMPLE
    PS C:\> Get-MdSoftwareDistribution -Authorization $authorization

    <insert description here>

.EXAMPLE
    PS C:\> Get-MdSoftwareDistribution -SoftwareID $softwareid

    Shows the distribution of versions of the specified software in your organization.

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-software-ver-distribution?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetRecommendationById')]
        [string]
        $Authorization,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $SoftwareID
    )
    process {
		$__mapping = @{
            'Authorization' = 'Authorization'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @('Authorization') -Mapping $__mapping
			Path = 'software/{SoftwareID}/distribution' -Replace '{SoftwareID}',$SoftwareID
			Method = 'get'
			RequiredScopes = 'Software.Read'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}