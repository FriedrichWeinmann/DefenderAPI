function Get-MdRecommendation {
<#
.SYNOPSIS
    Retrieves a list of all security recommendations affecting the organization.

.DESCRIPTION
    Retrieves a list of all security recommendations affecting the organization.

    Scopes required (delegate auth): SecurityRecommendation.Read

.PARAMETER RecommendationID
    ID of the recommendation to retrieve.

.EXAMPLE
    PS C:\> Get-MdRecommendation

    Lists all security recommendations

.EXAMPLE
    PS C:\> Get-MdRecommendation -RecommendationID $recommendationid

    <insert description here>

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-all-recommendations?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetRecommendationById')]
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
			Path = 'recommendations'
			Method = 'get'
			RequiredScopes = 'SecurityRecommendation.Read'
			
		}
		if ($RecommendationID) { $__param.Path += "/$RecommendationID" }
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}