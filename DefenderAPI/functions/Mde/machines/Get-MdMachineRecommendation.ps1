function Get-MdMachineRecommendation {
<#
.SYNOPSIS
    Retrieves a collection of security recommendations related to a given device ID.

.DESCRIPTION
    Retrieves a collection of security recommendations related to a given device ID.

    Scopes required (delegate auth): SecurityRecommendation.Read

.PARAMETER Authorization
    

.PARAMETER MachineID
    ID of the machine to get recommendations for.

.EXAMPLE
    PS C:\> Get-MdMachineRecommendation -Authorization $authorization

    <insert description here>

.EXAMPLE
    PS C:\> Get-MdMachineRecommendation -MachineID $machineid

    Retrieves a collection of security recommendations related to the specified device ID.

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-security-recommendations?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetRecommendationById')]
        [string]
        $Authorization,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $MachineID
    )
    process {
		$__mapping = @{
            'Authorization' = 'Authorization'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @('Authorization') -Mapping $__mapping
			Path = 'machines/{MachineID}/recommendations' -Replace '{MachineID}',$MachineID
			Method = 'get'
			RequiredScopes = 'SecurityRecommendation.Read'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}