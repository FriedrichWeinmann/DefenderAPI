@{
	'recommendations:get' = @{
		DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-all-recommendations?view=o365-worldwide'
		Scopes = @('SecurityRecommendation.Read')
		Synopsis = 'Retrieves a list of all security recommendations affecting the organization.'
        Description = 'Retrieves a list of all security recommendations affecting the organization.'
        Parameters = @{
            'RecommendationID' = @{
                Help = 'ID of the recommendation to retrieve.'
                ValueFromPipeline = $true
            }
        }
        ParameterSets = @{
            'default' = 'Lists all security recommendations'
			'GetRecommendationById' = 'Retrieves the specified security recommendations'
        }
	}
	'recommendations/{Recommendation ID}/machineReferences:get' = @{
		Name = 'Get-MdRecommendationMachineReference'
		DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-recommendation-machines?view=o365-worldwide'
		Scopes = @('SecurityRecommendation.Read')
		Synopsis = 'Retrieves a list of devices associated with the security recommendation.'
		Description = 'Retrieves a list of devices associated with the security recommendation.'
		Parameters = @{
            'RecommendationID' = @{
                Help = 'ID of the recommendation for which to retrieve devices.'
                ValueFromPipeline = $true
            }
        }
        ParameterSets = @{
            'default' = 'Retrieves a list of devices associated with the security recommendation.'
        }
	}
	'recommendations/{Recommendation ID}/software:get' = @{
		DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/list-recommendation-software?view=o365-worldwide'
		Scopes = @('SecurityRecommendation.Read')
		Synopsis = 'Retrieves a security recommendation related to a specific software.'
		Description = 'Retrieves a security recommendation related to a specific software.'
		Parameters = @{
            'RecommendationID' = @{
                Help = 'ID of the recommendation for which to retrieve software information.'
                ValueFromPipeline = $true
            }
        }
        ParameterSets = @{
            'default' = 'Retrieves a security recommendation related to a specific software.'
        }
	}
	'recommendations/{Recommendation ID}/vulnerabilities:get' = @{
		Name = 'Get-MdRecommendationVulnerability'
		DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-recommendation-vulnerabilities?view=o365-worldwide'
		Scopes = @('Vulnerability.Read')
		Synopsis = 'Retrieves a list of vulnerabilities associated with the security recommendation.'
		Description = 'Retrieves a list of vulnerabilities associated with the security recommendation.'
		Parameters = @{
            'RecommendationID' = @{
                Help = 'ID of the recommendation for which to retrieve vulnerabilities.'
                ValueFromPipeline = $true
            }
        }
        ParameterSets = @{
            'default' = 'Retrieves a list of vulnerabilities associated with the security recommendation.'
        }
	}
}