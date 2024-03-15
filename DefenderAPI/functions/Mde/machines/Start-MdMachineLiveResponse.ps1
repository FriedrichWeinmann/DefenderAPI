function Start-MdMachineLiveResponse {
<#
.SYNOPSIS
    Runs a sequence of live response commands on a device

.DESCRIPTION
    Runs a sequence of live response commands on a device

    Scopes required (delegate auth): Machine.LiveResponse

.PARAMETER Commands
    The live response commands to execute.
Example:
@{
	type = "RunScript"
	params = @(
		@{
			key = "ScriptName"
			value = "minidump.ps1"
		},
		@{
			key = "Args"
			value = "OfficeClickToRun"
		}
	)
}

.PARAMETER Comment
    A comment to associate to the isolation

.PARAMETER MachineID
    ID of the machine to execute a live response script upon

.EXAMPLE
    PS C:\> Start-MdMachineLiveResponse -Commands $commands -Comment $comment -MachineID $machineid

    Run live response api commands for a single machine

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/run-live-response?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [array]
        $Commands,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Comment,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Alias('Id')]
        [string]
        $MachineID
    )
    process {
		$__mapping = @{
            'Commands' = 'Commands'
            'Comment' = 'Comment'
		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @('Commands','Comment') -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'machines/{MachineID}/runliveresponse' -Replace '{MachineID}',$MachineID
			Method = 'post'
			RequiredScopes = 'Machine.LiveResponse'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}