---
technique: FTP Enumeration
category: file-services
targets: FTP
protocols: FTP
remote_capable: true
tags: network-services ftp anonymous files
---

# FTP Enumeration

FTP enumeration checks banner data, anonymous access, writable paths, and downloadable content.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 21 | Requires FTP reachability |
| Credentials | Anonymous access may be enabled or disabled per server |
| Transfer mode | Passive and active mode behavior may differ through firewalls |

## Linux

### Connect

#sh #ftp

Connect to FTP on the default port.

```sh title:"Connect to FTP"
ftp "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Custom port

#sh #ftp

Connect to FTP on a custom port.

```sh title:"Connect to FTP on custom port"
ftp "$rhost_ip" "$rport"
```
<!-- cheat
var rhost_ip
var rport := 21
-->

### Anonymous access

#sh #nmap #ftp

Check for anonymous FTP access.

```sh title:"Check anonymous FTP access"
nmap -v -p 21 --script ftp-anon "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Mirror anonymous

#sh #wget #ftp

Mirror an anonymous FTP server.

```sh title:"Mirror anonymous FTP server"
wget -m "ftp://anonymous:anonymous@$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Mirror anonymous active mode

#sh #wget #ftp

Mirror an anonymous FTP server without passive mode.

```sh title:"Mirror anonymous FTP without passive mode"
wget -m --no-passive "ftp://anonymous:anonymous@$rhost_ip"
```
<!-- cheat
var rhost_ip
-->
