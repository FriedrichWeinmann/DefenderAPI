# Overrides

## Description

to override default conversion from swagger files, place psd1 files in this folder containing your override configurations.
Each such file should contain one hashtable with as many configuration entries as desired.

Each swagger entry override has a key made up of the relative endpoint path and the method:

```text
<path>:<method>
```

> The relative endpoint path is considered _after_ removing any prefixes specified in the ConvertFrom-ARSwagger call.

Under this key, you may then freely provide individual properties to override defaults.
Only provided values will be modified, otherwise the default content from the swagger-file will be assumed.

## Example

A simple example file-content:

```powershell
@{
    'alerts:get' = @{
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/get-alerts?view=o365-worldwide'
        Scopes = @('Alert.Read')
    }
    'alerts:post' = @{
        DocumentationUrl = 'https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/update-alert?view=o365-worldwide'
        Scopes = @('Alert.ReadWrite')
    }
}
```

This will add the link to the online documentation of the endpoint and the scopes needed to the commands wrapping the `alerts` endpoint - both `get` and `post`, which will be translated as `Get-Alert` and `Set-Alert`.

## Properties

The properties you can define in these settings.
Available in any combination.

### Name

Name of the command to generate

### Synopsis

Synopsis part of the command help

### Description

Description part of the command help

### DocumentationUrl

Link to the online documentation

### ServiceName

Specific service override to include.
Needs to be implemented in the Rest Command used.
This is designed for scenarii where the same authentication component can operate against multiple endpoints.

### Scopes

Scopes required in delegate authentication mode.
Will be included in help and passed to rest command.
The rest command needs to support a `-RequiredScopes` parameter.
Whether this information is honored by the rest command is up to the implementer.

### RestCommand

Command to use to execute the rest request and handle authentication.
This information is provided by the `ConvertFrom-ARSwagger` command consuming these files.
If however you want to override this command choice for individual endpoints, this is where you do it.

### ProcessorCommand

An additional command used to process the output.
This command must be implemented manually.
This is designed to be able to modify/affect output object layout, especially when dealing with less intuitive rest endpoints.

### ParameterSets

Hashtable mapping parameterset name to its description.
These strings are then used in the command help examples, explaining the call.

### Parameters

To override individual properties on parameters, create a child-hashtable.
Each key is the system name of the parameter, entries govern the properties to override.
Example:

```powershell
@{
    'machines/{MachineID}/recommendations:get' = @{
        Parameters = @{
            MachineID = @{
                Help = 'ID of the machine to get recommendations for.'
                ValueFromPipeline = $true
            }
        }
    }
}
```

Parameters have the following properties you can override:

+ Name: Name of the parameter
+ Help: Parameter help included in the Comment-Based Help
+ Alias: Additional aliases to include in the parameter - useful when implementing pipeline support
+ Weight: The weight defines the order in which parameters are included, which affects tab-completion order.
+ ValueFromPipeline: Whether it directly accepts from the pipeline (rather than just 'ByPropertyName')
+ ParameterSet: List of parameter sets the parameter is a part of. _Replaces_ the default value.

## Global Parameter Settings

Want to apply the same setting to _all_ parameters of a given name?
Well, you _can_ using global parameter settings.

For this, you create a root key named "globalParameters", followed directly by the parameter-node, as documented above.

Example:

```powershell
@{
    globalParameters = @{
        VulnerabilityID = @{
            Alias = 'Id'
        }
    }
}
```

> This will add the alias "Id" to every single parameter on all commands with the name "VulnerabilityID"

## Scope Parameter Settings

Similar to global parameter settings, it is possible to define parameter config for more than one endpoint, by scoping it to the relative endpoint with a wildcard pattern.
With that it is for example possible, to affect all parameters of a given name, but only for commands targeting one of the `machine/*` endpoints.

This is similar to the global settings, only using "scopedParameters" instead and having an intermediate level for the path pattern.

Example:

```powershell
@{
    scopedParameters = @{
        'machines/*' = @{
            MachineID = @{
                Alias = 'Id'
            }
        }
    }
}
```
