---
technique: Server-Side Template Injection Testing
category: injection
targets: Web Applications
protocols: HTTP
remote_capable: true
tags: web ssti template-injection injection
---

# Server-Side Template Injection Testing

SSTI testing checks whether template expressions are evaluated server-side in user-controlled input.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Input | Requires a suspected reflected or stored template input |
| Probe | Use arithmetic or inert probes before impact checks |
| Engine | Payload syntax depends on template engine |

## Linux

### GET probe

#sh #curl #ssti

Send a template probe through a GET parameter.

```sh title:"Send SSTI GET probe"
curl -sk "$url?$param=$probe"
```
<!-- cheat
var url
var param
var probe
-->

### POST probe

#sh #curl #ssti

Send a template probe through POST data.

```sh title:"Send SSTI POST probe"
curl -sk -X POST --data "$params" "$url"
```
<!-- cheat
var params
var url
-->

### Fuzz probes

#sh #ffuf #ssti

Fuzz template probes into a parameter.

```sh title:"Fuzz SSTI probes"
ffuf -w "$wordlist" -u "$url?$param=FUZZ" -ac -o "$outfile"
```
<!-- cheat
var wordlist
var url
var param
var outfile
-->
