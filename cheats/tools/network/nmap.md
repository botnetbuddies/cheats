# Nmap

## nmap

### Default scan

Aggressive full TCP scan with version detection, default scripts, and OS guess. The standard "give me everything" first pass.

```sh title:"Nmap Aggressive all-port TCP, default scripts, OS guess"
sudo nmap -Pn -p- -A -n -T4 -vv $rhost_ip -oN default-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### Quick port discovery

All-ports TCP without scripts or version detection. Fast first sweep when you only want a port list.

```sh title:"Nmap All-port TCP only, no scripts, fastest first sweep"
nmap -Pn -p- -n -T4 -vv $rhost_ip -oN quick-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### Host discovery

Ping sweep a host range without port scanning.

```sh title:"Nmap Ping sweep host discovery"
nmap -sn $ip_range
```
<!-- cheat
var ip_range
-->

### Targets from file

Scan targets from a file.

```sh title:"Nmap Scan targets from file"
nmap -iL "$targets_file"
```
<!-- cheat
var targets_file
-->

### Top 100 TCP ports

Scan the top 100 TCP ports and show only open services.

```sh title:"Nmap Scan top 100 TCP ports"
nmap --top-ports 100 --open -sV $rhost_ip
```
<!-- cheat
var rhost_ip
-->

### Top 5000 TCP ports

Scan the top 5000 TCP ports and show only open services.

```sh title:"Nmap Scan top 5000 TCP ports"
nmap --top-ports 5000 --open -sV $rhost_ip
```
<!-- cheat
var rhost_ip
-->

### Specific ports

Scan a specific comma-separated port list.

```sh title:"Nmap Scan specific TCP ports"
nmap -p "$port_list" --open $rhost_ip
```
<!-- cheat
var port_list
var rhost_ip
-->

### Proxychains TCP scan

Scan through a proxy with a TCP connect scan.

```sh title:"Nmap TCP connect scan through proxychains"
proxychains nmap -sT -Pn -n --open -oA "$output_file" -iL "$targets_file"
```
<!-- cheat
var output_file
var targets_file
-->

### Top UDP ports

Top 100 UDP ports. Targets common UDP services (DNS, SNMP, NetBIOS) without the cost of full UDP enum.

```sh title:"Nmap Top 100 UDP ports, fast UDP triage"
sudo nmap -sU --top-ports 100 -T4 -vv $rhost_ip -oN udp-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### Slow SYN scan

Slower SYN scan with capped packet rate.

```sh title:"Nmap Slow SYN scan with capped rate"
sudo nmap -sS -T2 --max-rate 50 $rhost_ip
```
<!-- cheat
var rhost_ip
-->

## masscan

### Full TCP sweep

Fast full TCP port sweep with masscan.

```sh title:"Nmap Fast full TCP sweep with masscan"
sudo masscan -p1-65535 $rhost_ip --rate=1000 -i "$interface"
```
<!-- cheat
var rhost_ip
var interface
-->

### Service + default scripts

Service version detection plus the default NSE category. Run after the quick port scan to enrich the findings.

```sh title:"Nmap Run -sC -sV after a port list, enrich findings"
sudo nmap -Pn -sC -sV -vv $rhost_ip -oN svcs-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### HTTP discovery

HTTP-focused NSE on the common web ports.

```sh title:"Nmap HTTP NSE on 80/443/8080/8443"
sudo nmap -Pn -sV -p 80,443,8080,8443 --script "http* and discovery" $rhost_ip -oN http-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### SMB discovery

SMB-focused NSE on 139/445. Pulls OS, signing, share list and known SMB CVEs.

```sh title:"Nmap SMB NSE on 139/445, signing/CVEs/share list"
sudo nmap -Pn -sV -p 139,445 --script "smb* and discovery" $rhost_ip -oN smb-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### FTP discovery

FTP-focused NSE on port 21. Anonymous access, banner, bounce checks.

```sh title:"Nmap FTP NSE on 21 (anon/banner/bounce)"
sudo nmap -Pn -sV -p 21 --script "ftp* and discovery" $rhost_ip -oN ftp-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### DNS discovery

DNS service discovery, NSID fingerprinting, and zone transfer attempt.

```sh title:"Nmap DNS NSE: SD, NSID, attempt AXFR zone transfer"
sudo nmap -Pn -sV -p 53 --script "dns-service-discovery,dns-nsid,dns-zone-transfer" $rhost_ip -oN dns-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### MySQL discovery

MySQL info / databases / users / variables / config audit.

```sh title:"Nmap MySQL NSE: info/dbs/users/variables/audit"
sudo nmap -Pn -sV -p 3306 --script "mysql-info,mysql-databases,mysql-users,mysql-variables,mysql-audit" $rhost_ip -oN mysql-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### MSSQL discovery

MSSQL info, config, and the empty-password check (which can give instant access).

```sh title:"Nmap MSSQL NSE: info/config/empty-password check"
sudo nmap -Pn -sV -p 1433 --script "ms-sql-info,ms-sql-config,ms-sql-empty-password" $rhost_ip -oN mssql-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### RDP discovery

RDP encryption / NTLM info / MS12-020 vuln check.

```sh title:"Nmap RDP NSE: encryption + NTLM info + MS12-020"
sudo nmap -Pn -sV -p 3389 --script "rdp-enum-encryption,rdp-ntlm-info,rdp-vuln-ms12-020" $rhost_ip -oN rdp-disco-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### LDAP recon (auth-aware)

LDAP recon NSE on 389/636. `ldap-search` reads what your bind permits.

```sh title:"Nmap LDAP NSE on 389/636 (root DSE, search, novell, MS-DS)"
sudo nmap -Pn -sV -p 389,636 --script "ldap-rootdse,ldap-search,ldap-novell-getpass,ldap-microsoft-ds" $rhost_ip -oN ldap-recon-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### LDAP recon (unauth)

Wide unauth LDAP+SMB sweep. Catches anonymous-bind misconfigs across all the AD-relevant ports.

```sh title:"Nmap Wide unauth sweep of LDAP+SMB AD ports"
sudo nmap -p 88,135,139,389,445,464,593,636,3268,3389 --script="ldap*" --script="smb*" $rhost_ip -oN ldap-recon-$(date +%Y%m%d-%H%M%S).nmap
```
<!-- cheat
var rhost_ip
-->

### Kerberos user enum (unauth)

Brute existing usernames via Kerberos pre-auth error codes, no creds needed.

```sh title:"Nmap Kerberos user enum via pre-auth errors, no creds"
sudo nmap -p 88 --script krb5-enum-users --script-args krb5-enum-users.realm=$domain $rhost_ip
```
<!-- cheat
var rhost_ip
var domain
-->
