# DNS

## host

### Name servers

Query name servers for a domain.

```sh title:"Query domain name servers"
host -t ns "$domain"
```
<!-- cheat
var domain
-->

### Mail servers

Query mail exchangers for a domain.

```sh title:"Query domain mail servers"
host -t mx "$domain"
```
<!-- cheat
var domain
-->

## dig

### Lookup

Resolve a name with a specific DNS server.

```sh title:"Resolve name with DNS server"
dig "$domain" @"$dns_server"
```
<!-- cheat
var domain
var dns_server := 1.1.1.1
-->

### Any records

Request ANY records from a DNS server.

```sh title:"Request ANY records"
dig ANY "$domain" @"$dns_server"
```
<!-- cheat
var domain
var dns_server
-->

### Reverse lookup

Perform a reverse DNS lookup.

```sh title:"Reverse DNS lookup"
dig -x "$rhost_ip" @"$dns_server"
```
<!-- cheat
var rhost_ip
var dns_server
-->

### Zone transfer

Attempt a DNS zone transfer.

```sh title:"Attempt DNS zone transfer"
dig axfr "$domain" @"$name_server"
```
<!-- cheat
var domain
var name_server
-->

### Public IP

Find your external public IP via OpenDNS.

```sh title:"Find external public IP"
dig +short myip.opendns.com @resolver1.opendns.com
```
<!-- cheat -->

### Batch A records

Resolve domains from a file and print answers.

```sh title:"Resolve domains from file"
dig -f "$domains_file" +noall +answer
```
<!-- cheat
var domains_file
-->

### Batch MX records

Resolve MX records for domains from a file.

```sh title:"Resolve MX records from file"
dig -f "$domains_file" MX +noall +answer
```
<!-- cheat
var domains_file
-->

## subdomains

### dnsenum

Run dnsenum against a domain.

```sh title:"Run dnsenum against domain"
dnsenum "$domain"
```
<!-- cheat
var domain
-->

### Sublist3r

Enumerate subdomains with Sublist3r.

```sh title:"Enumerate subdomains with Sublist3r"
sublist3r -d "$domain" -v
```
<!-- cheat
var domain
-->

### Sublist3r brute force

Run Sublist3r with brute force enabled.

```sh title:"Enumerate subdomains with Sublist3r brute force"
sublist3r -b -d "$domain"
```
<!-- cheat
var domain
-->

## nmap

### NSID

Fingerprint DNS with NSID.

```sh title:"Fingerprint DNS with NSID"
nmap -sV -p 53 --script dns-nsid "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### TCP scripts

Run safe DNS NSE scripts over TCP.

```sh title:"Run safe DNS NSE scripts over TCP"
nmap -n -sV --script "(*dns* and (default or (discovery and safe))) or dns-random-txid or dns-random-srcport" -p 53 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### UDP scripts

Run safe DNS NSE scripts over UDP.

```sh title:"Run safe DNS NSE scripts over UDP"
nmap -n -sV -sU --script "(*dns* and (default or (discovery and safe))) or dns-random-txid or dns-random-srcport" -p 53 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### AD SRV enum

Enumerate Active Directory DNS SRV records.

```sh title:"Enumerate AD DNS SRV records"
nmap --script dns-srv-enum --script-args "dns-srv-enum.domain=$domain" "$dns_server"
```
<!-- cheat
var domain
var dns_server
-->

### DNSSEC NSEC enum

Enumerate DNSSEC NSEC records.

```sh title:"Enumerate DNSSEC NSEC records"
nmap -sSU -p 53 --script dns-nsec-enum --script-args "dns-nsec-enum.domains=$domain" "$rhost_ip"
```
<!-- cheat
var domain
var rhost_ip
-->

## metasploit

### Enum DNS

Run Metasploit DNS enumeration.

```sh title:"Run Metasploit DNS enum"
msfconsole -x "use auxiliary/gather/enum_dns; set DOMAIN $domain; set NS $dns_server; run; exit"
```
<!-- cheat
var domain
var dns_server
-->
