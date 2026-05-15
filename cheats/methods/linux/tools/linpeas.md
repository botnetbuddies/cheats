---
tool: linPEAS
category: linux-tool
tags: linux tool linpeas recon privilege-escalation
---

# linPEAS

linPEAS automates Linux privilege escalation enumeration and can also run focused network discovery modes.

## Linux

### Full local scan

#sh #linpeas #recon

Run linPEAS local enumeration.

```sh title:"Run linPEAS local scan"
./linpeas.sh
```
<!-- cheat -->

### Quiet scan

#sh #linpeas #recon

Run linPEAS with reduced output noise.

```sh title:"Run linPEAS quiet scan"
./linpeas.sh -q
```
<!-- cheat -->

### Network scan mode

#sh #linpeas #network

Run linPEAS in network discovery mode.

```sh title:"Run linPEAS network scan"
./linpeas.sh -t
```
<!-- cheat -->

### CIDR discovery

#sh #linpeas #network

Run host discovery against a CIDR range.

```sh title:"Run linPEAS CIDR discovery"
./linpeas.sh -d "$cidr"
```
<!-- cheat
var cidr
-->

### Host port scan

#sh #linpeas #network

Scan selected ports on one host.

```sh title:"Run linPEAS host port scan"
./linpeas.sh -i "$rhost_ip" -p "$ports"
```
<!-- cheat
var rhost_ip
var ports
-->
