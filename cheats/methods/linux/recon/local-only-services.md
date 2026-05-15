---
technique: Local-Only Service Recon
category: recon
targets: Linux Local Services
protocols: TCP, UDP
remote_capable: false
tags: linux recon localhost services tunneling
---

# Local-Only Service Recon

Local-only service recon targets services bound to loopback or internal interfaces that become reachable only after shell access.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Local shell | Commands run from the compromised host |
| Scanning tools | `ss`, `nmap`, `nc`, or curl improve service triage |

## Linux

### Loopback listeners

#sh #network #services

List services bound to loopback addresses.

```sh title:"List loopback listeners"
ss -lntup "src 127.0.0.1"
```
<!-- cheat -->

### Localhost TCP scan

#sh #nmap #localhost

Scan localhost for open TCP ports.

```sh title:"Scan localhost TCP ports"
nmap -Pn --open -p- 127.0.0.1
```
<!-- cheat -->

### Fingerprint localhost ports

#sh #nmap #localhost

Fingerprint discovered localhost service ports.

```sh title:"Fingerprint localhost services"
nmap -Pn -sV -p "$ports" 127.0.0.1
```
<!-- cheat
var ports
-->

### HTTP localhost probe

#sh #curl #localhost

Probe a local HTTP service.

```sh title:"Probe localhost HTTP service"
curl -i "http://127.0.0.1:$rport/"
```
<!-- cheat
var rport
-->

### Manual TCP probe

#sh #nc #localhost

Connect to a local TCP service manually.

```sh title:"Connect to localhost TCP service"
nc 127.0.0.1 "$rport"
```
<!-- cheat
var rport
-->

## Detection

Local service recon appears as localhost port scans, loopback probes, and follow-on SSH tunnels to previously local-only ports.
