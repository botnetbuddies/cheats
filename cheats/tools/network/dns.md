# DNS

## host

### Name servers

Enumerate name servers with DNS.

Query name servers for a domain.

```sh title:"DNS Enumerate Name Servers"
host -t ns "$domain"
```
<!-- cheat
var domain
-->

### Mail servers

Enumerate mail servers with DNS.

Query mail exchangers for a domain.

```sh title:"DNS Enumerate Mail Servers"
host -t mx "$domain"
```
<!-- cheat
var domain
-->

## dig

### Lookup

Start lookup with DNS.

Resolve a name with a specific DNS server.

```sh title:"DNS Start Lookup"
dig "$domain" @"$dns_server"
```
<!-- cheat
var domain
var dns_server := 1.1.1.1
-->

### Any records

Run any records with DNS.

Request ANY records from a DNS server.

```sh title:"DNS Run Any Records"
dig ANY "$domain" @"$dns_server"
```
<!-- cheat
var domain
var dns_server
-->

### Reverse lookup

Start reverse lookup with DNS.

Perform a reverse DNS lookup.

```sh title:"DNS Start Reverse Lookup"
dig -x "$rhost_ip" @"$dns_server"
```
<!-- cheat
var rhost_ip
var dns_server
-->

### Zone transfer

Run zone transfer with DNS.

Attempt a DNS zone transfer.

```sh title:"DNS Run Zone Transfer"
dig axfr "$domain" @"$name_server"
```
<!-- cheat
var domain
var name_server
-->

### Public IP

Find public IP with DNS.

Find your external public IP via OpenDNS.

```sh title:"DNS Find Public IP"
dig +short myip.opendns.com @resolver1.opendns.com
```
<!-- cheat -->

### Batch A records

Run batch a records with DNS.

Resolve domains from a file and print answers.

```sh title:"DNS Run Batch a Records"
dig -f "$domains_file" +noall +answer
```
<!-- cheat
var domains_file
-->

### Batch MX records

Run batch MX records with DNS.

Resolve MX records for domains from a file.

```sh title:"DNS Run Batch MX Records"
dig -f "$domains_file" MX +noall +answer
```
<!-- cheat
var domains_file
-->

## subdomains

### dnsenum

Enumerate dnsenum with DNS.

Run dnsenum against a domain.

```sh title:"DNS Enumerate Dnsenum"
dnsenum "$domain"
```
<!-- cheat
var domain
-->

### Sublist3r

List sublist3r with DNS.

Enumerate subdomains with Sublist3r.

```sh title:"DNS List Sublist3r"
sublist3r -d "$domain" -v
```
<!-- cheat
var domain
-->

### Sublist3r brute force

List sublist3r brute force with DNS.

Run Sublist3r with brute force enabled.

```sh title:"DNS List Sublist3r Brute Force"
sublist3r -b -d "$domain"
```
<!-- cheat
var domain
-->

## nmap

### NSID

Run NSID with DNS.

Fingerprint DNS with NSID.

```sh title:"DNS Run NSID"
nmap -sV -p 53 --script dns-nsid "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### TCP scripts

Execute TCP scripts with DNS.

Run safe DNS NSE scripts over TCP.

```sh title:"DNS Execute TCP Scripts"
nmap -n -sV --script "(*dns* and (default or (discovery and safe))) or dns-random-txid or dns-random-srcport" -p 53 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### UDP scripts

Execute UDP scripts with DNS.

Run safe DNS NSE scripts over UDP.

```sh title:"DNS Execute UDP Scripts"
nmap -n -sV -sU --script "(*dns* and (default or (discovery and safe))) or dns-random-txid or dns-random-srcport" -p 53 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### AD SRV enum

Enumerate AD SRV enum with DNS.

Enumerate Active Directory DNS SRV records.

```sh title:"DNS Enumerate AD SRV Enum"
nmap --script dns-srv-enum --script-args "dns-srv-enum.domain=$domain" "$dns_server"
```
<!-- cheat
var domain
var dns_server
-->

### DNSSEC NSEC enum

Enumerate DNSSEC NSEC enum with DNS.

Enumerate DNSSEC NSEC records.

```sh title:"DNS Enumerate DNSSEC NSEC Enum"
nmap -sSU -p 53 --script dns-nsec-enum --script-args "dns-nsec-enum.domains=$domain" "$rhost_ip"
```
<!-- cheat
var domain
var rhost_ip
-->

## metasploit

### Enum DNS

Enumerate enum DNS with DNS.

Run Metasploit DNS enumeration.

```sh title:"DNS Enumerate Enum DNS"
msfconsole -x "use auxiliary/gather/enum_dns; set DOMAIN $domain; set NS $dns_server; run; exit"
```
<!-- cheat
var domain
var dns_server
-->
