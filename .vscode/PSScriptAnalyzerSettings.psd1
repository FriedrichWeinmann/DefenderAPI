@{
    Rules = @{
        ReviewUnusedParameter = @{
            CommandsToTraverse = @(
                'Invoke-PSFProtectedCommand'
            )
        }
    }
	IncludeRules = @(
		'*'
	)
	ExcludeRules = @(
		'PSAvoidTrailingWhitespace'
	)
}