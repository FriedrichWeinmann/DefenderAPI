function Enable-MdMachineIsolation {
<#
.SYNOPSIS
    Isolates a device from accessing external network.

.DESCRIPTION
    Isolates a device from accessing external network.

    Scopes required (delegate auth): Machine.Isolate

.PARAMETER IsolationType
    Type of the isolation. Allowed values are 'Full' (for full isolation) or 'Selective' (to restrict only limited set of applications from accessing the network)

.PARAMETER Comment
    A comment to associate to the isolation

.PARAMETER MachineID
    The ID of the machine to isolate

.EXAMPLE
    PS C:\> Enable-MdMachineIsolation -Comment $comment -MachineID $machineid

    Isolate a machine from network

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/isolate-machine?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $IsolationType,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Comment,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $MachineID
    )
    process {
		$__mapping = @{
            'IsolationType' = 'Isolation Type'
            'Comment' = 'Comment'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('IsolationType','Comment') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'machines/{MachineID}/isolate' -Replace '{MachineID}',$MachineID
			Method = 'post'
			RequiredScopes = 'Machine.Isolate'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}