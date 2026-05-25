---
tool: Nikto
category: tools
targets: Web Servers
protocols: HTTP, HTTPS
remote_capable: true
tags: web nikto scanner tools
---

# Nikto

Nikto checks web servers for risky files, old software, dangerous methods, and common misconfigurations.

## Linux

### Basic scan

#sh #nikto #web

Scan basic scan with Nikto.

```sh title:"Nikto Scan Basic Scan"
nikto -h "$url"
```
<!-- cheat
var url
-->

### SSL scan

#sh #nikto #web

Scan SSL scan with Nikto.

```sh title:"Nikto Scan SSL Scan"
nikto -h "$host" -ssl
```
<!-- cheat
var host
-->

### Custom port

#sh #nikto #web

Execute custom port with Nikto.

```sh title:"Nikto Execute Custom Port"
nikto -h "$host" -p "$port"
```
<!-- cheat
var host
var port
-->
