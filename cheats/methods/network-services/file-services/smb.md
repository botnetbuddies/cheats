---
technique: SMB Enumeration
category: file-services
targets: SMB
protocols: SMB
remote_capable: true
tags: network-services smb shares enum
---

# SMB Enumeration

SMB enumeration checks signing, null or guest access, readable shares, and authenticated file access.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 445 | Requires SMB reachability |
| Credentials | Null, guest, domain, or local credentials may each differ |
| Tooling | Commands use smbclient, smbmap, and nmap |

## Linux

### SMB signing

#sh #nmap #smb

Check SMB signing posture.

```sh title:"Check SMB signing"
nmap -Pn -sS -T4 --open --script smb-security-mode -p 445 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Null share enum

#sh #smbmap #smb

Enumerate shares with null access.

```sh title:"Enumerate SMB shares with null access"
smbmap -u "" -p "" -P 445 -H "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Guest share enum

#sh #smbmap #smb

Enumerate shares as guest.

```sh title:"Enumerate SMB shares as guest"
smbmap -u "guest" -p "" -P 445 -H "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Authenticated share enum

#sh #smbmap #smb

Enumerate shares with credentials.

```sh title:"Enumerate SMB shares with credentials"
smbmap -H "$rhost_ip" -u "$user" -p "$pass" -d "$domain"
```
<!-- cheat
var rhost_ip
var user
var pass
var domain
-->

### Share connection

#sh #smbclient #smb

Connect to a share with credentials.

```sh title:"Connect to SMB share"
smbclient "\\\\$rhost_ip\\$share" -U "$user%$pass"
```
<!-- cheat
var rhost_ip
var share
var user
var pass
-->

### Recursive share listing

#sh #smbmap #smb

Recursively list a readable path.

```sh title:"Recursively list SMB path"
smbmap -H "$rhost_ip" -u "$user" -p "$pass" -d "$domain" -R "$path" --depth "$depth"
```
<!-- cheat
var rhost_ip
var user
var pass
var domain
var path
var depth := 1
-->
