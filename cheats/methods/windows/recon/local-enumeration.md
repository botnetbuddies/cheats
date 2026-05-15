---
technique: Windows Local Enumeration
category: recon
targets: Windows Workstation, Windows Server
protocols: Local
remote_capable: false
tags: windows recon local-enumeration users services processes registry
---

# Windows Local Enumeration

Local Windows enumeration establishes host role, patch level, user context, logged-on sessions, running processes, services, network state, and credential storage policy. Run these commands before choosing a privilege escalation or credential access path.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Shell access | Commands run from a local CMD or PowerShell context |
| User context | Low-privileged users can run most recon commands |
| Output path | Capture output when operating through unstable shells |

## Windows

### System information

#cmd #system

Print OS version, hotfixes, domain role, and hardware details.

```cmd title:"Print Windows system information"
systeminfo
```
<!-- cheat -->

### Hostname

#cmd #system

Print the local hostname.

```cmd title:"Print hostname"
hostname
```
<!-- cheat -->

### Current privileges

#cmd #token

List the current user's token privileges.

```cmd title:"Print current token privileges"
whoami /priv
```
<!-- cheat -->

### Local users

#powershell #users

List local users with enabled state and last logon time.

```powershell title:"List local users with last logon"
Get-LocalUser | ft Name,Enabled,LastLogon
```
<!-- cheat -->

### Administrators group members

#powershell #groups

List members of the local Administrators group.

```powershell title:"List local Administrators group members"
Get-LocalGroupMember Administrators | ft Name, PrincipalSource
```
<!-- cheat -->

### Interactive sessions

#cmd #sessions

List interactive logon sessions.

```cmd title:"List interactive sessions with qwinsta"
qwinsta
```
<!-- cheat -->

### Process list

#cmd #processes

List running processes with verbose metadata.

```cmd title:"List running processes verbosely"
tasklist /V
```
<!-- cheat -->

### Processes with services

#cmd #services

Map processes to hosted services.

```cmd title:"List processes with associated services"
tasklist /SVC
```
<!-- cheat -->

### Services

#cmd #services

List Windows services.

```cmd title:"List Windows services with sc"
sc query
```
<!-- cheat -->

### Scheduled tasks

#cmd #scheduled-tasks

List scheduled tasks with verbose task details.

```cmd title:"List scheduled tasks verbosely"
schtasks /query /fo LIST /v
```
<!-- cheat -->

### Network interfaces

#powershell #network

List local interface IP configuration.

```powershell title:"List interface IP configuration"
Get-NetIPConfiguration
```
<!-- cheat -->

### ARP cache

#cmd #network

Print the ARP cache.

```cmd title:"Print ARP cache"
arp -a
```
<!-- cheat -->

### Hosts file

#cmd #network

Read the Windows hosts file.

