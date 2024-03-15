@{
    'vulnerabilities:get' = @{
        Name = 'Get-MdVulnerability'
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-all-vulnerabilities?view=o365-worldwide'
        Synopsis = 'Retrieves a list of all the vulnerabilities.'
        Description = 'Retrieves a list of all the vulnerabilities.'
        Scopes = @('Vulnerability.Read')
		Parameters = @{
            'VulnerabilityID' = @{
                Help = 'ID of the vulnerability to retrieve.'
                ValueFromPipeline = $true
            }
        }
        ParameterSets = @{
            'default' = 'Retrieves a list of all the vulnerabilities.'
			'GetVulnerability' = 'Retrieves a specific vulnerability with the specified identifier.'
        }
    }
    'vulnerabilities/{Vulnerability ID}/machineReferences:get' = @{
        Name = 'Get-MdVulnerableMachine'
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-machines-by-vulnerability?view=o365-worldwide'
        Synopsis = 'Retrieves a list of devices affected by a vulnerability.'
        Description = 'Retrieves a list of devices affected by a vulnerability.'
        Scopes = @('Vulnerability.Read')
		Parameters = @{
            'VulnerabilityID' = @{
                Help = 'ID of the vulnerability for which to retrieve affected devices.'
                ValueFromPipeline = $true
            }
        }
        ParameterSets = @{
            'default' = 'Retrieves a list of devices affected by a vulnerability.'
        }
    }
}