---
technique: WordPress Enumeration
category: cms
targets: WordPress
protocols: HTTP, HTTPS
remote_capable: true
tags: web wordpress cms wpscan
---

# WordPress Enumeration

WordPress enumeration checks core version, users, plugins, themes, XML-RPC exposure, and known vulnerable components.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| URL | Requires a target WordPress URL |
| API token | WPScan vulnerability data is richer with a token |
| Scope | Password testing requires explicit authorization |

## Linux

### WPScan enum

#sh #wpscan #wordpress

Run default WordPress enumeration.

```sh title:"Run WPScan enumeration"
wpscan --url "$url" --enumerate
```
<!-- cheat
var url
-->

### Plugin enum

#sh #wpscan #wordpress

Enumerate WordPress plugins.

```sh title:"Enumerate WordPress plugins"
wpscan --url "$url" --enumerate p
```
<!-- cheat
var url
-->

### User enum

#sh #wpscan #wordpress

Enumerate WordPress users.

```sh title:"Enumerate WordPress users"
wpscan --url "$url" --enumerate u
```
<!-- cheat
var url
-->

### XML-RPC probe

#sh #curl #wordpress

Check XML-RPC endpoint reachability.

```sh title:"Check WordPress XML-RPC endpoint"
curl -sk "$url/xmlrpc.php"
```
<!-- cheat
var url
-->
