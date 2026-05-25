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

Probe hosts from a file.

```sh title:"Probe hosts with httpx"
httpx -l "$hosts_file"
```
<!-- cheat
var hosts_file
-->

### Probe metadata

#sh #httpx #web

Collect status, title, technologies, and web server metadata.

```sh title:"Collect HTTP metadata with httpx"
httpx -l "$hosts_file" -status-code -title -tech-detect -web-server
```
<!-- cheat
var hosts_file
-->

### Screenshot probe

#sh #httpx #web

Probe hosts and capture screenshots.

```sh title:"Capture screenshots with httpx"
httpx -l "$hosts_file" -screenshot
```
<!-- cheat
var hosts_file
-->
