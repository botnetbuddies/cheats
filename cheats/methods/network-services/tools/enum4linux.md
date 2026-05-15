---
tool: enum4linux
category: tools
targets: SMB, NetBIOS, Windows Hosts
protocols: SMB, NetBIOS, RPC
remote_capable: true
tags: network-services smb enum4linux tools
---

# enum4linux

enum4linux automates common SMB, NetBIOS, and RPC enumeration checks against Windows and Samba hosts.

## Linux

### Full enum

#sh #enum4linux #smb

Run broad SMB enumeration.

```sh title:"Run enum4linux full enumeration"
enum4linux -a "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Null session

#sh #enum4linux #smb

Run null-session enumeration.

```sh title:"Run enum4linux null-session enumeration"
enum4linux -n "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Authenticated enum

#sh #enum4linux #smb

Run authenticated SMB enumeration.

```sh title:"Run enum4linux authenticated enumeration"
enum4linux -u "$user" -p "$pass" "$rhost_ip"
```
<!-- cheat
var user
var pass
var rhost_ip
-->
