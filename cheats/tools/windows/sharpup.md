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

Check audit checks with SharpUp.

```cmd title:"SharpUp Check Audit Checks"
SharpUp.exe audit
```
<!-- cheat -->

### Service checks

#cmd #sharpup

Check service checks with SharpUp.

```cmd title:"SharpUp Check Service Checks"
SharpUp.exe audit Services
```
<!-- cheat -->

### Modifiable paths

#cmd #sharpup

Check modifiable paths with SharpUp.

```cmd title:"SharpUp Check Modifiable Paths"
SharpUp.exe audit ModifiablePaths
```
<!-- cheat -->
