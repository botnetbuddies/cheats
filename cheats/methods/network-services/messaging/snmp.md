---
technique: SNMP Enumeration
category: messaging
targets: SNMP
protocols: SNMP, UDP
remote_capable: true
tags: network-services snmp udp community
---

# SNMP Enumeration

SNMP enumeration can reveal system metadata, interfaces, routes, installed software, processes, and sometimes writable configuration.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| UDP 161 | Requires SNMP reachability |
| Community | v1/v2c access depends on community string |
| Version | v3 requires username and auth/privacy settings |

## Linux

### Service detection

#sh #nmap #snmp

Run UDP SNMP service detection.

```sh title:"Run SNMP UDP service detection"
nmap -sU --open -p 161 -sC -sV "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### SNMP walk

#sh #snmpwalk #snmp

Walk the SNMP tree with a community string.

```sh title:"Walk SNMP tree"
snmpwalk -c "$community" -v "$snmp_version" "$rhost_ip"
```
<!-- cheat
var community := public
var snmp_version := 1
var rhost_ip
-->

### Process list

#sh #snmpwalk #snmp

List running processes over SNMP.

```sh title:"List running processes over SNMP"
snmpwalk -c "$community" -v "$snmp_version" "$rhost_ip" 1.3.6.1.2.1.25.4.2.1.2
```
<!-- cheat
var community := public
var snmp_version := 1
var rhost_ip
-->

### snmp-check

#sh #snmp-check #snmp

Run snmp-check against a target.

```sh title:"Run snmp-check"
snmp-check -t "$rhost_ip" -c "$community" -p "$rport"
```
<!-- cheat
var rhost_ip
var community := public
var rport := 161
-->

### Community brute force

#sh #nmap #snmp

Brute force SNMP community strings with nmap.

```sh title:"Brute force SNMP communities"
nmap -sU --open -p 161 --script snmp-brute --script-args "snmp-brute.communitiesdb=$community_file" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var community_file
-->
