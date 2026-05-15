---
tool: rpcclient
category: tools
targets: SMB, MSRPC
protocols: MSRPC, SMB
remote_capable: true
tags: network-services smb rpc rpcclient tools
---

# rpcclient

rpcclient queries MSRPC interfaces over SMB and is useful for users, groups, domains, sessions, shares, and policy data.

## Linux

### Null session

#sh #rpcclient #smb

Connect with a null session.

```sh title:"Connect rpcclient with null session"
rpcclient -U "" "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Authenticated session

#sh #rpcclient #smb

Connect with credentials.

```sh title:"Connect rpcclient with credentials"
rpcclient -U "$user%$pass" "$rhost_ip"
```
<!-- cheat
var user
var pass
var rhost_ip
-->

### Domain users

#sh #rpcclient #smb

Enumerate domain users with an rpcclient command.

```sh title:"Enumerate users with rpcclient"
rpcclient -U "$user%$pass" -c enumdomusers "$rhost_ip"
```
<!-- cheat
var user
var pass
var rhost_ip
-->

### Domain groups

#sh #rpcclient #smb

Enumerate domain groups with an rpcclient command.

```sh title:"Enumerate groups with rpcclient"
rpcclient -U "$user%$pass" -c enumdomgroups "$rhost_ip"
```
<!-- cheat
var user
var pass
var rhost_ip
-->
