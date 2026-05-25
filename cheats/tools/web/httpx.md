---
tool: httpx
category: tools
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web httpx recon tools
---

# httpx

httpx probes HTTP services at scale and collects status, title, technologies, TLS data, and response metadata.

## Linux

### Probe hosts

#sh #httpx #web

Probe hosts with httpx.

```sh title:"Httpx Probe Hosts"
httpx -l "$hosts_file"
```
<!-- cheat
var hosts_file
-->

### Probe metadata

#sh #httpx #web

Probe metadata with httpx.

```sh title:"Httpx Probe Metadata"
httpx -l "$hosts_file" -status-code -title -tech-detect -web-server
```
<!-- cheat
var hosts_file
-->

### Screenshot probe

#sh #httpx #web

Probe screenshot probe with httpx.

```sh title:"Httpx Probe Screenshot Probe"
httpx -l "$hosts_file" -screenshot
```
<!-- cheat
var hosts_file
-->
