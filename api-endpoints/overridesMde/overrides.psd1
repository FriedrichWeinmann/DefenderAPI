@{
    <#
    <path>:<method>

    Name             : Name of the command to generate
    Synopsis         : Synopsis part of the command help
    Description      : Description part of the command help
    DocumentationUrl : Link to the online documentation
    ServiceName      : Specific service override to include. Needs to be implemented in the Rest Command used.
    Scopes           : Scopes required in delegate authentication mode. Will be included in help and passed to rest command.
    RestCommand      : Command to use to execute the rest request and handle authentication
    ProcessorCommand : An additional command used to process the output. This command must be implemented manually.
    ParameterSets    : Hashtable mapping parameterset name to its description. Used in examples.

    Parameters:
    To override individual properties on parameters, create a child-hashtable.
    Each key is the system name of the parameter, entries govern the properties to override.
    Example:

    Parameters = @{
        MachineID = @{
            Description = 'ID of the machine to get recommendations for.'
        }
    }
    #>
    'alerts:get' = @{
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-alerts?view=o365-worldwide'
        Scopes = @('Alert.Read')
    }
    'alerts:patch' = @{
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/update-alert?view=o365-worldwide'
        Scopes = @('Alert.ReadWrite')
		ShouldProcess = 'Update existing Alert'
		ShouldProcessTarget = '$AlertID'
    }
    'alerts/createAlertByReference:post' = @{
        Name = 'New-MdAlert'
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/create-alert-by-reference?view=o365-worldwide'
        Scopes = @('Alert.ReadWrite')
    }
    'advancedqueries/run:post' = @{
        Name = 'Invoke-MdAdvancedQuery'
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/run-advanced-query-api?view=o365-worldwide'
        Scopes = @('AdvancedQuery.Read')
        ProcessorCommand = 'ConvertFrom-AdvancedQuery'
    }
    'advancedqueries/schema:post' = @{
        Name = 'Set-MdAdvancedQuerySchema'
    }
    'configurationScore:get' = @{
        Name = 'Get-MdDeviceSecureScore'
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-device-secure-score?view=o365-worldwide'
        Scopes = @('Score.Read')
        Synopsis = 'Retrieves your Microsoft Secure Score for Devices'
        Description = 'Retrieves your Microsoft Secure Score for Devices. A higher Microsoft Secure Score for Devices means your endpoints are more resilient from cybersecurity threat attacks.'
    }
    'exposureScore:get' = @{
        Name = 'Get-MdExposureScore'
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-exposure-score?view=o365-worldwide'
        Scopes = @('Score.Read')
        Synopsis = 'Retrieves the organizational exposure score.'
        Description = 'Retrieves the organizational exposure score.'
    }
    'exposureScore/byMachineGroups:get' = @{
        Name = 'Get-MdMachineGroupExposureScore'
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-machine-group-exposure-score?view=o365-worldwide'
        Scopes = @('Score.Read')
        Synopsis = 'Retrieves a collection of alerts related to a given domain address.'
        Description = 'Retrieves a collection of alerts related to a given domain address.'
    }
    'indicators:post' = @{
        Name = 'New-MdIndicator'
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/post-ti-indicator?view=o365-worldwide'
        Scopes = @('Ti.ReadWrite')
    }
    'machineactions:get' = @{
        Name = 'Get-MdMachineAction'
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-machineaction-object?view=o365-worldwide'
        Scopes = @('Machine.Read')
    }
    'machineactions/{Machineaction ID}/getPackageUri:get' = @{
        Name = 'Get-MdMachineActionPackageUri'
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-package-sas-uri?view=o365-worldwide'
        Scopes = @('Machine.CollectForensics')
    }
}