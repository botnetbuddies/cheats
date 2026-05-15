---
technique: Password Filter DLL Persistence
category: persistence
targets: Windows LSA
protocols: Local
remote_capable: false
tags: windows persistence password-filter lsa dll
---

# Password Filter DLL Persistence

Password filter persistence registers a prepared DLL that LSASS loads to inspect password changes.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Administrative access | Registry and System32 writes require admin or SYSTEM |
| Prepared filter DLL | Payload construction belongs in a tool or payload note |
| Reboot or LSASS restart | Notification packages load when LSASS starts |

## Windows

### Query notification packages

#cmd #registry #lsa

Query LSA notification packages.

```cmd title:"Query password filter packages"
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "Notification Packages"
```
<!-- cheat -->

### Step 1: Copy password filter DLL

#cmd #lsa #persistence

Copy a prepared password filter DLL into System32.

```cmd title:"Copy password filter DLL"
copy "$dll_path" "C:\Windows\System32\$dll_name"
```
<!-- cheat
var dll_path
var dll_name
-->

### Step 2: Register notification package

#cmd #registry #lsa

Set the LSA notification package list to include the prepared DLL name.

```cmd title:"Register password filter package"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "Notification Packages" /t REG_MULTI_SZ /d "$package_list" /f
```
<!-- cheat
var package_list
-->

## Linux

No Linux operator command is included here. This note covers Windows password filter persistence.
