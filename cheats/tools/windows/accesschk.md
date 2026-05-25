---
tool: AccessChk
category: windows-tool
tags: windows tool accesschk permissions services filesystem
---

# AccessChk

AccessChk enumerates effective permissions across services, files, directories, registry keys, and named pipes.

## Windows

### Writable services

#cmd #accesschk #services

Find writable services with AccessChk.

```cmd title:"AccessChk Find Writable Services"
accesschk.exe -uwcqv %USERNAME% * /accepteula
```
<!-- cheat -->

### Service permissions

#cmd #accesschk #services

Check service permissions with AccessChk.

```cmd title:"AccessChk Check Service Permissions"
accesschk.exe -ucqv "$service_name"
```
<!-- cheat
var service_name
-->

### Writable directories

#cmd #accesschk #filesystem

Find writable directories with AccessChk.

```cmd title:"AccessChk Find Writable Directories"
accesschk.exe -uwdqs "$target_dir" /accepteula
```
<!-- cheat
var target_dir
-->

### Registry key permissions

#cmd #accesschk #registry

Check registry key permissions with AccessChk.

```cmd title:"AccessChk Check Registry Key Permissions"
accesschk.exe -k "$registry_key"
```
<!-- cheat
var registry_key
-->
