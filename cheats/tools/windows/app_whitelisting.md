# App Whitelisting

## installutil

### Execute with InstallUtil

Run a .NET assembly through InstallUtil uninstall mode.

```cmd title:"Execute .NET assembly with InstallUtil"
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\installutil.exe /logfile= /LogToConsole=false /U "$full_path_to_app"
```
<!-- cheat
var full_path_to_app
-->
