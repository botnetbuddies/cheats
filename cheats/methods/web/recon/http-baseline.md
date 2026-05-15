---
technique: HTTP Baseline Recon
category: recon
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web http recon headers tls
---

# HTTP Baseline Recon

HTTP baseline recon captures status, headers, TLS details, technologies, and allowed methods before targeted testing.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| URL | Requires an in-scope HTTP or HTTPS URL |
| Network path | Proxies, WAFs, and redirects may alter output |
| Tooling | Commands use curl, whatweb, nmap, and openssl |

## Linux

### Response headers

#sh #curl #http

Fetch response headers.

```sh title:"Fetch HTTP response headers"
curl -skI "$url"
```
<!-- cheat
var url
-->

### Redirect chain

#sh #curl #http

Request a page while following redirects.

```sh title:"Request page with redirects"
curl -skL "$url"
```
<!-- cheat
var url
-->

### Allowed methods

#sh #curl #http

Check allowed HTTP methods.

```sh title:"Check allowed HTTP methods"
curl -sk -X OPTIONS "$url" -i
```
<!-- cheat
var url
-->

### Technology fingerprint

#sh #whatweb #http

Fingerprint web technologies.

```sh title:"Fingerprint web technologies"
whatweb "$url"
```
<!-- cheat
var url
-->

### TLS certificate

#sh #openssl #tls

Read the presented TLS certificate.

```sh title:"Read TLS certificate"
openssl s_client -connect "$host:$port" -servername "$host"
```
<!-- cheat
var host
var port := 443
-->

### HTTP scripts

#sh #nmap #http

Run default HTTP nmap scripts.

```sh title:"Run HTTP nmap scripts"
nmap -sV -p "$port" --script "http-* and default" "$rhost_ip"
```
<!-- cheat
var port := 80
var rhost_ip
-->
