@{

# Script module or binary module file associated with this manifest.
RootModule = 'DefenderAPI.psm1'

# Version number of this module.
ModuleVersion = '0.8.5'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '8918ef5d-0aa3-4397-8340-02dc4aca90bb'

# Author of this module
Author = 'Friedrich Weinmann'

# Company or vendor of this module
CompanyName = ' '

# Copyright statement for this module
Copyright = 'Copyright (c) 2024 Friedrich Weinmann'

# Description of the functionality provided by this module
Description = 'Implements the defender API'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(
	@{ModuleName = 'PSFramework'; ModuleVersion = '1.10.318'; }
	@{ModuleName = 'EntraAuth'; ModuleVersion = '1.0.4' }
)

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @('xml\DefenderAPI.Format.ps1xml')

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Assert-DefenderAPIConnection', 'Connect-DefenderAPI', 
               'Get-DefenderAPIService', 'Get-DefenderAPIToken', 
               'Register-DefenderAPIService', 'Set-DefenderAPIService', 
               'Invoke-DefenderAPIRequest', 'Invoke-MdAdvancedQuery', 
               'Set-MdAdvancedQuerySchema', 'Get-MdAlert', 'New-MdAlert', 
               'Set-MdAlert', 'Get-MdDeviceSecureScore', 'Get-MdExposureScore', 
               'Get-MdMachineGroupExposureScore', 'Get-MdFile', 'Get-MdFileAlert', 
               'Get-MdFileMachine', 'Get-MdIndicator', 'New-MdIndicator', 
               'Remove-MdIndicator', 'Get-MdInvestigation', 
               'Get-MdLiveResponseResultDownloadLink', 'Get-MdMachineAction', 
               'Get-MdMachineactionGetpackageuri', 'Set-MdMachineactionCancel', 
               'Disable-MdMachineIsolation', 'Enable-MdMachineIsolation', 
               'Get-MdMachine', 'Get-MdMachineRecommendation', 
               'Get-MdMachineSoftware', 'Get-MdMachineVulnerability', 
               'Set-MdMachineCollectinvestigationpackage', 'Set-MdMachineOffboard', 
               'Set-MdMachineRestrictcodeexecution', 
               'Set-MdMachineRunantivirusscan', 'Set-MdMachineStartinvestigation', 
               'Set-MdMachineStopandquarantinefile', 'Set-MdMachineTag', 
               'Set-MdMachineUnrestrictcodeexecution', 
               'Start-MdMachineLiveResponse', 'Get-MdRecommendation', 
               'Get-MdRecommendationMachineReference', 
               'Get-MdRecommendationSoftware', 'Get-MdRecommendationVulnerability', 
               'Get-MdSoftware', 'Get-MdSoftwareDistribution', 
               'Get-MdSoftwareMachinereference', 'Get-MdSoftwareVulnerability', 
               'Get-MdVulnerability', 'Get-MdVulnerableMachine', 
               'Invoke-MSecAdvancedHuntingQuery'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('defender','api','entra','mde','endpoint')

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/FriedrichWeinmann/DefenderAPI/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/FriedrichWeinmann/DefenderAPI'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/FriedrichWeinmann/DefenderAPI/blob/master/DefenderAPI/changelog.md'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

