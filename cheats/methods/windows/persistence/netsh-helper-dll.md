---
technique: Netsh Helper DLL
category: persistence
targets: Windows Netsh
protocols: Local
remote_capable: false
tags: windows persistence netsh dll registry
---

# Netsh Helper DLL

Netsh can load helper DLLs that export the expected helper entry point. Adding a helper registers a DLL path under the Netsh registry key and can execute code when netsh loads the helper.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| DLL payload | The helper DLL must export the expected Netsh helper function |
| Registry write | Adding a helper usually requires administrative rights |
| Load trigger | netsh.exe must load the registered helper |

## Windows

### Add Netsh helper

#cmd #netsh #dll

Register a helper DLL with netsh.

```cmd title:"Add Netsh helper DLL"
netsh.exe add helper "$dll_path"
```
<!-- cheat
var dll_path
-->

### Show Netsh helpers

#cmd #netsh #registry

List registered netsh helpers from the registry.

```cmd title:"Query Netsh helper registry"
reg query "HKLM\SOFTWARE\Microsoft\NetSh"
```
<!-- cheat -->

### Run netsh

#cmd #netsh

Start netsh to load registered helpers.

```cmd title:"Start netsh"
netsh.exe
```
<!-- cheat -->

### Delete Netsh helper key

#cmd #registry #cleanup

Remove a registered helper value from the Netsh key.

```cmd title:"Delete Netsh helper registry value"
reg delete "HKLM\SOFTWARE\Microsoft\NetSh" /v "$helper_name" /f
```
<!-- cheat
var helper_name
-->

## Linux

No Linux operator command is included here. This note covers Windows-local netsh helper registration.

## Detection

Monitor netsh.exe helper registration and writes below `HKLM\SOFTWARE\Microsoft\NetSh`.
