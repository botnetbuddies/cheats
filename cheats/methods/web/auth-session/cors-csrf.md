---
technique: CORS and CSRF Testing
category: auth-session
targets: Web Applications, APIs
protocols: HTTP, HTTPS
remote_capable: true
tags: web cors csrf auth session
---

# CORS and CSRF Testing

CORS and CSRF testing checks whether browsers can send authenticated cross-origin requests or read protected responses from attacker-controlled origins.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Authenticated session | Browser-impact testing needs a valid session |
| Origin | Use an authorized controlled origin |
| State change | CSRF impact requires a state-changing endpoint |

## Linux

### CORS origin probe

#sh #curl #cors

Send an Origin header and review CORS response headers.

```sh title:"Send CORS origin probe"
curl -skI -H "Origin: $origin" "$url"
```
<!-- cheat
var origin
var url
-->

### CORS credential probe

#sh #curl #cors

Send Origin and Cookie headers together.

```sh title:"Send CORS credential probe"
curl -skI -H "Origin: $origin" -H "Cookie: $cookie" "$url"
```
<!-- cheat
var origin
var cookie
var url
-->

### CSRF replay

#sh #curl #csrf

Replay a state-changing request without a CSRF token.

```sh title:"Replay request without CSRF token"
curl -sk -X POST -H "Cookie: $cookie" --data "$params" "$url"
```
<!-- cheat
var cookie
var params
var url
-->
