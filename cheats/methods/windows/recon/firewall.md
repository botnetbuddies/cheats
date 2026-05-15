---
technique: Windows Firewall Recon
category: recon
targets: Windows Firewall
protocols: Local
remote_capable: false
tags: windows firewall netsh rdp recon
---

# Windows Firewall Recon

Windows Firewall profile state and inbound rules affect lateral movement, remote administration, and payload callbacks. Check firewall posture before assuming a remote path is blocked by credentials or service state.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Shell access | Commands run locally on the Windows host |
| Administrative rights | Changing firewall state or rules requires elevation |

## Windows

### Show firewall state

#cmd #firewall

Show Windows Firewall state for all profiles.

```cmd title:"Show Windows Firewall state"
netsh advfirewall show allprofiles
```
<!-- cheat -->

### Disable firewall

#cmd #firewall

Disable Windows Firewall for all profiles.

```cmd title:"Disable Windows Firewall for all profiles"
netsh advfirewall set allprofiles state off
```
<!-- cheat -->

### Enable firewall

#cmd #firewall

Enable Windows Firewall for all profiles.

```cmd title:"Enable Windows Firewall for all profiles"
netsh advfirewall set allprofiles state on
```
<!-- cheat -->

### Open RDP firewall rule

#cmd #firewall #rdp

Open inbound TCP 3389 for Remote Desktop.

```cmd title:"Open RDP firewall rule"
netsh firewall add portopening TCP 3389 "Remote Desktop"
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers local Windows Firewall commands.