```cmd title:"Read Windows hosts file"
type C:\Windows\System32\drivers\etc\hosts
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers local commands from a Windows shell.

## Additional Local Enumeration Commands

## System Info

### OS version (powershell)

```powershell title:"Get current OS version object via [Environment]"
[System.Environment]::OSVersion.Version
```
<!-- cheat -->

### patches (powershell)

```powershell title:"List all installed hotfix IDs via WMI"
Get-WmiObject -query 'select * from win32_quickfixengineering' | foreach {$_.hotfixid}
```
<!-- cheat -->

### security patches only

```powershell title:"Filter Get-Hotfix to security updates only"
Get-Hotfix -description "Security update"
```
<!-- cheat -->

### env vars (powershell)

```powershell title:"Dump all environment variables in PowerShell"
Get-ChildItem Env: | ft Key,Value -AutoSize
```
<!-- cheat -->

### PS history (current user)

```cmd title:"Read PSReadline history file via type"
type %userprofile%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
```
<!-- cheat -->

### PS history (env)

```powershell title:"Read PSReadline history using $env:APPDATA"
type $env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
```
<!-- cheat -->

### PS history path

```powershell title:"Locate the active PSReadline history file"
cat (Get-PSReadlineOption).HistorySavePath
```
<!-- cheat -->

### grep PS history for passwords

```powershell title:"Search PSReadline history for password mentions"
cat (Get-PSReadlineOption).HistorySavePath | sls passw
```
<!-- cheat -->

### Transcription policy (HKCU)

```cmd title:"Check user-level PowerShell transcription policy"
reg query HKCU\Software\Policies\Microsoft\Windows\PowerShell\Transcription
```
<!-- cheat -->

### Transcription policy (HKLM)

```cmd title:"Check machine-level PowerShell transcription policy"
reg query HKLM\Software\Policies\Microsoft\Windows\PowerShell\Transcription
```
<!-- cheat -->

### transcript directory

```cmd title:"List the configured PowerShell transcript directory"
dir C:\Transcripts
```
<!-- cheat -->

### start transcript

```powershell title:"Start a PowerShell transcript to file"
Start-Transcript -Path "C:\transcripts\transcript0.txt" -NoClobber
```
<!-- cheat -->

### Module Logging policy (HKCU)

```cmd title:"Check user-level PowerShell module logging policy"
reg query HKCU\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
```
<!-- cheat -->

### Module Logging policy (HKLM)

```cmd title:"Check machine-level PowerShell module logging policy"
reg query HKLM\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
```
<!-- cheat -->

### last 15 PS log events

```powershell title:"Show last 15 entries from Windows PowerShell event log"
Get-WinEvent -LogName "windows Powershell" | select -First 15 | Out-GridView
```
<!-- cheat -->

### Script Block Logging policy (HKCU)

```cmd title:"Check user-level script-block logging policy"
reg query HKCU\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
```
<!-- cheat -->

### Script Block Logging policy (HKLM)

```cmd title:"Check machine-level script-block logging policy"
reg query HKLM\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
```
<!-- cheat -->

### last 20 PS operational events

```powershell title:"Show last 20 entries from PowerShell Operational log"
Get-WinEvent -LogName "Microsoft-Windows-Powershell/Operational" | select -first 20 | Out-Gridview
```
<!-- cheat -->

### Internet Settings (HKCU)

```cmd title:"Read user-level Internet Settings registry"
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
```
<!-- cheat -->

### Internet Settings (HKLM)

```cmd title:"Read machine-level Internet Settings registry"
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
```
<!-- cheat -->

### drives (cmd)

```cmd title:"List logical drives via WMIC"
wmic logicaldisk get caption,description,providername
```
<!-- cheat -->

### drives (powershell)

```powershell title:"List filesystem drives via Get-PSDrive"
Get-PSDrive | where {$_.Provider -like "Microsoft.PowerShell.Core\FileSystem"} | ft Name,Root
```
<!-- cheat -->


## Additional User, Group, and Process Enumeration Commands

## Users & Groups

### whoami

```cmd title:"Show current user info via net users"
net users %username%
```
<!-- cheat -->

### local users (WMI)

```powershell title:"Enumerate local users via Win32_UserAccount WMI class"
Get-WmiObject -Class Win32_UserAccount
```
<!-- cheat -->

### local users (with last logon)

```powershell title:"List local users with enabled flag and last logon time"
Get-LocalUser | ft Name,Enabled,LastLogon
```
<!-- cheat -->

### user home dirs

```powershell title:"List user profile directories under C:\Users"
Get-ChildItem C:\Users -Force | select Name
```
<!-- cheat -->

### Administrators members (powershell)

```powershell title:"List Administrators group members via Get-LocalGroupMember"
Get-LocalGroupMember Administrators | ft Name, PrincipalSource
```
<!-- cheat -->

### sessions (qwinsta)

```cmd title:"List interactive logon sessions on this host"
qwinsta
```
<!-- cheat -->

### Kerberos sessions

```cmd title:"List active Kerberos sessions for the current user"
klist sessions
```
<!-- cheat -->

### user home dirs (cmd)

```cmd title:"List C:\Users contents to enumerate profile dirs"
dir C:\Users
```
<!-- cheat -->

### clipboard

```powershell title:"Read current clipboard contents"
powershell -command "Get-Clipboard"
```
<!-- cheat -->

## Running Processes

### processes with services

```cmd title:"List running processes with associated services"
Tasklist /SVC
```
<!-- cheat -->

### SYSTEM processes

```cmd title:"List processes running as NT AUTHORITY\SYSTEM"
tasklist /v /fi "username eq system"
```
<!-- cheat -->

### non-svchost processes (WMI)

```powershell title:"Enumerate non-svchost processes with owner via WMI"
Get-WmiObject -Query "Select * from Win32_Process" | where {$_.Name -notlike "svchost*"} | Select Name, Handle, @{Label="Owner";Expression={$_.GetOwner().User}} | ft -AutoSize
```
<!-- cheat -->

### non-svchost processes

```powershell title:"List non-svchost processes via Get-Process"
Get-Process | where {$_.ProcessName -notlike "svchost*"} | ft ProcessName, Id
```
<!-- cheat -->

### process binary ACLs

```cmd title:"Find non-system process binaries the current user can write"
for /f "tokens=2 delims='='" %%x in ('wmic process list full^|find /i "executablepath"^|find /i /v "system32"^|find ":"') do (
    for /f eol^=^"^ delims^=^" %%z in ('echo %%x') do (
        icacls "%%z" 2>nul | findstr /i "(F) (M) (W) :\\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo.
    )
)
```
<!-- cheat -->

### process folder ACLs (DLL hijack)

```cmd title:"Find non-system process folders writable by current user (DLL hijack)"
for /f "tokens=2 delims='='" %%x in ('wmic process list full^|find /i "executablepath"^|find /i /v "system32"^|find ":"') do for /f eol^=^"^ delims^=^" %%y in ('echo %%x') do (
    icacls "%%~dpy\" 2>nul | findstr /i "(F) (M) (W) :\\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo.
)
```
<!-- cheat -->

### memory dump (procdump)

```cmd title:"Dump process memory with procdump for offline cred mining"
procdump.exe -accepteula -ma $proc_name
```
<!-- cheat
var proc_name
-->


## Additional Application and Driver Enumeration Commands

## Applications

### Program Files (64-bit)

```cmd title:"List installed apps under C:\Program Files"
dir /a "C:\Program Files"
```
<!-- cheat -->

### Program Files (x86)

```cmd title:"List installed apps under C:\Program Files (x86)"
dir /a "C:\Program Files (x86)"
```
<!-- cheat -->

### installed software (registry)

```cmd title:"List installed software via HKLM\SOFTWARE registry"
reg query HKLM\SOFTWARE
```
<!-- cheat -->

### Program Files (powershell, with timestamps)

```powershell title:"List Program Files with last write times via Get-ChildItem"
Get-ChildItem 'C:\Program Files', 'C:\Program Files (x86)' | ft Parent,Name,LastWriteTime
```
<!-- cheat -->

### installed software (powershell registry)

```powershell title:"List installed software via Registry::HKLM\SOFTWARE"
Get-ChildItem -path Registry::HKLM\SOFTWARE | ft Name
```
<!-- cheat -->

### writable dirs (Users)

```cmd title:"Find Users-writable directories under C:\"
accesschk.exe -uwdqs Users c:\
```
<!-- cheat -->

### writable dirs (Authenticated Users)

```cmd title:"Find Authenticated-Users-writable directories under C:\"
accesschk.exe -uwdqs "Authenticated Users" c:\
```
<!-- cheat -->

### writable dirs (Everyone)

```cmd title:"Find Everyone-writable directories under C:\"
accesschk.exe -uwdqs "Everyone" c:\
```
<!-- cheat -->

### writable files (Users)

```cmd title:"Find Users-writable files under C:\"
accesschk.exe -uwqs Users c:\*.*
```
<!-- cheat -->

### Program Files ACL check

```cmd title:"Check Program Files ACLs for write access by current user"
icacls "C:\Program Files\*" 2>nul | findstr "(F) (M) :\" | findstr ":\ everyone authenticated users todos %username%"
```
<!-- cheat -->

### Everyone-writable in Program Files

```powershell title:"Find Program Files items with Everyone ACE via Get-Acl"
Get-ChildItem 'C:\Program Files\*','C:\Program Files (x86)\*' | % { try { Get-Acl $_ -EA SilentlyContinue | Where {($_.Access|select -ExpandProperty IdentityReference) -match 'Everyone'} } catch {}}
```
<!-- cheat -->

### Users-writable in Program Files

```powershell title:"Find Program Files items with BUILTIN\Users ACE via Get-Acl"
Get-ChildItem 'C:\Program Files\*','C:\Program Files (x86)\*' | % { try { Get-Acl $_ -EA SilentlyContinue | Where {($_.Access|select -ExpandProperty IdentityReference) -match 'BUILTIN\Users'} } catch {}}
```
<!-- cheat -->

### loaded drivers

```cmd title:"List loaded drivers via driverquery"
driverquery
```
<!-- cheat -->

### drivers (table)

```cmd title:"List drivers in table format"
driverquery.exe /fo table
```
<!-- cheat -->

### signed drivers

```cmd title:"List signed driver info via driverquery /SI"
driverquery /SI
```
<!-- cheat -->

## PATH DLL Hijacking

## Additional Network and WSL Enumeration Commands

## Network

### shares (domain)

```cmd title:"List shares across a domain via net view"
net view /all /domain $domain
```
<!-- cheat
var domain
-->

### shares (remote host)

```cmd title:"List shares on a specific remote host"
net view \\$host /ALL
```
<!-- cheat
var host
-->

### mount share

```cmd title:"Mount a remote share to drive X:"
net use x: \\$host\$share
```
<!-- cheat
var host
var share
-->

### hosts file

```cmd title:"Read the Windows hosts file"
type C:\Windows\System32\drivers\etc\hosts
```
<!-- cheat -->

### interfaces (powershell)

```powershell title:"Show interface IPs via Get-NetIPConfiguration"
Get-NetIPConfiguration | ft InterfaceAlias,InterfaceDescription,IPv4Address
```
<!-- cheat -->

### DNS servers

```powershell title:"Show DNS servers via Get-DnsClientServerAddress"
Get-DnsClientServerAddress -AddressFamily IPv4 | ft
```
<!-- cheat -->

### routes (powershell)

```powershell title:"Show IPv4 routes via Get-NetRoute"
Get-NetRoute -AddressFamily IPv4 | ft DestinationPrefix,NextHop,RouteMetric,ifIndex
```
<!-- cheat -->

### ARP table (cmd)

```cmd title:"Show ARP table via arp -A"
arp -A
```
<!-- cheat -->

### ARP table (powershell)

```powershell title:"Show ARP neighbors via Get-NetNeighbor"
Get-NetNeighbor -AddressFamily IPv4 | ft ifIndex,IPAddress,LinkLayerAddress,State
```
<!-- cheat -->

### WSL bash

```cmd title:"Launch WSL bash shell"
C:\Windows\System32\bash.exe
```
<!-- cheat -->

### WSL run

```cmd title:"Run a single command in the default WSL distro"
wsl whoami
```
<!-- cheat -->

### WSL default user root

```cmd title:"Set a WSL distro's default user to root"
./ubuntun1604.exe config --default-user root
```
<!-- cheat -->

### WSL python pivot

```cmd title:"Run Python payload through WSL (cross-subsystem pivot)"
wsl python -c '$payload'
```
<!-- cheat
var payload
-->

