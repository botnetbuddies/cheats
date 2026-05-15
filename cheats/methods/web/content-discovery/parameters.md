---
technique: Web Parameter Discovery
category: content-discovery
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web parameters ffuf arjun
---

# Web Parameter Discovery

Parameter discovery identifies hidden GET, POST, header, and JSON inputs for injection and access control testing.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| URL | Requires a target endpoint |
| Baseline | Know normal response size and status |
| Wordlist | Use framework and application-specific parameter names |

## Linux

### Arjun GET parameters

#sh #arjun #web

Discover GET parameters.

```sh title:"Discover GET parameters"
arjun -u "$url"
```
<!-- cheat
var url
-->

### ffuf GET parameter

#sh #ffuf #web

Fuzz a GET parameter and filter by response size.

```sh title:"Fuzz GET parameter"
ffuf -w "$wordlist" -u "$url?$param=FUZZ" -fs "$response_size" -o "$outfile"
```
<!-- cheat
var wordlist
var url
var param
var response_size
var outfile
-->

### ffuf parameter names

#sh #ffuf #web

Fuzz parameter names with a fixed value.

```sh title:"Fuzz GET parameter names"
ffuf -w "$wordlist" -u "$url?FUZZ=$value" -ac -o "$outfile"
```
<!-- cheat
var wordlist
var url
var value
var outfile
-->
