function Get-MdSoftware {
<#
.SYNOPSIS
    Retrieves the organization software inventory.

.DESCRIPTION
    Retrieves the organization software inventory.

    Scopes required (delegate auth): Software.Read

.PARAMETER SoftwareID
    ID of the software to retrieve.

.EXAMPLE
    PS C:\> Get-MdSoftware -SoftwareID $softwareid

    <insert description here>

.EXAMPLE
    PS C:\> Get-MdSoftware

    Lists all security recommendations

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-software?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetProductById')]
        [Alias('Id')]
        [string]
        $SoftwareID
    )
    process {
		$__mapping = @{

		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'software'
			Method = 'get'
			RequiredScopes = 'Software.Read'
			Service = 'DefenderAPI.Endpoint'
		}
		if ($SoftwareID) { $__param.Path += "/$SoftwareID" }
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-EntraRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}