---
tool: SharpUp
category: windows-tool
tags: windows tool sharpup privilege-escalation
---

# SharpUp

SharpUp checks common Windows privilege escalation misconfigurations from a low-privileged context.

## Windows

### Audit checks

#cmd #sharpup

Run SharpUp audit checks.

```cmd title:"Run SharpUp audit"
SharpUp.exe audit
```
<!-- cheat -->

### Service checks

#cmd #sharpup

Run SharpUp service misconfiguration checks.

```cmd title:"Run SharpUp service checks"
SharpUp.exe audit Services
```
<!-- cheat -->

### Modifiable paths

#cmd #sharpup

Run SharpUp checks for modifiable paths.

```cmd title:"Run SharpUp modifiable path checks"
SharpUp.exe audit ModifiablePaths
```
<!-- cheat -->
