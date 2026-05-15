---
technique: Linux Network Sniffing
category: credentials
targets: Linux Network Interfaces
protocols: TCP, UDP, HTTP
remote_capable: false
tags: linux credentials sniffing tcpdump dumpcap pcap
---

# Linux Network Sniffing

Network sniffing captures local or loopback traffic that may contain plaintext credentials, session tokens, or service secrets.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Capture permission | Root or capture capabilities are usually required |
| Useful interface | Loopback and internal interfaces often carry local service secrets |
| Parser | Captured PCAPs usually need later review with tcpdump or tshark |

## Linux

### Capture capability

#sh #capabilities #sniffing

Check whether dumpcap has packet capture capabilities.

```sh title:"Check dumpcap capabilities"
getcap "$dumpcap_path"
```
<!-- cheat
var dumpcap_path
-->

### List capture interfaces

#sh #tcpdump #sniffing

List interfaces available to tcpdump.

```sh title:"List tcpdump interfaces"
tcpdump -D
```
<!-- cheat -->

### Capture interface to PCAP

#sh #tcpdump #sniffing

Capture packets from an interface to a PCAP file.

```sh title:"Capture interface traffic"
tcpdump -i "$interface" -s 0 -n -w "$pcap_file"
```
<!-- cheat
var interface
var pcap_file
-->

### Capture loopback HTTP

#sh #tcpdump #sniffing

Capture plaintext HTTP traffic on loopback.

```sh title:"Capture loopback HTTP traffic"
tcpdump -i lo -s 0 -A -n "tcp port $rport"
```
<!-- cheat
var rport
-->

### Read PCAP ASCII

#sh #tcpdump #pcap

Print ASCII payloads from a PCAP file.

```sh title:"Read PCAP ASCII payloads"
tcpdump -A -r "$pcap_file"
```
<!-- cheat
var pcap_file
-->

## Detection

Monitor packet capture tools, reads of raw interfaces, and new PCAP files in temporary or user-writable directories.
