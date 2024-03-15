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
    'machines:get' = @{
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-machines?view=o365-worldwide'
        Scopes = @('Machine.Read')
    }
	'machines/{Machine ID}/isolate:post' = @{
		Name = 'Enable-MdMachineIsolation'
		DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/isolate-machine?view=o365-worldwide'
		Scopes = @('Machine.Isolate')
		Synopsis = 'Isolates a device from accessing external network.'
		Description = 'Isolates a device from accessing external network.'
	}
    'machines/{Machine ID}/recommendations:get' = @{
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-security-recommendations?view=o365-worldwide'
        Scopes = @('SecurityRecommendation.Read')
        Synopsis = 'Retrieves a collection of security recommendations related to a given device ID.'
        Description = 'Retrieves a collection of security recommendations related to a given device ID.'
        Parameters = @{
            MachineID = @{
                Help = 'ID of the machine to get recommendations for.'
                ValueFromPipeline = $true
            }
        }
        ParameterSets = @{
            'default' = 'Retrieves a collection of security recommendations related to the specified device ID.'
        }
    }
    'machines/{Machine ID}/software:get' = @{
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-installed-software?view=o365-worldwide'
        Scopes = @('Software.Read')
        Synopsis = 'Retrieves a collection of installed software related to a given device ID.'
        Description = 'Retrieves a collection of installed software related to a given device ID.'
        Parameters = @{
            MachineID = @{
                Help = 'ID of the machine to read the installed software from.'
                ValueFromPipeline = $true
            }
        }
    }
	'machines/{Machine ID}/unisolate:post' = @{
		Name = 'Disable-MdMachineIsolation'
		DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/unisolate-machine?view=o365-worldwide'
		Scopes = @('Machine.Isolate')
		Synopsis = 'Undo isolation of a device.'
		Description = 'Undo isolation of a device.'
	}
    'machines/{Machine ID}/vulnerabilities:get' = @{
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-discovered-vulnerabilities?view=o365-worldwide'
        Name = 'Get-MdMachineVulnerability'
        Scopes = @('Vulnerability.Read')
        Synopsis = 'Retrieves a collection of discovered vulnerabilities related to a given device ID.'
        Description = 'Retrieves a collection of discovered vulnerabilities related to a given device ID.'
        Parameters = @{
            MachineID = @{
                Help = 'ID of the machine to read the detected vulnerabilities from.'
                ValueFromPipeline = $true
            }
        }
    }
	'machines/{Machine ID}/runliveresponse:post' = @{
		DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/run-live-response?view=o365-worldwide'
        Name = 'Start-MdMachineLiveResponse'
        Scopes = @('Machine.LiveResponse')
        Synopsis = 'Runs a sequence of live response commands on a device'
        Description = 'Runs a sequence of live response commands on a device'
        Parameters = @{
            MachineID = @{
                Help = 'ID of the machine to execute a live response script upon'
                ValueFromPipeline = $true
            }
			Commands = @{
				Help = @'
The live response commands to execute.
Example:
@{
	type = "RunScript"
	params = @(
		@{
			key = "ScriptName"
			value = "minidump.ps1"
		},
		@{
			key = "Args"
			value = "OfficeClickToRun"
		}
	)
}
'@
			}
        }
	}
}