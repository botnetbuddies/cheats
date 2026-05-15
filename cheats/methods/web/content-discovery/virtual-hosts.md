---
technique: Virtual Host Discovery
category: content-discovery
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web vhost host-header ffuf
---

# Virtual Host Discovery

Virtual host discovery finds applications hidden behind the same IP address and listener by rotating the Host header.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| IP target | Send requests to the listener IP |
| Domain | Use a root domain or known suffix for Host header candidates |
| Filtering | Calibrate wildcard and default vhost responses |

## Linux

### ffuf vhost

#sh #ffuf #web

Fuzz virtual hosts with ffuf.

```sh title:"Fuzz virtual hosts with ffuf"
ffuf -w "$wordlist" -u "$url" -H "Host: FUZZ.$domain" -ac -o "$outfile"
```
<!-- cheat
var wordlist
var url
var domain
var outfile
-->

### gobuster vhost

#sh #gobuster #web

Fuzz virtual hosts with gobuster.

```sh title:"Fuzz virtual hosts with gobuster"
gobuster vhost -u "$url" -w "$wordlist" --append-domain
```
<!-- cheat
var url
var wordlist
-->

### Manual Host header

#sh #curl #web

Send a request with a custom Host header.

```sh title:"Send custom Host header"
curl -sk -H "Host: $vhost" "$url"
```
<!-- cheat
var vhost
var url
-->
