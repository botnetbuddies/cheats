---
technique: RDP Credential Artifacts
category: credentials
targets: Windows User Profiles
protocols: RDP
remote_capable: false
tags: windows credentials rdp mstsc dpapi
---

# RDP Credential Artifacts

RDP credential artifacts include saved target history, `.rdp` files, and Credential Manager entries created by Remote Desktop clients.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User profile access | RDP artifacts are stored per user |
| DPAPI context | Saved credentials require user context or DPAPI material |

## Windows

### RDP servers history

#cmd #rdp #registry

List saved RDP server history.

```cmd title:"List RDP server history"
reg query "HKCU\Software\Microsoft\Terminal Server Client\Servers"
```
<!-- cheat -->

### Default RDP file

#cmd #rdp

Read the default RDP connection file.

```cmd title:"Read default RDP file"
type "%USERPROFILE%\Documents\Default.rdp"
```
<!-- cheat -->

### Find RDP files

#cmd #rdp

Find RDP connection files in the current user profile.

```cmd title:"Find RDP files"
dir "%USERPROFILE%\*.rdp" /s /b
```
<!-- cheat -->

### Saved TERMSRV credentials

#cmd #cmdkey #rdp

List saved RDP credentials in Credential Manager.

```cmd title:"List saved RDP credentials"
cmdkey /list:TERMSRV
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows RDP credential artifacts.
