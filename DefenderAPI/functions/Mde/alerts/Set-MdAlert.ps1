﻿function Set-MdAlert {
<#
.SYNOPSIS
    Alerts - Update alert

.DESCRIPTION
    Update a Windows Defender ATP alert

    Scopes required (delegate auth): Alert.ReadWrite

.PARAMETER Classification
    Classification of the alert. One of 'Unknown', 'FalsePositive', 'TruePositive'

.PARAMETER AssignedTo
    Person to assign the alert to

.PARAMETER Determination
    The determination of the alert. One of 'NotAvailable', 'Apt', 'Malware', 'SecurityPersonnel', 'SecurityTesting', 'UnwantedSoftware', 'Other'

.PARAMETER Comment
    A comment to associate to the alert

.PARAMETER Status
    Status of the alert. One of 'New', 'InProgress' and 'Resolved'

.PARAMETER AlertID
    The identifier of the alert to update

.PARAMETER Confirm
	If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.

.PARAMETER WhatIf
	If this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.

.EXAMPLE
    PS C:\> Set-MdAlert -AlertID $alertid

    Update a Windows Defender ATP alert

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/update-alert?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default', SupportsShouldProcess = $true)]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Classification,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $AssignedTo,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Determination,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Comment,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Status,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $AlertID
    )
    process {
		$__mapping = @{
            'Classification' = 'Classification'
            'AssignedTo' = 'Assigned to'
            'Determination' = 'Determination'
            'Comment' = 'Comment'
            'Status' = 'Status'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('Classification','AssignedTo','Determination','Comment','Status') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'alerts/{AlertID}' -Replace '{AlertID}',$AlertID
			Method = 'patch'
			RequiredScopes = 'Alert.ReadWrite'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'
        if (-not $PSCmdlet.ShouldProcess("$AlertID","Update existing Alert")) { return }
		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}