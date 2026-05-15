---
technique: DNS Enumeration
category: recon
targets: DNS
protocols: DNS
remote_capable: true
tags: network-services dns recon zone-transfer
---

# DNS Enumeration

DNS enumeration identifies authoritative name servers, mail exchangers, records, reverse names, and zone transfer exposure.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Domain | Requires a target domain or reverse zone |
| Resolver | Use target name servers when testing zone transfer |
| UDP/TCP 53 | Both transports may matter |

## Linux

### Name servers

#sh #dns #host

Query name servers for a domain.

```sh title:"Query domain name servers"
host -t ns "$domain"
```
<!-- cheat
var domain
-->

### Mail servers

#sh #dns #host

Query mail exchangers for a domain.

```sh title:"Query domain mail servers"
host -t mx "$domain"
```
<!-- cheat
var domain
-->

### Resolve through server

#sh #dns #dig

Resolve a name through a specific DNS server.

```sh title:"Resolve name through DNS server"
dig "$domain" @"$dns_server"
```
<!-- cheat
var domain
var dns_server
-->

### Reverse lookup

#sh #dns #dig

Perform a reverse DNS lookup.

```sh title:"Perform reverse DNS lookup"
dig -x "$rhost_ip" @"$dns_server"
```
<!-- cheat
var rhost_ip
var dns_server
-->

### Zone transfer

#sh #dns #dig

Attempt a DNS zone transfer.

```sh title:"Attempt DNS zone transfer"
dig axfr "$domain" @"$name_server"
```
<!-- cheat
var domain
var name_server
-->

### DNS NSE scripts

#sh #nmap #dns

Run DNS discovery scripts.

```sh title:"Run DNS discovery scripts"
nmap -n -sV -p 53 --script dns-nsid "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->
