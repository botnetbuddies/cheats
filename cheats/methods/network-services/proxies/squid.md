---
technique: Squid Proxy Enumeration
category: proxies
targets: Squid Proxy
protocols: HTTP Proxy
remote_capable: true
tags: network-services proxy squid http
---

# Squid Proxy Enumeration

Squid proxy enumeration checks open proxy behavior, internal reachability, and proxy authentication requirements.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 3128 | Common Squid proxy port |
| Target URL | Proxy testing needs an allowed destination URL |
| Scope | Internal proxying can cross network boundaries |

## Linux

### Service detection

#sh #nmap #proxy

Run HTTP proxy checks.

```sh title:"Run HTTP proxy checks"
nmap -sV -p "$rport" --script http-open-proxy "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 3128
-->

### Proxy request

#sh #curl #proxy

Send a request through the proxy.

```sh title:"Send request through HTTP proxy"
curl -sk --proxy "http://$rhost_ip:$rport" "$target_url"
```
<!-- cheat
var rhost_ip
var rport := 3128
var target_url
-->

### Authenticated proxy request

#sh #curl #proxy

Send a request through the proxy with credentials.

```sh title:"Send authenticated request through HTTP proxy"
curl -sk --proxy "http://$rhost_ip:$rport" --proxy-user "$user:$pass" "$target_url"
```
<!-- cheat
var rhost_ip
var rport := 3128
var user
var pass
var target_url
-->
