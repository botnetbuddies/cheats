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

Find services writable by the current user.

```cmd title:"AccessChk Find writable services"
accesschk.exe -uwcqv %USERNAME% * /accepteula
```
<!-- cheat -->

### Service permissions

#cmd #accesschk #services

Check permissions on a specific service.

```cmd title:"AccessChk Check service permissions"
accesschk.exe -ucqv "$service_name"
```
<!-- cheat
var service_name
-->

### Writable directories

#cmd #accesschk #filesystem

Find writable directories under a target path.

```cmd title:"Find writable directories with AccessChk"
accesschk.exe -uwdqs "$target_dir" /accepteula
```
<!-- cheat
var target_dir
-->

### Registry key permissions

#cmd #accesschk #registry

Check permissions on a registry key.

```cmd title:"AccessChk Check registry key permissions"
accesschk.exe -k "$registry_key"
```
<!-- cheat
var registry_key
-->
