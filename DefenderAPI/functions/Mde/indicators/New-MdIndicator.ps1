function New-MdIndicator {
<#
.SYNOPSIS
    Indicators - Submit a new indicator

.DESCRIPTION
    Submit a new indicator

    Scopes required (delegate auth): Ti.ReadWrite

.PARAMETER IndicatorType
    The type of the indicator

.PARAMETER Title
    The indicator title

.PARAMETER ExpirationTime
    The expiration time of the indicator

.PARAMETER Application
    The application associated with the indicator

.PARAMETER Severity
    The severity of the indicator

.PARAMETER RecommendedActions
    Recommended actions for the indicator

.PARAMETER IndicatorValue
    The value of the indicator

.PARAMETER Description
    The indicator description

.PARAMETER Action
    The action that will be taken if the indicator will be discovered in the organization

.EXAMPLE
    PS C:\> New-MdIndicator -Title $title -Description $description -Action $action

    Submit a new indicator

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/post-ti-indicator?view=o365-worldwide
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $IndicatorType,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Title,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $ExpirationTime,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Application,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Severity,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $RecommendedActions,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $IndicatorValue,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Description,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Action
    )
    process {
		$__mapping = @{
            'IndicatorType' = 'Indicator type'
            'Title' = 'Title'
            'ExpirationTime' = 'Expiration time'
            'Application' = 'Application'
            'Severity' = 'Severity'
            'RecommendedActions' = 'Recommended Actions'
            'IndicatorValue' = 'Indicator Value'
            'Description' = 'Description'
            'Action' = 'Action'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('IndicatorType','Title','ExpirationTime','Application','Severity','RecommendedActions','IndicatorValue','Description','Action') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'indicators'
			Method = 'post'
			RequiredScopes = 'Ti.ReadWrite'
			Service = 'DefenderAPI.Endpoint'
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-EntraRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}