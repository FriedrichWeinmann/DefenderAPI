function New-MdAlert {
<#
.SYNOPSIS
    Alerts - Create alert

.DESCRIPTION
    Create Alert based on specific Event

    Scopes required (delegate auth): Alert.ReadWrite

.PARAMETER Category
    Category of the alert

.PARAMETER Severity
    Severity of the alert.

.PARAMETER Description
    Description of the Alert

.PARAMETER RecommendedAction
    Recommended action for the Alert

.PARAMETER EventTime
    Time of the event as string, e.g. 2018-08-03T16:45:21.7115183Z

.PARAMETER MachineID
    ID of the machine on which the event was identified

.PARAMETER ReportID
    Report Id of the event

.PARAMETER Title
    Title of the Alert

.EXAMPLE
    PS C:\> New-MdAlert -Category $category -Severity $severity -Description $description -Title $title

    Create Alert based on specific Event

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/create-alert-by-reference?view=o365-worldwide
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Category,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Severity,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Description,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $RecommendedAction,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $EventTime,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $MachineID,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $ReportID,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Title
    )
    process {
		$__mapping = @{
            'Category' = 'Category'
            'Severity' = 'Severity'
            'Description' = 'Description'
            'RecommendedAction' = 'Recommended Action'
            'EventTime' = 'Event Time'
            'MachineID' = 'Machine ID'
            'ReportID' = 'Report ID'
            'Title' = 'Title'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('Category','Severity','Description','RecommendedAction','EventTime','MachineID','ReportID','Title') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'alerts/createAlertByReference'
			Method = 'post'
			RequiredScopes = 'Alert.ReadWrite'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}