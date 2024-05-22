function Get-MdRecommendationMachineReference {
<#
.SYNOPSIS
    Retrieves a list of devices associated with the security recommendation.

.DESCRIPTION
    Retrieves a list of devices associated with the security recommendation.

    Scopes required (delegate auth): SecurityRecommendation.Read

.PARAMETER RecommendationID
    ID of the recommendation for which to retrieve devices.

.EXAMPLE
    PS C:\> Get-MdRecommendationMachineReference -RecommendationID $recommendationid

    Retrieves a list of devices associated with the security recommendation.

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-recommendation-machines?view=o365-worldwide
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
			Path = 'recommendations/{RecommendationID}/machineReferences' -Replace '{RecommendationID}',$RecommendationID
			Method = 'get'
			RequiredScopes = 'SecurityRecommendation.Read'
			Service = 'DefenderAPI.Endpoint'
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-EntraRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}