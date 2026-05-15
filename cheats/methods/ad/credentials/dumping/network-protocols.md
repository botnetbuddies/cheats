---
technique: NetworkProtocolCredentials
category: credential-dumping
targets: Plaintext Protocols, Captured Traffic
protocols: HTTP, FTP, SMTP, POP, IMAP, SNMP, LDAP, Kerberos, NTLM
remote_capable: true
tags: credential-dumping network-protocols pcredz pcap capture mitm ad
---

# NetworkProtocolCredentials

Plaintext and weakly protected internal protocols can expose passwords, hashes, tokens, and files once traffic passes through an attacker-controlled capture point. Use this after establishing a MITM position or collecting packet captures from infrastructure.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Traffic source | Use live interface capture or offline pcap files |
| MITM position | ARP poisoning, ICMP redirect, or another reroute path can feed live traffic |
| Protocol mix | PCredz parses NTLM, Kerberos AS-REQ etype 23, HTTP Basic, SNMP, POP, SMTP, FTP, IMAP, and more |

## Linux

### PCredz pcap file

#python #pcredz #pcap

Extract credentials from a single packet capture file.

```sh title:"Extract credentials from one pcap with PCredz"
Pcredz -f "$pcap_file"
```
<!-- cheat
var pcap_file
-->

### PCredz pcap directory

#python #pcredz #pcap

Extract credentials from all packet captures in a directory.

```sh title:"Extract credentials from pcap directory with PCredz"
Pcredz -d "$pcap_dir"
```
<!-- cheat
var pcap_dir
-->

### PCredz live interface

#python #pcredz #capture

Extract credentials from live traffic on a network interface.

```sh title:"Extract credentials from live traffic with PCredz"
Pcredz -i "$interface" -v
```
<!-- cheat
var interface
-->

### tcpdump capture

#native #pcap #capture

Capture traffic to a pcap file for later credential parsing.

```sh title:"Capture traffic to pcap with tcpdump"
tcpdump -i "$interface" -w "$pcap_file"
```
<!-- cheat
var interface
var pcap_file
-->
