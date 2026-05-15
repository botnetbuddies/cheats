---
technique: DLL Proxying Persistence
category: persistence
targets: Windows Applications
protocols: Local
remote_capable: false
tags: windows persistence dll-proxying sideloading
---

# DLL Proxying Persistence

DLL proxying persistence replaces or shadows an expected DLL with a proxy DLL that forwards exports while running operator code.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Writable application directory | Operator must write beside the target executable or DLL |
| Prepared proxy DLL | Proxy DLL generation belongs in a tool or payload note |
| Target launch | The application must run and load the proxy DLL |

## Windows

### Target directory permissions

#cmd #filesystem #dll

Check permissions on the target application directory.

```cmd title:"Check target application directory permissions"
icacls "$directory_path"
```
<!-- cheat
var directory_path
-->

### Loaded DLLs

#powershell #dll #processes

List loaded modules for a target process.

```powershell title:"List loaded process DLLs"
Get-Process -Id "$pid" -Module
```
<!-- cheat
var pid
-->

### Step 1: Move original DLL

#cmd #dll #persistence

Move the original DLL to the proxy's expected backing name.

```cmd title:"Move original DLL for proxying"
move "$original_dll" "$backing_dll"
```
<!-- cheat
var original_dll
var backing_dll
-->

### Step 2: Place proxy DLL

#cmd #dll #persistence

Copy the prepared proxy DLL to the original DLL path.

```cmd title:"Place proxy DLL"
copy "$proxy_dll" "$original_dll"
```
<!-- cheat
var proxy_dll
var original_dll
-->

## Linux

No Linux operator command is included here. This note covers Windows DLL proxying persistence.
