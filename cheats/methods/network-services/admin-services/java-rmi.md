---
technique: Java RMI Enumeration
category: admin-services
targets: Java RMI
protocols: Java RMI
remote_capable: true
tags: network-services java rmi
---

# Java RMI Enumeration

Java RMI enumeration checks exposed registries, bound names, and unsafe remote object surfaces.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 1099 | Default RMI registry port |
| Java tooling | Some checks require Java RMI tools |
| Scope | Remote object interaction must stay in authorized targets |

## Linux

### Service detection

#sh #nmap #rmi

Run Java RMI registry scripts.

```sh title:"Run Java RMI registry scripts"
nmap -sV -p "$rport" --script rmi-dumpregistry "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 1099
-->

### Registry dump

#sh #rmg #rmi

Dump RMI registry bindings with remote-method-guesser.

```sh title:"Dump RMI registry bindings"
rmg enum "$rhost_ip" "$rport"
```
<!-- cheat
var rhost_ip
var rport := 1099
-->

### Known endpoint probe

#sh #rmg #rmi

Probe a known RMI bound name.

```sh title:"Probe known RMI bound name"
rmg call "$rhost_ip" "$rport" "$bound_name"
```
<!-- cheat
var rhost_ip
var rport := 1099
var bound_name
-->
