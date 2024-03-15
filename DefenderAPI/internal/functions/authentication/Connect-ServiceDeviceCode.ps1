﻿function Connect-ServiceDeviceCode {
	<#
	.SYNOPSIS
		Connects to Azure AD using the Device Code authentication workflow.
	
	.DESCRIPTION
		Connects to Azure AD using the Device Code authentication workflow.
	
	.PARAMETER Resource
		The resource owning the api permissions / scopes requested.

	.PARAMETER ClientID
		The ID of the registered app used with this authentication request.
	
	.PARAMETER TenantID
		The ID of the tenant connected to with this authentication request.
	
	.PARAMETER Scopes
		The scopes to request.
		Automatically scoped to the service specified via Service Url.
		Defaults to ".Default"
	
	.EXAMPLE
		PS C:\> Connect-ServiceDeviceCode -ServiceUrl $url -ClientID '<ClientID>' -TenantID '<TenantID>'
	
		Connects to the specified tenant using the specified client, prompting the user to authorize via Browser.
	#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "")]
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]
		$Resource,

		[Parameter(Mandatory = $true)]
		[string]
		$ClientID,
        
		[Parameter(Mandatory = $true)]
		[string]
		$TenantID,
        
		[AllowEmptyCollection()]
		[string[]]
		$Scopes
	)

	if (-not $Scopes) { $Scopes = @('.default') }
	$actualScopes = $Scopes | Resolve-ScopeName -Resource $Resource

	try {
		$initialResponse = Invoke-RestMethod -Method POST -Uri "https://login.microsoftonline.com/$TenantID/oauth2/v2.0/devicecode" -Body @{
			client_id = $ClientID
			scope     = @($actualScopes) + 'offline_access' -join " "
		} -ErrorAction Stop
	}
	catch {
		throw
	}

	Write-Host $initialResponse.message

	$paramRetrieve = @{
		Uri         = "https://login.microsoftonline.com/$TenantID/oauth2/v2.0/token"
		Method      = "POST"
		Body        = @{
			grant_type  = "urn:ietf:params:oauth:grant-type:device_code"
			client_id   = $ClientID
			device_code = $initialResponse.device_code
		}
		ErrorAction = 'Stop'
	}
	$limit = (Get-Date).AddSeconds($initialResponse.expires_in)
	while ($true) {
		if ((Get-Date) -gt $limit) {
			Invoke-TerminatingException -Cmdlet $PSCmdlet -Message "Timelimit exceeded, device code authentication failed" -Category AuthenticationError
		}
		Start-Sleep -Seconds $initialResponse.interval
		try { $authResponse = Invoke-RestMethod @paramRetrieve }
		catch {
			if ($_ -match '"error":\s*"authorization_pending"') { continue }
			$PSCmdlet.ThrowTerminatingError($_)
		}
		if ($authResponse) {
			break
		}
	}

	Read-AuthResponse -AuthResponse $authResponse
}