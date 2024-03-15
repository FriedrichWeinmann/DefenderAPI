function New-MdIndicator {
<#
.SYNOPSIS
    Indicators - Submit a new indicator

.DESCRIPTION
    Submit a new indicator

    Scopes required (delegate auth): Ti.ReadWrite

.PARAMETER ExpirationTime
    The expiration time of the indicator

.PARAMETER RecommendedActions
    Recommended actions for the indicator

.PARAMETER Action
    The action that will be taken if the indicator will be discovered in the organization

.PARAMETER IndicatorType
    The type of the indicator

.PARAMETER Severity
    The severity of the indicator

.PARAMETER Description
    The indicator description

.PARAMETER Title
    The indicator title

.PARAMETER Application
    The application associated with the indicator

.PARAMETER IndicatorValue
    The value of the indicator

.EXAMPLE
    PS C:\> New-MdIndicator -Action $action -Description $description -Title $title

    Submit a new indicator

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/post-ti-indicator?view=o365-worldwide
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $ExpirationTime,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $RecommendedActions,

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

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Title,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Application,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $IndicatorValue
    )
    process {
		$__mapping = @{
            'ExpirationTime' = 'Expiration time'
            'RecommendedActions' = 'Recommended Actions'
            'Action' = 'Action'
            'IndicatorType' = 'Indicator type'
            'Severity' = 'Severity'
            'Description' = 'Description'
            'Title' = 'Title'
            'Application' = 'Application'
            'IndicatorValue' = 'Indicator Value'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('ExpirationTime','RecommendedActions','Action','IndicatorType','Severity','Description','Title','Application','IndicatorValue') -Mapping $__mapping
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