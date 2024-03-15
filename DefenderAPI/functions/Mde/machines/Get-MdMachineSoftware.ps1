function Get-MdMachineSoftware {
<#
.SYNOPSIS
    Retrieves a collection of installed software related to a given device ID.

.DESCRIPTION
    Retrieves a collection of installed software related to a given device ID.

    Scopes required (delegate auth): Software.Read

.PARAMETER MachineID
    ID of the machine to read the installed software from.

.PARAMETER Authorization
    

.EXAMPLE
    PS C:\> Get-MdMachineSoftware -MachineID $machineid

    <insert description here>

.EXAMPLE
    PS C:\> Get-MdMachineSoftware -Authorization $authorization

    <insert description here>

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-installed-software?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $MachineID,

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
			Path = 'machines/{MachineID}/software' -Replace '{MachineID}',$MachineID
			Method = 'get'
			RequiredScopes = 'Software.Read'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}