# Defender API Module

Welcome to the Defender API PowerShell client module.
In this project we try to provide a comprehensive, comfortable to use client for interacting with the Microsoft APIs related to the Defender Product Suite.

## Integrated APIs

|Name|Docs|API Url|
|---|---|---|
| Defender for Endpoint|[Docs](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/api/apis-intro?view=o365-worldwide)|https://api.securitycenter.microsoft.com/api|
| Security Center|[Docs](https://learn.microsoft.com/en-us/microsoft-365/security/defender/api-create-app-web?view=o365-worldwide)|https://api.security.microsoft.com/api|

## Installation

To install the module, use the following line:

```powershell
Install-Module DefenderAPI -Scope CurrentUser
```

If you need to use this module on a machine that has not free access to the PowerShell gallery, you can transport it offline by first downloading the module (and its dependencies) on an open internet facing machine like this:

```powershell
Save-Module DefenderAPI -Path .
```

This will download everything you need into the current path.
Then you can copy it to the machine you want to run this on and store it in:

> C:\Program Files\WindowsPowerShell\Modules

## Connect

To properly connect to the API and start executing commands you first need to prepare an App Registration with the required scopes (See the links for the services linked above for guidance).
Fundamentally, we offer five different Options to connect:

+ Delegate (User) Mode: Browser (default), DeviceCode, Credentials
+ Application (Service) Mode: Certificate, ClientSecret

> Note that delegate and application modes use different sets of scopes / permissions.

Here are examples on how to connect for each different option:

```powershell
$clientID = '<clientID>'
$tenantID = '<tenantID>'
$service = 'Endpoint'

# Browser Mode with MFA / FIDO2 Support, etc.
Connect-DefenderAPI -TenantID $tenantID -ClientID $clientID -Service $service

# DeviceCode Mode with MFA / FIDO2 Support, etc.
Connect-DefenderAPI -TenantID $tenantID -ClientID $clientID -Service $service -DeviceCode

# Credentials Mode - Cloud Only user, no MFA
Connect-DefenderAPI -TenantID $tenantID -ClientID $clientID -Service $service -Credentials (Get-Credential)

# Certificate Mode
Connect-DefenderAPI -TenantID $tenantID -ClientID $clientID -Service $service -CertificateThumbprint '<certthumbprint>'
Connect-DefenderAPI -TenantID $tenantID -ClientID $clientID -Service $service -Certificate $cert
Connect-DefenderAPI -TenantID $tenantID -ClientID $clientID -Service $service -CertificateName 'CN=<whatever subject>'
Connect-DefenderAPI -TenantID $tenantID -ClientID $clientID -Service $service  -CertificatePath .\cert.pfx
```

## Profit

Once connected, you can run commands associated with that service (see below for a mapping).
For example, after connecting to the `Endpoint` service you can run the following command to list all machines:

```powershell
Get-MdMachine
```

Assuming you have the required scopes / permissions, of course ...

## Services

Currently pre-configured services:

|Service Name|Product|Commands|
|---|---|---|
|Endpoint|Defender for Endpoint|`*-Md*`|
|Security|Security Center|`*-MSec*`|

You can always get a list of currently available services using `Get-DefenderAPIService`.
You can use `Set-DefenderAPIService` to modify a given service (for example to redirect Defender for Endpoint API calls to the geographically local endpoints).

The service-specific commands included in the module are tied to their service - changes to that service affect all related commands.

You can use the `Register-DefenderAPIService` to add your own service endpoint, then use `Invoke-DefenderAPIRequest` to execute requests against that configuration, without affecting other commands or services.
Service configurations (and tokens) are stored in the local runspace, if you multithread, you will need to apply the configuration (and establish connections) again, but can freely connect to multiple tenants for the same service.
