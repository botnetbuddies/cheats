---
technique: JWT Testing
category: auth-session
targets: Web Applications, APIs
protocols: HTTP, JWT
remote_capable: true
tags: web jwt auth session
---

# JWT Testing

JWT testing checks token structure, weak signing keys, algorithm confusion, claim trust, and authorization impact.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Token | Requires an in-scope JWT |
| Endpoint | Impact testing needs an endpoint that consumes the token |
| Wordlist | Key brute force requires a candidate key list |

## Linux

### Decode token

#sh #jwt

Decode a JWT without verification.

```sh title:"Decode JWT"
jwt_tool "$jwt_token"
```
<!-- cheat
var jwt_token
-->

### Run jwt_tool tests

#sh #jwttool #web

Run jwt_tool tests against a target URL.

```sh title:"Run jwt_tool tests"
python3 jwt_tool.py -M at -t "$url" -rh "Authorization: Bearer $jwt_token" -rh "$header" -rc "$cookies"
```
<!-- cheat
var url
var jwt_token
var header
var cookies
-->

### Brute force key

#sh #jwttool #web

Brute force a JWT signing key with a wordlist.

```sh title:"Brute force JWT signing key"
python3 jwt_tool.py -d "$wordlist" "$jwt_token"
```
<!-- cheat
var wordlist
var jwt_token
-->

### Replay token

#sh #curl #jwt

Send a request with a bearer token.

```sh title:"Replay JWT bearer token"
curl -sk -H "Authorization: Bearer $jwt_token" "$url"
```
<!-- cheat
var jwt_token
var url
-->
