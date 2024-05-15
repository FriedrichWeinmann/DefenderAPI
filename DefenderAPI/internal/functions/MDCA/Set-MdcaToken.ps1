function Set-MdcaToken {
	<#
	.SYNOPSIS
		Helper function that injects the MDCA ApiKey Token into the EntraAuth token cache.
	
	.DESCRIPTION
		Helper function that injects the MDCA ApiKey Token into the EntraAuth token cache.
		By default, EntraAuth only supports authentication flows via entra (hence the module name).
		With this command we can inject a fake EntraAuth token object that works for Invoke-EntraRequest.
	
	.PARAMETER Token
		The MDCA ApiKey / Token to inject into EntraAuth.
	
	.PARAMETER TenantName
		Name of the tenant, the token applies to.
		Used for building the API Service Url.
	
	.EXAMPLE
		PS C:\> Set-MdcaToken -Token $MdcaToken -TenantName $TenantName
		
		Injects the MDCA ApiKey Token into the EntraAuth token cache.
	#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
	[CmdletBinding()]
	param (
		[SecureString]
		$Token,

		[string]
		$TenantName
	)
	process {
		$fakeToken = [PSCustomObject]@{
			ServiceUrl = "https://$TenantName.portal.cloudappsecurity.com/api/v1"
			ApiKey     = $Token
			Service    = 'DefenderAPI.MDCA'
		}
		Add-Member -InputObject $fakeToken -MemberType ScriptMethod -Name GetHeader -Value {
			return @{
				Authorization = "Token {0}" -f ([PSCredential]::new("Whatever", $this.ApiKey).GetNetworkCredential().Password)
				'content-type' = 'application/json'
			}
		}

		& (Get-Module EntraAuth) {
			param ($Token)

			$script:_EntraTokens['DefenderAPI.MDCA'] = $Token
		} $fakeToken
	}
}