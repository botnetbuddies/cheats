# PowerUp

## checks

### All checks

Run all PowerUp privilege escalation checks.

```powershell title:"Run PowerUp checks"
Invoke-AllChecks
```
<!-- cheat -->

### Service abuse checks

Find service abuse opportunities with PowerUp.

```powershell title:"PowerUp Find service abuse paths"
Get-ModifiableServiceFile
```
<!-- cheat -->

### Unquoted services

Find unquoted service path issues.

```powershell title:"Find unquoted services with PowerUp"
Get-ServiceUnquoted
```
<!-- cheat -->
