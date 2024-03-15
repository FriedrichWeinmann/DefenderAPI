function Get-MdFile {
<#
.SYNOPSIS
    Files - Get a single file

.DESCRIPTION
    Retrieve from Windows Defender ATP a specific file by identifier Sha1, or Sha256

.PARAMETER FileID
    The file identifier - Sha1, or Sha256

.EXAMPLE
    PS C:\> Get-MdFile -FileID $fileid

    Retrieve from Windows Defender ATP a specific file by identifier Sha1, or Sha256

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $FileID
    )
    process {
		$__mapping = @{

		}

		$__param = @{
			Body = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Query = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Header = $PSBoundParameters | ConvertTo-HashTable -Include @() -Mapping $__mapping
			Path = 'files/{FileID}' -Replace '{FileID}',$FileID
			Method = 'get'
			
			
		}
		
		$__param += $PSBoundParameters | ConvertTo-HashTable -Include 'ErrorAction', 'WarningAction', 'Verbose'

		try { Invoke-DefenderAPIRequest @__param }
		catch { $PSCmdlet.ThrowTerminatingError($_) }
    }
}