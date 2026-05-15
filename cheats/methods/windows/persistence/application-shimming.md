---
technique: Application Shimming Persistence
category: persistence
targets: Windows Application Compatibility
protocols: Local
remote_capable: false
tags: windows persistence appcompat shim sdb
---

# Application Shimming Persistence

Application shimming persistence installs an application compatibility database that changes how selected programs launch or load helper DLLs.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Administrative access | Machine-wide shim database installation requires admin |
| Prepared SDB | Shim database construction belongs in a tool or payload note |
| Target executable | The shim must match a program that will run |

## Windows

### List installed shims

#cmd #shim #registry

List installed application compatibility custom databases.

```cmd title:"List installed shim databases"
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Custom"
```
<!-- cheat -->

### Install shim database

#cmd #shim #persistence

Install a prepared shim database.

```cmd title:"Install shim database"
sdbinst.exe "$sdb_file"
```
<!-- cheat
var sdb_file
-->

### Uninstall shim database

#cmd #shim #cleanup

Uninstall a prepared shim database.

```cmd title:"Uninstall shim database"
sdbinst.exe -u "$sdb_file"
```
<!-- cheat
var sdb_file
-->

## Linux

No Linux operator command is included here. This note covers Windows application shimming persistence.
