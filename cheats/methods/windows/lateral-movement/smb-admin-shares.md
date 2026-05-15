---
technique: SMB Admin Shares
category: lateral-movement
targets: Windows Hosts
protocols: SMB
remote_capable: true
tags: windows lateral-movement smb admin-shares copy
---

# SMB Admin Shares

SMB admin shares provide file copy and staging paths on remote Windows hosts when the operator has administrative credentials.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Admin rights | Access to `ADMIN$`, `C$`, or similar shares requires admin rights |
| SMB access | TCP 445 must be reachable |
| Write path | Staged files need a writable destination |

## Windows

### List shares

#cmd #smb

List SMB shares on a remote host.

```cmd title:"List remote SMB shares"
net view "\\$rhost_name"
```
<!-- cheat
var rhost_name
-->

### Mount admin share

#cmd #smb

Authenticate to a remote administrative share.

```cmd title:"Mount remote admin share"
net use "\\$rhost_name\ADMIN$" "$pass" /user:"$user"
```
<!-- cheat
var rhost_name
var pass
var user
-->

### Copy to admin share

#cmd #smb

Copy a local file to a remote administrative share.

```cmd title:"Copy file to ADMIN share"
copy "$local_file" "\\$rhost_name\ADMIN$\Temp\$file_name"
```
<!-- cheat
var local_file
var rhost_name
var file_name
-->

### Delete staged file

#cmd #smb #cleanup

Delete a staged file from the remote administrative share.

```cmd title:"Delete staged ADMIN share file"
del "\\$rhost_name\ADMIN$\Temp\$file_name"
```
<!-- cheat
var rhost_name
var file_name
-->

## Linux

### smbclient admin share

#sh #smb

Connect to a remote administrative share with smbclient.

```sh title:"Connect to ADMIN share with smbclient"
smbclient "//$rhost_ip/ADMIN$" -U "$user%$pass"
```
<!-- cheat
var rhost_ip
var user
var pass
-->
