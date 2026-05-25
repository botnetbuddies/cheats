# SNMP

## recon

### Nmap scan

Scan nmap scan with SNMP.

Run UDP SNMP service detection and default scripts.

```sh title:"SNMP Scan Nmap Scan"
nmap -sU --open -p 161 -sC -sV "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### snmpwalk

Enumerate snmpwalk with SNMP.

Walk the SNMP tree with a community string.

```sh title:"SNMP Enumerate Snmpwalk"
snmpwalk -c "$community" -v "$snmp_version" "$rhost_ip"
```
<!-- cheat
var community := public
var snmp_version := 1
var rhost_ip
-->

### Processes

List processes with SNMP.

List running processes over SNMP.

```sh title:"SNMP List Processes"
snmpwalk -c "$community" -v "$snmp_version" "$rhost_ip" 1.3.6.1.2.1.25.4.2.1.2
```
<!-- cheat
var community := private
var snmp_version := 1
var rhost_ip
-->

### snmp-check

Check snmp check with SNMP.

Run snmp-check against a target and port.

```sh title:"SNMP Check Snmp Check"
snmp-check -t "$rhost_ip" -c "$community" -p "$rport"
```
<!-- cheat
var rhost_ip
var community := public
var rport := 161
-->

## brute force

### Nmap communities

Run nmap communities with SNMP.

Brute force SNMP community strings with nmap.

```sh title:"SNMP Run Nmap Communities"
nmap -sU --open -p 161 --script snmp-brute --script-args "snmp-brute.communitiesdb=$community_file" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var community_file
-->

### onesixtyone defaults

Check onesixtyone defaults with SNMP.

Check `public`, `private`, and `manager` communities against hosts in an input file.

```sh title:"SNMP Check Onesixtyone Defaults"
printf 'public\nprivate\nmanager\n' > community.txt; onesixtyone -c community.txt -i "$hosts_file"; rm -f community.txt
```
<!-- cheat
var hosts_file
-->
