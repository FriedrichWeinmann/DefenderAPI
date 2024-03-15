Register-PSFTeppScriptblock -Name 'DefenderAPI.Service' -ScriptBlock {
	(Get-DefenderAPIService).Name
} -Global