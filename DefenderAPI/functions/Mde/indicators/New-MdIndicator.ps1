function New-MdIndicator {
<#
.SYNOPSIS
    Indicators - Submit a new indicator

.DESCRIPTION
    Submit a new indicator

    Scopes required (delegate auth): Ti.ReadWrite

.PARAMETER Action
    The action that will be taken if the indicator will be discovered in the organization

.PARAMETER IndicatorType
    The type of the indicator

.PARAMETER Severity
    The severity of the indicator

.PARAMETER Description
    The indicator description

.PARAMETER Application
    The application associated with the indicator

.PARAMETER RecommendedActions
    Recommended actions for the indicator

.PARAMETER IndicatorValue
    The value of the indicator

.PARAMETER ExpirationTime
    The expiration time of the indicator

.PARAMETER Title
    The indicator title

.EXAMPLE
    PS C:\> New-MdIndicator -Action $action -Description $description -Title $title

    Submit a new indicator

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/post-ti-indicator?view=o365-worldwide
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Action,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $IndicatorType,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Severity,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Description,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Application,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $RecommendedActions,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $IndicatorValue,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $ExpirationTime,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Title
    )
    process {
		$__mapping = @{
            'Action' = 'Action'
            'IndicatorType' = 'Indicator type'
            'Severity' = 'Severity'
            'Description' = 'Description'
            'Application' = 'Application'
            'RecommendedActions' = 'Recommended Actions'
            'IndicatorValue' = 'Indicator Value'
            'ExpirationTime' = 'Expiration time'
            'Title' = 'Title'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('Action','IndicatorType','Severity','Description','Application','RecommendedActions','IndicatorValue','ExpirationTime','Title') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'indicators'
			Method = 'post'
			RequiredScopes = 'Ti.ReadWrite'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}