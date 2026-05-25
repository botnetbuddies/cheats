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

Scan full local scan with linPEAS.

```sh title:"LinPEAS Scan Full Local Scan"
./linpeas.sh
```
<!-- cheat -->

### Quiet scan

#sh #linpeas #recon

Scan quiet scan with linPEAS.

```sh title:"LinPEAS Scan Quiet Scan"
./linpeas.sh -q
```
<!-- cheat -->

### Network scan mode

#sh #linpeas #network

Scan network scan mode with linPEAS.

```sh title:"LinPEAS Scan Network Scan Mode"
./linpeas.sh -t
```
<!-- cheat -->

### CIDR discovery

#sh #linpeas #network

Discover CIDR discovery with linPEAS.

```sh title:"LinPEAS Discover CIDR Discovery"
./linpeas.sh -d "$cidr"
```
<!-- cheat
var cidr
-->

### Host port scan

#sh #linpeas #network

Scan host port scan with linPEAS.

```sh title:"LinPEAS Scan Host Port Scan"
./linpeas.sh -i "$rhost_ip" -p "$ports"
```
<!-- cheat
var rhost_ip
var ports
-->
