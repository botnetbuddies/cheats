# DotNet

## tools

### DotNetToJScript

Execute DotNetToJScript with DotNet.

Convert a .NET assembly DLL to a JScript runner.

```cmd title:"DotNet Execute DotNetToJScript"
DotNetToJScript.exe "$dll_file" --lang=Jscript --ver=v4 -o "$jscript_file"
```
<!-- cheat
var dll_file := ExampleAssembly.dll
var jscript_file := runner.js
-->
