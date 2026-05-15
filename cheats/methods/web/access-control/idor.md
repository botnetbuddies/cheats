---
technique: IDOR and BOLA Testing
category: access-control
targets: Web Applications, APIs
protocols: HTTP, HTTPS
remote_capable: true
tags: web idor bola access-control api
---

# IDOR and BOLA Testing

IDOR and BOLA testing checks whether object identifiers are authorized server-side for the current user or role.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Two users | Strong testing needs at least two roles or accounts |
| Object IDs | Collect authorized and unauthorized object identifiers |
| Baselines | Compare status, size, and response fields |

## Linux

### Authorized object request

#sh #curl #idor

Request an object with the current user's session.

```sh title:"Request object with current session"
curl -sk -H "Cookie: $cookie" "$url/$object_id"
```
<!-- cheat
var cookie
var url
var object_id
-->

### Alternate object request

#sh #curl #idor

Request another user's object with the current session.

```sh title:"Request alternate object with current session"
curl -sk -H "Cookie: $cookie" "$url/$other_object_id"
```
<!-- cheat
var cookie
var url
var other_object_id
-->

### ID fuzz

#sh #ffuf #idor

Fuzz object IDs with a fixed session.

```sh title:"Fuzz object IDs with session"
ffuf -w "$wordlist" -u "$url/FUZZ" -H "Cookie: $cookie" -ac -o "$outfile"
```
<!-- cheat
var wordlist
var url
var cookie
var outfile
-->
