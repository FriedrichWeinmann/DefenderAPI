function New-MdIndicator {
<#
.SYNOPSIS
    Indicators - Submit a new indicator

.DESCRIPTION
    Submit a new indicator

    Scopes required (delegate auth): Ti.ReadWrite

.PARAMETER Title
    The indicator title

.PARAMETER IndicatorType
    The type of the indicator

.PARAMETER Description
    The indicator description

.PARAMETER ExpirationTime
    The expiration time of the indicator

.PARAMETER IndicatorValue
    The value of the indicator

.PARAMETER Severity
    The severity of the indicator

.PARAMETER Application
    The application associated with the indicator

.PARAMETER RecommendedActions
    Recommended actions for the indicator

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
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Title,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $IndicatorType,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Description,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $ExpirationTime,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $IndicatorValue,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Severity,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Application,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $RecommendedActions,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Action
    )
    process {
		$__mapping = @{
            'Title' = 'Title'
            'IndicatorType' = 'Indicator type'
            'Description' = 'Description'
            'ExpirationTime' = 'Expiration time'
            'IndicatorValue' = 'Indicator Value'
            'Severity' = 'Severity'
            'Application' = 'Application'
            'RecommendedActions' = 'Recommended Actions'
            'Action' = 'Action'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('Title','IndicatorType','Description','ExpirationTime','IndicatorValue','Severity','Application','RecommendedActions','Action') -Mapping $__mapping
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