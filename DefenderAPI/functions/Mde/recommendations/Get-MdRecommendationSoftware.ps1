function Get-MdRecommendationSoftware {
<#
.SYNOPSIS
    Retrieves a security recommendation related to a specific software.

.DESCRIPTION
    Retrieves a security recommendation related to a specific software.

    Scopes required (delegate auth): SecurityRecommendation.Read

.PARAMETER RecommendationID
    ID of the recommendation for which to retrieve software information.

.EXAMPLE
    PS C:\> Get-MdRecommendationSoftware -RecommendationID $recommendationid

    Retrieves a security recommendation related to a specific software.

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/list-recommendation-software?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $RecommendationID
    )
    process {
		$__mapping = @{

		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'recommendations/{RecommendationID}/software' -Replace '{RecommendationID}',$RecommendationID
			Method = 'get'
			RequiredScopes = 'SecurityRecommendation.Read'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}