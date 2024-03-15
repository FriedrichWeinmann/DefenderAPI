﻿function Get-MdSoftware {
<#
.SYNOPSIS
    Retrieves the organization software inventory.

.DESCRIPTION
    Retrieves the organization software inventory.

    Scopes required (delegate auth): Software.Read

.PARAMETER SoftwareID
    ID of the software to retrieve.

.PARAMETER Authorization
    

.EXAMPLE
    PS C:\> Get-MdSoftware -Authorization $authorization

    <insert description here>

.EXAMPLE
    PS C:\> Get-MdSoftware

    Lists all security recommendations

.EXAMPLE
    PS C:\> Get-MdSoftware -SoftwareID $softwareid -Authorization $authorization

    <insert description here>

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-software?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetProductById')]
        [Alias('Id')]
        [string]
        $SoftwareID,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = '')]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'GetProductById')]
        [string]
        $Authorization
    )
    process {
		$__mapping = @{
            'Authorization' = 'Authorization'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @('Authorization') -Mapping $__mapping
			Path = 'software'
			Method = 'get'
			RequiredScopes = 'Software.Read'
			
		}
		if ($SoftwareID) { $__param.Path += "/$SoftwareID" }
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}