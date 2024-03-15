@{
	'software:get' = @{
		DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-software?view=o365-worldwide'
		Scopes = @('Software.Read')
		Synopsis = 'Retrieves the organization software inventory.'
		Description = 'Retrieves the organization software inventory.'
		Parameters = @{
            'SoftwareID' = @{
                Help = 'ID of the software to retrieve.'
                ValueFromPipeline = $true
            }
        }
        ParameterSets = @{
            'default' = 'Lists all security recommendations'
			'GetProductById' = 'Retrieves the specified software'
        }
	}
	'software/{Software ID}/distribution:get' = @{
		DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-software-ver-distribution?view=o365-worldwide'
		Scopes = @('Software.Read')
		Synopsis = 'Shows the distribution of versions of a software in your organization.'
		Description = 'Shows the distribution of versions of a software in your organization.'
		Parameters = @{
            'SoftwareID' = @{
                Help = 'ID of the software for which to retrieve distribution data.'
                ValueFromPipeline = $true
            }
        }
        ParameterSets = @{
            'default' = 'Shows the distribution of versions of the specified software in your organization.'
        }
	}
	'software/{Software ID}/machineReferences:get' = @{
		DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-machines-by-software?view=o365-worldwide'
		Scopes = @('Software.Read')
		Synopsis = 'Retrieve a list of device references that has this software installed.'
		Description = 'Retrieve a list of device references that has this software installed.'
		Parameters = @{
            'SoftwareID' = @{
                Help = 'ID of the software for which to retrieve devices that have it installed.'
                ValueFromPipeline = $true
            }
        }
        ParameterSets = @{
            'default' = 'Retrieve a list of device references that has this software installed.'
        }
	}
	'software/{Software ID}/vulnerabilities:get' = @{
		Name = 'Get-MdSoftwareVulnerability'
		DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-vuln-by-software?view=o365-worldwide'
		Scopes = @('Vulnerability.Read')
		Synopsis = 'Retrieve a list of vulnerabilities in the installed software.'
		Description = 'Retrieve a list of vulnerabilities in the installed software.'
		Parameters = @{
            'SoftwareID' = @{
                Help = 'ID of the software for which to retrieve devices that have it installed.'
                ValueFromPipeline = $true
            }
        }
        ParameterSets = @{
            'default' = 'Retrieve a list of vulnerabilities in the installed software.'
        }
	}
}