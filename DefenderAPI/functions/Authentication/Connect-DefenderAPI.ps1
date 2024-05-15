function Connect-DefenderAPI {
	<#
	.SYNOPSIS
		Establish a connection to the defender APIs.
	
	.DESCRIPTION
		Establish a connection to the defender APIs.
		Prerequisite before executing any requests / commands.
	
	.PARAMETER ClientID
		ID of the registered/enterprise application used for authentication.
	
	.PARAMETER TenantID
		The ID of the tenant/directory to connect to.
	
	.PARAMETER Scopes
		Any scopes to include in the request.
		Only used for interactive/delegate workflows, ignored for Certificate based authentication or when using Client Secrets.

	.PARAMETER Browser
		Use an interactive logon in your default browser.
		This is the default logon experience.

	.PARAMETER BrowserMode
		How the browser used for authentication is selected.
		Options:
		+ Auto (default): Automatically use the default browser.
		+ PrintLink: The link to open is printed on console and user selects which browser to paste it into (must be used on the same machine)

	.PARAMETER DeviceCode
		Use the Device Code delegate authentication flow.
		This will prompt the user to complete login via browser.
	
	.PARAMETER Certificate
		The Certificate object used to authenticate with.
		
		Part of the Application Certificate authentication workflow.
	
	.PARAMETER CertificateThumbprint
		Thumbprint of the certificate to authenticate with.
		The certificate must be stored either in the user or computer certificate store.
		
		Part of the Application Certificate authentication workflow.
	
	.PARAMETER CertificateName
		The name/subject of the certificate to authenticate with.
		The certificate must be stored either in the user or computer certificate store.
		The newest certificate with a private key will be chosen.
		
		Part of the Application Certificate authentication workflow.
	
	.PARAMETER CertificatePath
		Path to a PFX file containing the certificate to authenticate with.
		
		Part of the Application Certificate authentication workflow.
	
	.PARAMETER CertificatePassword
		Password to use to read a PFX certificate file.
		Only used together with -CertificatePath.
		
		Part of the Application Certificate authentication workflow.
	
	.PARAMETER ClientSecret
		The client secret configured in the registered/enterprise application.
		
		Part of the Client Secret Certificate authentication workflow.

	.PARAMETER Credential
		The username / password to authenticate with.

		Part of the Resource Owner Password Credential (ROPC) workflow.

	.PARAMETER Service
		The service to connect to.
		Individual commands using Invoke-MdeRequest specify the service to use and thus identify the token needed.
		Defaults to: Endpoint

	.PARAMETER ServiceUrl
		The base url to the service connecting to.
		Used for authentication, scopes and executing requests.
		Defaults to: https://api.securitycenter.microsoft.com/api
	
	.EXAMPLE
		PS C:\> Connect-DefenderAPI -ClientID $clientID -TenantID $tenantID
	
		Establish a connection to the defender for endpoint API, prompting the user for login on their default browser.
	
	.EXAMPLE
		PS C:\> Connect-DefenderAPI -ClientID $clientID -TenantID $tenantID -Certificate $cert
	
		Establish a connection to the defender APIs using the provided certificate.
	
	.EXAMPLE
		PS C:\> Connect-DefenderAPI -ClientID $clientID -TenantID $tenantID -CertificatePath C:\secrets\certs\mde.pfx -CertificatePassword (Read-Host -AsSecureString)
	
		Establish a connection to the defender APIs using the provided certificate file.
		Prompts you to enter the certificate-file's password first.
	
	.EXAMPLE
		PS C:\> Connect-DefenderAPI -ClientID $clientID -TenantID $tenantID -ClientSecret $secret
	
		Establish a connection to the defender APIs using a client secret.
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
	[CmdletBinding(DefaultParameterSetName = 'Browser')]
	param (
		[Parameter(Mandatory = $true, ParameterSetName = 'Browser')]
		[Parameter(Mandatory = $true, ParameterSetName = 'DeviceCode')]
		[Parameter(Mandatory = $true, ParameterSetName = 'AppCertificate')]
		[Parameter(Mandatory = $true, ParameterSetName = 'AppSecret')]
		[Parameter(Mandatory = $true, ParameterSetName = 'UsernamePassword')]
		[string]
		$ClientID,
		
		[Parameter(Mandatory = $true, ParameterSetName = 'Browser')]
		[Parameter(Mandatory = $true, ParameterSetName = 'DeviceCode')]
		[Parameter(Mandatory = $true, ParameterSetName = 'AppCertificate')]
		[Parameter(Mandatory = $true, ParameterSetName = 'AppSecret')]
		[Parameter(Mandatory = $true, ParameterSetName = 'UsernamePassword')]
		[string]
		$TenantID,
		
		[Parameter(ParameterSetName = 'Browser')]
		[Parameter(ParameterSetName = 'DeviceCode')]
		[Parameter(ParameterSetName = 'AppCertificate')]
		[Parameter(ParameterSetName = 'AppSecret')]
		[Parameter(ParameterSetName = 'UsernamePassword')]
		[string[]]
		$Scopes,

		[Parameter(ParameterSetName = 'Browser')]
		[switch]
		$Browser,

		[Parameter(ParameterSetName = 'Browser')]
		[ValidateSet('Auto','PrintLink')]
		[string]
		$BrowserMode = 'Auto',

		[Parameter(ParameterSetName = 'DeviceCode')]
		[switch]
		$DeviceCode,
		
		[Parameter(ParameterSetName = 'AppCertificate')]
		[System.Security.Cryptography.X509Certificates.X509Certificate2]
		$Certificate,
		
		[Parameter(ParameterSetName = 'AppCertificate')]
		[string]
		$CertificateThumbprint,
		
		[Parameter(ParameterSetName = 'AppCertificate')]
		[string]
		$CertificateName,
		
		[Parameter(ParameterSetName = 'AppCertificate')]
		[string]
		$CertificatePath,
		
		[Parameter(ParameterSetName = 'AppCertificate')]
		[System.Security.SecureString]
		$CertificatePassword,
		
		[Parameter(Mandatory = $true, ParameterSetName = 'AppSecret')]
		[System.Security.SecureString]
		$ClientSecret,

		[Parameter(Mandatory = $true, ParameterSetName = 'UsernamePassword')]
		[PSCredential]
		$Credential,

		[Parameter(Mandatory = $true, ParameterSetName = 'MdcaLegacyToken')]
		[securestring]
		$MdcaToken,

		[Parameter(ParameterSetName = 'Browser')]
		[Parameter(ParameterSetName = 'DeviceCode')]
		[Parameter(ParameterSetName = 'AppCertificate')]
		[Parameter(ParameterSetName = 'AppSecret')]
		[Parameter(ParameterSetName = 'UsernamePassword')]
		[Parameter(Mandatory = $true, ParameterSetName = 'MdcaLegacyToken')]
		[string]
		$TenantName,

		[Parameter(ParameterSetName = 'Browser')]
		[Parameter(ParameterSetName = 'DeviceCode')]
		[Parameter(ParameterSetName = 'AppCertificate')]
		[Parameter(ParameterSetName = 'AppSecret')]
		[Parameter(ParameterSetName = 'UsernamePassword')]
		[ValidateSet('Endpoint', 'Security', 'MDCA')]
		[string[]]
		$Service = 'Endpoint',

		[Parameter(ParameterSetName = 'Browser')]
		[Parameter(ParameterSetName = 'DeviceCode')]
		[Parameter(ParameterSetName = 'AppCertificate')]
		[Parameter(ParameterSetName = 'AppSecret')]
		[Parameter(ParameterSetName = 'UsernamePassword')]
		[string]
		$ServiceUrl
	)
	
	begin {
		if ($Service -contains 'MDCA' -and -not $TenantName) {
			Stop-PSFFunction -String 'Connect-DefenderAPI.Error.MdcaNoTenant' -EnableException $true -Cmdlet $PSCmdlet
		}

		if ($Service -contains 'MDCA' -or $MdcaToken) {
			$param = @{
				Name          = 'DefenderAPI.MDCA'
				ServiceUrl    = "https://$TenantName.portal.cloudappsecurity.com/api/v1"
				Resource      = '05a65629-4c1b-48c1-a78b-804c4abdd4af'
				DefaultScopes = @()
				Header        = @{ 'content-type' = 'application/json' }
				HelpUrl       = 'https://learn.microsoft.com/en-us/defender-cloud-apps/api-introduction'
			}
			Register-EntraService @param
		}
	}
	process {
		$actualServiceNames = foreach ($serviceName in $Service) { "DefenderAPI.$serviceName" }

		if ($MdcaToken) {
			Set-MdcaToken -Token $MdcaToken -TenantName $TenantName
			return
		}

		$param = $PSBoundParameters | ConvertTo-PSFHashtable -ReferenceCommand Connect-EntraService
		$param.Service = $actualServiceNames
		Connect-EntraService @param
	}
}