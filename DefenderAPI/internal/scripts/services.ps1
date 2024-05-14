# Registers the default service configurations
$endpointCfg = @{
	Name          = 'DefenderAPI.Endpoint'
	ServiceUrl    = 'https://api.securitycenter.microsoft.com/api'
	Resource      = 'https://api.securitycenter.microsoft.com'
	DefaultScopes = @()
	Header        = @{ 'Content-Type' = 'application/json' }
	HelpUrl       = 'https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/api/apis-intro?view=o365-worldwide'
}
Register-EntraService @endpointCfg

$securityCfg = @{
	Name          = 'DefenderAPI.Security'
	ServiceUrl    = 'https://api.security.microsoft.com/api'
	Resource      = 'https://security.microsoft.com/mtp/'
	DefaultScopes = @('AdvancedHunting.Read')
	Header        = @{ 'Content-Type' = 'application/json' }
	HelpUrl       = 'https://learn.microsoft.com/en-us/microsoft-365/security/defender/api-create-app-web?view=o365-worldwide'
}
Register-EntraService @securityCfg