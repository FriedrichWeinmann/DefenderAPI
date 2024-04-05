function Invoke-DefenderAPIRequest
{
<#
	.SYNOPSIS
		Executes a web request against a defender endpoint.
	
	.DESCRIPTION
		Executes a web request against a defender endpoint.
		Handles all the authentication details once connected using Connect-DefenderAPIService.
	
	.PARAMETER Path
		The relative path of the endpoint to query.
		For example, to retrieve defender for endpoint alerts, it would be a plain "alerts".
		To access details on a particular machine instead it would look thus: "machines/1e5bc9d7e413ddd7902c2932e418702b84d0cc07"
	
	.PARAMETER Body
		Any body content needed for the request.

    .PARAMETER Query
        Any query content to include in the request.
        In opposite to -Body this is attached to the request Url and usually used for filtering.
	
	.PARAMETER Method
		The Rest Method to use.
		Defaults to GET
	
	.PARAMETER RequiredScopes
		Any authentication scopes needed.
		Used for documentary purposes only.

	.PARAMETER Header
		Any additional headers to include on top of authentication and content-type.
	
	.PARAMETER Service
		Which service to execute against.
		Determines the API endpoint called to.
		Defaults to "Endpoint"

	.PARAMETER SerializationDepth
		How deeply to serialize the request body when converting it to json.
		Defaults to the value in the 'DefenderAPI.Request.SerializationDepth' configuration setting.
		This in turn defaults to "99"
	
	.EXAMPLE
		PS C:\> Invoke-DefenderAPIRequest -Path 'alerts' -RequiredScopes 'Alert.Read'
	
		Return a list of defender alerts.
#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]
		$Path,
		
		[Hashtable]
		$Body = @{ },

        [Hashtable]
        $Query = @{ },
		
		[string]
		$Method = 'GET',
		
		[string[]]
		$RequiredScopes,

		[hashtable]
		$Header = @{},
		
		[PsfArgumentCompleter('DefenderAPI.Service')]
		[PsfValidateSet(TabCompletion = 'DefenderAPI.Service')]
		[string]
		$Service = 'Endpoint',

		[ValidateRange(1,666)]
		[int]
		$SerializationDepth = (Get-PSFConfigValue -FullName 'DefenderAPI.Request.SerializationDepth' -Fallback 99)
	)
	
	begin{
		Assert-DefenderAPIConnection -Service $Service -Cmdlet $PSCmdlet -RequiredScopes $RequiredScopes
		$token = $script:_DefenderTokens.$Service
	}
	process
	{
        $parameters = @{
            Method = $Method
            Uri = "$($token.ServiceUrl.Trim("/"))/$($Path.TrimStart('/'))"
        }
        if ($Body.Count -gt 0) {
            $parameters.Body = $Body | ConvertTo-Json -Compress -Depth $SerializationDepth
        }
        if ($Query.Count -gt 0) {
            $parameters.Uri += ConvertTo-QueryString -QueryHash $Query
        }

		while ($parameters.Uri) {
			$parameters.Headers = $token.GetHeader() + $Header # GetHeader() automatically refreshes expried tokens
			Write-PSFMessage -Level Debug -String 'Invoke-DefenderAPIRequest.Request' -StringValues $Method, $parameters.Uri
			try { $result = Invoke-RestMethod @parameters -ErrorAction Stop }
			catch {
				$letItBurn = $true
				$failure = $_

				if ($_.ErrorDetails.Message) {
					$details = $_.ErrorDetails.Message | ConvertFrom-Json
					if ($details.Error.Code -eq 'TooManyRequests') {
						Write-PSFMessage -Level Verbose -Message $details.error.message
						$delay = 1 + ($details.error.message -replace '^.+ (\d+) .+$','$1' -as [int])
						if ($delay -gt 5) { Write-PSFMessage -Level Warning -String 'Invoke-DefenderAPIRequest.Query.Throttling' -StringValues $delay }
						Start-Sleep -Seconds $delay
						try {
							$result = Invoke-RestMethod @parameters -ErrorAction Stop
							$letItBurn = $false
						}
						catch {
							$failure = $_
						}
					}
				}

				if ($letItBurn) {
					Stop-PSFFunction -String 'Invoke-DefenderAPIRequest.Error.QueryFailed' -StringValues $Method, $Path -ErrorRecord $failure -EnableException $true -Cmdlet $PSCmdlet
				}
			}
			if ($result.PSObject.Properties.Where{ $_.Name -eq 'value' }) { $result.Value }
			else { $result }
			$parameters.Uri = $result.'@odata.nextLink'
		}
	}
}