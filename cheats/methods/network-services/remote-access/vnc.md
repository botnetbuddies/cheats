---
technique: VNC Enumeration
category: remote-access
targets: VNC
protocols: RFB
remote_capable: true
tags: network-services vnc remote-access gui
---

# VNC Enumeration

VNC enumeration checks server metadata, no-auth access, weak authentication, and GUI reachability.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 5900 | Requires VNC reachability |
| Display | Port commonly maps to display number |
| Viewer | Commands assume a VNC viewer is installed |

## Linux

### VNC info

#sh #nmap #vnc

Enumerate VNC information and title.

```sh title:"Enumerate VNC with nmap"
nmap -sV --script vnc-info,realvnc-auth-bypass,vnc-title -p "$rport" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 5900
-->

### No-auth check

#sh #metasploit #vnc

Check for VNC no-auth access.

```sh title:"Check VNC no-auth access"
msfconsole -x "use auxiliary/scanner/vnc/vnc_none_auth; set RHOSTS $rhost_ip; set RPORT $rport; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 5900
-->

### No-password connect

#sh #vnc

Connect to VNC without a password.

```sh title:"Connect to VNC without password"
vncviewer "$rhost_ip::$rport"
```
<!-- cheat
var rhost_ip
var rport := 5900
-->

### Password-file connect

#sh #vnc

Connect to VNC with a password file.

```sh title:"Connect to VNC with password file"
vncviewer -password "$password_file" "$rhost_ip::$rport"
```
<!-- cheat
var password_file
var rhost_ip
var rport := 5900
-->
