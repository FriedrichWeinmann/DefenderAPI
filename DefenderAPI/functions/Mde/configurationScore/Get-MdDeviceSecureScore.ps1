function Get-MdDeviceSecureScore {
<#
.SYNOPSIS
    Retrieves your Microsoft Secure Score for Devices

.DESCRIPTION
    Retrieves your Microsoft Secure Score for Devices. A higher Microsoft Secure Score for Devices means your endpoints are more resilient from cybersecurity threat attacks.

    Scopes required (delegate auth): Score.Read



.EXAMPLE
    PS C:\> Get-MdDeviceSecureScore

    <insert description here>

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-device-secure-score?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (

    )
    process {
		$__mapping = @{

		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'configurationScore'
			Method = 'get'
			RequiredScopes = 'Score.Read'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}