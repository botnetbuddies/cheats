# SNMP

## recon

### Nmap scan

Run UDP SNMP service detection and default scripts.

```sh title:"Run SNMP UDP service detection"
nmap -sU --open -p 161 -sC -sV "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### snmpwalk

Walk the SNMP tree with a community string.

```sh title:"Walk SNMP tree"
snmpwalk -c "$community" -v "$snmp_version" "$rhost_ip"
```
<!-- cheat
var community := public
var snmp_version := 1
var rhost_ip
-->

### Processes

List running processes over SNMP.

```sh title:"List running processes over SNMP"
snmpwalk -c "$community" -v "$snmp_version" "$rhost_ip" 1.3.6.1.2.1.25.4.2.1.2
```
<!-- cheat
var community := private
var snmp_version := 1
var rhost_ip
-->

### snmp-check

Run snmp-check against a target and port.

```sh title:"Run snmp-check"
snmp-check -t "$rhost_ip" -c "$community" -p "$rport"
```
<!-- cheat
var rhost_ip
var community := public
var rport := 161
-->

## brute force

### Nmap communities

Brute force SNMP community strings with nmap.

```sh title:"Brute force SNMP communities with nmap"
nmap -sU --open -p 161 --script snmp-brute --script-args "snmp-brute.communitiesdb=$community_file" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var community_file
-->

### onesixtyone defaults

Check `public`, `private`, and `manager` communities against hosts in an input file.

```sh title:"Check common SNMP communities with onesixtyone"
printf 'public\nprivate\nmanager\n' > community.txt; onesixtyone -c community.txt -i "$hosts_file"; rm -f community.txt
```
<!-- cheat
var hosts_file
-->
