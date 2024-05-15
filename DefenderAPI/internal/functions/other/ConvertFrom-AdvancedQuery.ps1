function ConvertFrom-AdvancedQuery {
	<#
	.SYNOPSIS
		Converts the output of an Advanced Hunting Query into something PowerShell compatible.
	
	.DESCRIPTION
		Converts the output of an Advanced Hunting Query into something PowerShell compatible.
	
	.PARAMETER Result
		The result of the Invoke-MdeAdvancedQuery command.
	
	.EXAMPLE
		PS C:\> Invoke-MdeRequest -Path $__path -Method post -Body $__body -Query $__query -RequiredScopes 'AdvancedQuery.Read' | ConvertFrom-AdvancedQuery

		Processes the return values provided by the advanced query.
	#>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [AllowNull()]
        $Result
    )

    begin {
        $typeMapping = @{
            String   = '<direct>'
            Double   = '<direct>'
            SByte    = { $_ -as [bool] }
            DateTime = '<direct>'
            Object   = '<direct>'
        }
    }
    process {
        if (-not $Result) { return }

        $properties = foreach ($item in $Result.Schema) {
            if ((-not $typeMapping[$item.Type]) -or $typeMapping[$item.Type] -eq '<direct>') {
                $item.Name
                continue
            }
            @{
                Name       = $item.Name
                Expression = $typeMapping[$item.Type]
            }
        }
        $Result.Results | Select-Object $properties | ForEach-Object {
            $_.PSObject.TypeNames.Insert(0, 'DefenderAPI.AdvancedQuery.Result')
            $_
        }
    }
}