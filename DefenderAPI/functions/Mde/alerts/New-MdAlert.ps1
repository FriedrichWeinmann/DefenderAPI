function New-MdAlert {
<#
.SYNOPSIS
    Alerts - Create alert

.DESCRIPTION
    Create Alert based on specific Event

    Scopes required (delegate auth): Alert.ReadWrite

.PARAMETER ReportID
    Report Id of the event

.PARAMETER RecommendedAction
    Recommended action for the Alert

.PARAMETER Category
    Category of the alert

.PARAMETER Title
    Title of the Alert

.PARAMETER Severity
    Severity of the alert.

.PARAMETER Description
    Description of the Alert

.PARAMETER MachineID
    ID of the machine on which the event was identified

.PARAMETER EventTime
    Time of the event as string, e.g. 2018-08-03T16:45:21.7115183Z

.EXAMPLE
    PS C:\> New-MdAlert -Category $category -Title $title -Severity $severity -Description $description

    Create Alert based on specific Event

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/create-alert-by-reference?view=o365-worldwide
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $ReportID,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $RecommendedAction,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Category,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Title,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Severity,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Description,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $MachineID,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $EventTime
    )
    process {
		$__mapping = @{
            'ReportID' = 'Report ID'
            'RecommendedAction' = 'Recommended Action'
            'Category' = 'Category'
            'Title' = 'Title'
            'Severity' = 'Severity'
            'Description' = 'Description'
            'MachineID' = 'Machine ID'
            'EventTime' = 'Event Time'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('ReportID','RecommendedAction','Category','Title','Severity','Description','MachineID','EventTime') -Mapping $__mapping
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