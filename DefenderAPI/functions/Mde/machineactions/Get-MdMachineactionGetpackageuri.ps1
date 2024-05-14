function Get-MdMachineactionGetpackageuri {
<#
.SYNOPSIS
    Actions - Get investigation package download URI

.DESCRIPTION
    Get a URI that allows downloading of an investigation package

.PARAMETER MachineactionID
    The ID of the investigation package collection

.EXAMPLE
    PS C:\> Get-MdMachineactionGetpackageuri -MachineactionID $machineactionid

    Get a URI that allows downloading of an investigation package

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $MachineactionID
    )
    process {
		$__mapping = @{

		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'machineactions/{MachineactionID}/getPackageUri' -Replace '{MachineactionID}',$MachineactionID
			Method = 'get'
			
			Service = 'DefenderAPI.Endpoint'
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-EntraRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}