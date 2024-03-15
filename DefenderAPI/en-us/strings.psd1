# This is where the strings go, that are written by
# Write-PSFMessage, Stop-PSFFunction or the PSFramework validation scriptblocks
@{
	'Connect-DefenderAPI.Connect.Browser'         = 'Connecting to {0} via Browser' # $serviceName
	'Connect-DefenderAPI.Connect.Certificate'     = 'Connection to {0} via certificate {1} ({2})' # $serviceName, $certificateObject.Subject, $certificateObject.Thumbprint
	'Connect-DefenderAPI.Connect.ClientSecret'    = 'Connecting to {0} via ClientSecret' # $serviceName
	'Connect-DefenderAPI.Connect.DeviceCode'      = 'Connecting to {0} via DeviceCode' # $serviceName
	'Connect-DefenderAPI.Connect.ROPC'            = 'Connecting to {0} via Credentials' # $serviceName
	'Connect-DefenderAPI.Error.CertError'         = 'Failed to connect to {0} via Certificate due to certificate errors' # $serviceName
	'Connect-ServiceBrowser.AuthorizeUri'         = 'Authorize Uri: {0}' # $uriFinal
	'Invoke-DefenderAPIRequest.Error.QueryFailed' = 'Failed to execute {0} against {1}' # $Method, $Path
	'Invoke-DefenderAPIRequest.Query.Throttling'  = 'Request is being throttled, waiting for {0} seconds' # $delay
	'Invoke-DefenderAPIRequest.Request'           = 'Executing {0} against {1}' # $Method, $parameters.Uri
}