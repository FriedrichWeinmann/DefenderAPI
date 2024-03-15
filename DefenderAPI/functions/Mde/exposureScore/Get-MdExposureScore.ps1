function Get-MdExposureScore {
<#
.SYNOPSIS
    Retrieves the organizational exposure score.

.DESCRIPTION
    Retrieves the organizational exposure score.

    Scopes required (delegate auth): Score.Read



.EXAMPLE
    PS C:\> Get-MdExposureScore

    <insert description here>

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-exposure-score?view=o365-worldwide
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
			Path = 'exposureScore'
			Method = 'get'
			RequiredScopes = 'Score.Read'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}