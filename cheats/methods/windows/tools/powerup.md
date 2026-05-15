---
tool: PowerUp
category: windows-tool
tags: windows tool powerup privilege-escalation powershell
---

# PowerUp

PowerUp checks Windows privilege escalation misconfigurations and can generate abuse commands for common service, registry, and path issues.

## Windows

### All checks

#powershell #powerup

Run all PowerUp checks.

```powershell title:"Run PowerUp checks"
Invoke-AllChecks
```
<!-- cheat -->

### Service abuse checks

#powershell #powerup #services

Find service abuse opportunities with PowerUp.

```powershell title:"Find service abuse paths"
Get-ModifiableServiceFile
```
<!-- cheat -->

### Unquoted services

#powershell #powerup #services

Find unquoted service path issues.

```powershell title:"Find unquoted services with PowerUp"
Get-ServiceUnquoted
```
<!-- cheat -->
