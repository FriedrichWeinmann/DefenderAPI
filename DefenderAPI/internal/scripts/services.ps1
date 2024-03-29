﻿# Registers the default service configurations
$endpointCfg = @{
	Name          = 'Endpoint'
	ServiceUrl    = 'https://api.securitycenter.microsoft.com/api'
	Resource      = 'https://api.securitycenter.microsoft.com'
	DefaultScopes = @()
	HelpUrl       = 'https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/api/apis-intro?view=o365-worldwide'
}
Register-DefenderAPIService @endpointCfg

$securityCfg = @{
	Name          = 'Security'
	ServiceUrl    = 'https://api.security.microsoft.com/api'
	Resource      = 'https://security.microsoft.com/mtp/'
	DefaultScopes = @('AdvancedHunting.Read')
	HelpUrl       = 'https://learn.microsoft.com/en-us/microsoft-365/security/defender/api-create-app-web?view=o365-worldwide'
}
Register-DefenderAPIService @securityCfg