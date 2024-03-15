function Get-MdLiveResponseResultDownloadLink {
<#
.SYNOPSIS
    Retrieves a specific live response command result by its index.

.DESCRIPTION
    Retrieves a specific live response command result by its index.

    Scopes required (delegate auth): Machine.LiveResponse

.PARAMETER CommandIndex
    The index of the live response command to get the results download URI for

.PARAMETER MachineActionID
    The identifier of the machine action

.EXAMPLE
    PS C:\> Get-MdLiveResponseResultDownloadLink -CommandIndex $commandindex -MachineActionID $machineactionid

    Get result download URI for a completed live response command

.LINK
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-live-response-result?view=o365-worldwide
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $CommandIndex,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $MachineActionID
    )
    process {
		$__mapping = @{

		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'machineactions/{MachineActionID}/GetLiveResponseResultDownloadLink(index={CommandIndex})' -Replace '{CommandIndex}',$CommandIndex -Replace '{MachineActionID}',$MachineActionID
			Method = 'get'
			RequiredScopes = 'Machine.LiveResponse'
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}