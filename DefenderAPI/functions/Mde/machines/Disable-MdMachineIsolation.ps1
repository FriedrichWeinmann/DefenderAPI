function Disable-MdMachineIsolation {
<#
.SYNOPSIS
    Undo isolation of a device.

.DESCRIPTION
    Undo isolation of a device.

    Scopes required (delegate auth): Machine.Isolate

.PARAMETER MachineID
    The ID of the machine to unisolate

.PARAMETER Comment
    A comment to associate to the unisolation

.EXAMPLE
    PS C:\> Disable-MdMachineIsolation -MachineID $machineid -Comment $comment

    Unisolate a machine from network

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/unisolate-machine?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $MachineID,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Comment
    )
    process {
		$__mapping = @{
            'Comment' = 'Comment'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('Comment') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'machines/{MachineID}/unisolate' -Replace '{MachineID}',$MachineID
			Method = 'post'
			RequiredScopes = 'Machine.Isolate'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}