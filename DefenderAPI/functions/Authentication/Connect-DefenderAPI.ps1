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
		[Parameter(Mandatory = $true)]
		[string]
		$ClientID,
		
		[Parameter(Mandatory = $true)]
		[string]
		$TenantID,
		
		[string[]]
		$Scopes,

		[Parameter(ParameterSetName = 'Browser')]
		[switch]
		$Browser,

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

		[PsfArgumentCompleter('DefenderAPI.Service')]
		[PsfValidateSet(TabCompletion = 'DefenderAPI.Service')]
		[string[]]
		$Service = 'Endpoint',

		[string]
		$ServiceUrl
	)
	process {
		foreach ($serviceName in $Service) {
			$serviceObject = Get-DefenderAPIService -Name $serviceName

			$commonParam = @{
				ClientID = $ClientID
				TenantID = $TenantID
				Resource = $serviceObject.Resource
			}
			$effectiveServiceUrl = $ServiceUrl
			if (-not $ServiceUrl) { $effectiveServiceUrl = $serviceObject.ServiceUrl }
			
			#region Connection
			switch ($PSCmdlet.ParameterSetName) {
				#region Browser
				Browser {
					$scopesToUse = $Scopes
					if (-not $Scopes) { $scopesToUse = $serviceObject.DefaultScopes }

					Invoke-PSFProtectedCommand -ActionString 'Connect-DefenderAPI.Connect.Browser' -ActionStringValues $serviceName -ScriptBlock {
						$result = Connect-ServiceBrowser @commonParam -SelectAccount -Scopes $scopesToUse -ErrorAction Stop
					} -Target $serviceName -EnableException $true -PSCmdlet $PSCmdlet

					$token = [DefenderToken]::new($serviceName, $ClientID, $TenantID, $effectiveServiceUrl, $false)
					$token.SetTokenMetadata($result)
					$script:_DefenderTokens[$serviceName] = $token
				}
				#endregion Browser

				#region DeviceCode
				DeviceCode {
					$scopesToUse = $Scopes
					if (-not $Scopes) { $scopesToUse = $serviceObject.DefaultScopes }

					Invoke-PSFProtectedCommand -ActionString 'Connect-DefenderAPI.Connect.DeviceCode' -ActionStringValues $serviceName -ScriptBlock {
						$result = Connect-ServiceBrowser @commonParam -SelectAccount -Scopes $scopesToUse -ErrorAction Stop
					} -Target $serviceName -EnableException $true -PSCmdlet $PSCmdlet

					$token = [DefenderToken]::new($serviceName, $ClientID, $TenantID, $effectiveServiceUrl, $true)
					$token.SetTokenMetadata($result)
					$script:_DefenderTokens[$serviceName] = $token
				}
				#endregion DeviceCode

				#region ROPC
				UsernamePassword {
					Invoke-PSFProtectedCommand -ActionString 'Connect-DefenderAPI.Connect.ROPC' -ActionStringValues $serviceName -ScriptBlock {
						$result = Connect-ServicePassword @commonParam -Credential $Credential -ErrorAction Stop
					} -Target $serviceName -EnableException $true -PSCmdlet $PSCmdlet

					$token = [DefenderToken]::new($serviceName, $ClientID, $TenantID, $Credential, $effectiveServiceUrl)
					$token.SetTokenMetadata($result)
					$script:_DefenderTokens[$serviceName] = $token
				}
				#endregion ROPC

				#region AppSecret
				AppSecret {
					Invoke-PSFProtectedCommand -ActionString 'Connect-DefenderAPI.Connect.ClientSecret' -ActionStringValues $serviceName -ScriptBlock {
						$result = Connect-ServiceClientSecret @commonParam -ClientSecret $ClientSecret -ErrorAction Stop
					} -Target $serviceName -EnableException $true -PSCmdlet $PSCmdlet

					$token = [DefenderToken]::new($serviceName, $ClientID, $TenantID, $ClientSecret, $effectiveServiceUrl)
					$token.SetTokenMetadata($result)
					$script:_DefenderTokens[$serviceName] = $token
				}
				#endregion AppSecret

				#region AppCertificate
				AppCertificate {
					try { $certificateObject = Resolve-Certificate -BoundParameters $PSBoundParameters }
					catch {
						Stop-PSFFunction -String 'Connect-DefenderAPI.Error.CertError' -StringValues $serviceName -Tag connect, fail -ErrorRecord $_ -EnableException $true -Cmdlet $PSCmdlet -Target $serviceName
					}
	
					Invoke-PSFProtectedCommand -ActionString 'Connect-DefenderAPI.Connect.Certificate' -ActionStringValues $serviceName, $certificateObject.Subject, $certificateObject.Thumbprint -ScriptBlock {
						$result = Connect-ServiceCertificate @commonParam -Certificate $certificateObject -ErrorAction Stop
					} -Target $serviceName -EnableException $true -PSCmdlet $PSCmdlet

					$token = [DefenderToken]::new($serviceName, $ClientID, $TenantID, $certificateObject, $effectiveServiceUrl)
					$token.SetTokenMetadata($result)
					$script:_DefenderTokens[$serviceName] = $token
				}
				#endregion AppCertificate
			}
			#endregion Connection
		}
	}
}