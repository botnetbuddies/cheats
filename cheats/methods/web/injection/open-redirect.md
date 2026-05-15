---
technique: Open Redirect Testing
category: injection
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web open-redirect injection
---

# Open Redirect Testing

Open redirect testing checks whether redirect parameters accept attacker-controlled destinations.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Redirect parameter | Requires a suspected redirect or return URL input |
| Destination | Use an authorized controlled destination |
| Validation | Follow both status code and Location header behavior |

## Linux

### Redirect probe

#sh #curl #redirect

Send a redirect destination and review headers.

```sh title:"Send open redirect probe"
curl -skI "$url?$param=$redirect_url"
```
<!-- cheat
var url
var param
var redirect_url
-->

### Redirect fuzz

#sh #ffuf #redirect

Fuzz redirect payloads into a parameter.

```sh title:"Fuzz open redirect payloads"
ffuf -w "$wordlist" -u "$url?$param=FUZZ" -ac -o "$outfile"
```
<!-- cheat
var wordlist
var url
var param
var outfile
-->
