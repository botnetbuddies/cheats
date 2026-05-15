---
technique: RODCGoldenTicket
category: kerberos-forged-tickets
targets: RODC-cached accounts
protocols: Kerberos
remote_capable: true
tags: kerberos rodc golden-ticket krbtgt-rodc ad persistence lateral-movement
---

# RODC Golden Ticket

A Read-Only Domain Controller (RODC) uses a unique `krbtgt_XXXXX` account (where XXXXX is the RODC's key version number) to sign TGTs it issues. With administrative access to an RODC, an attacker can dump all cached credentials including the RODC's krbtgt AES key. That key can be used to forge a TGT for any account listed in the RODC's `msDS-RevealOnDemandGroup` and absent from `msDS-NeverRevealGroup`. The forged TGT can be presented to the RODC itself or to any writable Domain Controller to obtain service tickets. When presented to a writable DC, the PAC is recalculated by the writable DC, so crafting the PAC in the forged ticket is unnecessary. The correct RODC key version number (`kvno`) must be embedded in the ticket's `kvno` field for it to be accepted.

## Windows

Rubeus golden with `/rodcNumber` forges the RODC-signed TGT from Windows.

### Rubeus golden (RODC)

#powershell #rubeus #tgt

Forge a RODC golden ticket embedding the correct key version number for the RODC krbtgt account.

```powershell title:"Forge RODC golden ticket via Rubeus"
.\Rubeus.exe golden /rodcNumber:$rodc_kvno /flags:forwardable,renewable,enc_pa_rep /nowrap /outfile:ticket.kirbi /aes256:$rodc_krbtgt_aes256 /user:$username /id:$user_rid /domain:$domain /sid:$domain_sid
```
<!-- cheat
var rodc_kvno
var rodc_krbtgt_aes256
var username
var user_rid
var domain
var domain_sid
-->

## Linux

No tooling was available for RODC golden ticket forgery from Linux at the time of the source documentation.
