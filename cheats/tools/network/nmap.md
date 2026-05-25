# Nmap

## nmap

### Default scan

Scan default scan with Nmap.

Aggressive full TCP scan with version detection, default scripts, and OS guess. The standard "give me everything" first pass.

```sh title:"Nmap Scan Default Scan"
sudo nmap -Pn -p- -A -n -T4 -vv $rhost_ip -oN default-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### Quick port discovery

Discover quick port discovery with Nmap.

All-ports TCP without scripts or version detection. Fast first sweep when you only want a port list.

```sh title:"Nmap Discover Quick Port Discovery"
nmap -Pn -p- -n -T4 -vv $rhost_ip -oN quick-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### Host discovery

Discover host discovery with Nmap.

Ping sweep a host range without port scanning.

```sh title:"Nmap Discover Host Discovery"
nmap -sn $ip_range
```
<!-- cheat
var ip_range
-->

### Targets from file

Scan targets from file with Nmap.

Scan targets from a file.

```sh title:"Nmap Scan Targets from File"
nmap -iL "$targets_file"
```
<!-- cheat
var targets_file
-->

### Top 100 TCP ports

Scan top 100 TCP ports with Nmap.

Scan the top 100 TCP ports and show only open services.

```sh title:"Nmap Scan Top 100 TCP Ports"
nmap --top-ports 100 --open -sV $rhost_ip
```
<!-- cheat
var rhost_ip
-->

### Top 5000 TCP ports

Scan top 5000 TCP ports with Nmap.

Scan the top 5000 TCP ports and show only open services.

```sh title:"Nmap Scan Top 5000 TCP Ports"
nmap --top-ports 5000 --open -sV $rhost_ip
```
<!-- cheat
var rhost_ip
-->

### Specific ports

Scan specific ports with Nmap.

Scan a specific comma-separated port list.

```sh title:"Nmap Scan Specific Ports"
nmap -p "$port_list" --open $rhost_ip
```
<!-- cheat
var port_list
var rhost_ip
-->

### Proxychains TCP scan

Scan proxychains TCP scan with Nmap.

Scan through a proxy with a TCP connect scan.

```sh title:"Nmap Scan Proxychains TCP Scan"
proxychains nmap -sT -Pn -n --open -oA "$output_file" -iL "$targets_file"
```
<!-- cheat
var output_file
var targets_file
-->

### Top UDP ports

Run top UDP ports with Nmap.

Top 100 UDP ports. Targets common UDP services (DNS, SNMP, NetBIOS) without the cost of full UDP enum.

```sh title:"Nmap Run Top UDP Ports"
sudo nmap -sU --top-ports 100 -T4 -vv $rhost_ip -oN udp-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### Slow SYN scan

Scan slow SYN scan with Nmap.

Slower SYN scan with capped packet rate.

```sh title:"Nmap Scan Slow SYN Scan"
sudo nmap -sS -T2 --max-rate 50 $rhost_ip
```
<!-- cheat
var rhost_ip
-->

## masscan

### Full TCP sweep

Scan full TCP sweep with Nmap.

Fast full TCP port sweep with masscan.

```sh title:"Nmap Scan Full TCP Sweep"
sudo masscan -p1-65535 $rhost_ip --rate=1000 -i "$interface"
```
<!-- cheat
var rhost_ip
var interface
-->

### Service + default scripts

Scan service + default scripts with Nmap.

Service version detection plus the default NSE category. Run after the quick port scan to enrich the findings.

```sh title:"Nmap Scan Service + Default Scripts"
sudo nmap -Pn -sC -sV -vv $rhost_ip -oN svcs-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### HTTP discovery

Scan HTTP discovery with Nmap.

HTTP-focused NSE on the common web ports.

```sh title:"Nmap Scan HTTP Discovery"
sudo nmap -Pn -sV -p 80,443,8080,8443 --script "http* and discovery" $rhost_ip -oN http-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### SMB discovery

Scan SMB discovery with Nmap.

SMB-focused NSE on 139/445. Pulls OS, signing, share list and known SMB CVEs.

```sh title:"Nmap Scan SMB Discovery"
sudo nmap -Pn -sV -p 139,445 --script "smb* and discovery" $rhost_ip -oN smb-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### FTP discovery

Scan FTP discovery with Nmap.

FTP-focused NSE on port 21. Anonymous access, banner, bounce checks.

```sh title:"Nmap Scan FTP Discovery"
sudo nmap -Pn -sV -p 21 --script "ftp* and discovery" $rhost_ip -oN ftp-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### DNS discovery

Scan DNS discovery with Nmap.

DNS service discovery, NSID fingerprinting, and zone transfer attempt.

```sh title:"Nmap Scan DNS Discovery"
sudo nmap -Pn -sV -p 53 --script "dns-service-discovery,dns-nsid,dns-zone-transfer" $rhost_ip -oN dns-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### MySQL discovery

Scan MySQL discovery with Nmap.

MySQL info / databases / users / variables / config audit.

```sh title:"Nmap Scan MySQL Discovery"
sudo nmap -Pn -sV -p 3306 --script "mysql-info,mysql-databases,mysql-users,mysql-variables,mysql-audit" $rhost_ip -oN mysql-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### MSSQL discovery

Dump MSSQL discovery with Nmap.

MSSQL info, config, and the empty-password check (which can give instant access).

```sh title:"Nmap Dump MSSQL Discovery"
sudo nmap -Pn -sV -p 1433 --script "ms-sql-info,ms-sql-config,ms-sql-empty-password" $rhost_ip -oN mssql-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### RDP discovery

Scan RDP discovery with Nmap.

RDP encryption / NTLM info / MS12-020 vuln check.

```sh title:"Nmap Scan RDP Discovery"
sudo nmap -Pn -sV -p 3389 --script "rdp-enum-encryption,rdp-ntlm-info,rdp-vuln-ms12-020" $rhost_ip -oN rdp-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### LDAP recon (auth-aware)

Scan LDAP recon (auth aware) with Nmap.

LDAP recon NSE on 389/636. `ldap-search` reads what your bind permits.

```sh title:"Nmap Scan LDAP Recon (auth Aware)"
sudo nmap -Pn -sV -p 389,636 --script "ldap-rootdse,ldap-search,ldap-novell-getpass,ldap-microsoft-ds" $rhost_ip -oN ldap-recon-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### LDAP recon (unauth)

Scan LDAP recon (unauth) with Nmap.

Wide unauth LDAP+SMB sweep. Catches anonymous-bind misconfigs across all the AD-relevant ports.

```sh title:"Nmap Scan LDAP Recon (unauth)"
sudo nmap -p 88,135,139,389,445,464,593,636,3268,3389 --script="ldap*" --script="smb*" $rhost_ip -oN ldap-recon-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### Kerberos user enum (unauth)

Scan kerberos user enum (unauth) with Nmap.

Brute existing usernames via Kerberos pre-auth error codes, no creds needed.

```sh title:"Nmap Scan Kerberos User Enum (unauth)"
sudo nmap -p 88 --script krb5-enum-users --script-args krb5-enum-users.realm=$domain $rhost_ip
```
<!-- cheat
var rhost_ip
var domain
-->
