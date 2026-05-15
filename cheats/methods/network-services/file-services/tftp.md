---
technique: TFTP Enumeration
category: file-services
targets: TFTP
protocols: TFTP, UDP
remote_capable: true
tags: network-services tftp udp files
---

# TFTP Enumeration

TFTP has no built-in authentication and is commonly useful for configuration file retrieval when UDP 69 is exposed.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| UDP 69 | Requires TFTP reachability |
| Known filename | TFTP usually requires guessing or knowing file names |
| Local path | Download target writes to the current directory |

## Linux

### Service detection

#sh #nmap #tftp

Run TFTP service detection.

```sh title:"Run TFTP service detection"
nmap -sU -p 69 --script tftp-enum "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Connect

#sh #tftp

Open an interactive TFTP client.

```sh title:"Connect to TFTP"
tftp "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Download file

#sh #tftp

Download a known file from TFTP.

```sh title:"Download file from TFTP"
tftp "$rhost_ip" -c get "$remote_file"
```
<!-- cheat
var rhost_ip
var remote_file
-->
