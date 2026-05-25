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

Run a basic Nikto scan.

```sh title:"Run Nikto scan"
nikto -h "$url"
```
<!-- cheat
var url
-->

### SSL scan

#sh #nikto #web

Run Nikto with SSL enabled.

```sh title:"Run Nikto SSL scan"
nikto -h "$host" -ssl
```
<!-- cheat
var host
-->

### Custom port

#sh #nikto #web

Run Nikto against a custom port.

```sh title:"Run Nikto on custom port"
nikto -h "$host" -p "$port"
```
<!-- cheat
var host
var port
-->
