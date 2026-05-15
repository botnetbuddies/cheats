---
technique: Cookie and Session Testing
category: auth-session
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web cookies session auth
---

# Cookie and Session Testing

Cookie and session testing checks flags, replay behavior, scope, privilege binding, and server-side invalidation.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Session | Requires an in-scope authenticated session |
| Baseline | Capture unauthenticated and authenticated responses |
| Role set | Authorization testing needs multiple users or roles |

## Linux

### Cookie replay

#sh #curl #cookies

Replay a request with a Cookie header.

```sh title:"Replay request with Cookie header"
curl -sk -H "Cookie: $cookie" "$url"
```
<!-- cheat
var cookie
var url
-->

### Store cookies

#sh #curl #cookies

Save cookies from a response.

```sh title:"Save response cookies"
curl -sk -c "$cookie_jar" "$url"
```
<!-- cheat
var cookie_jar
var url
-->

### Use cookie jar

#sh #curl #cookies

Send a request with a saved cookie jar.

```sh title:"Use saved cookie jar"
curl -sk -b "$cookie_jar" "$url"
```
<!-- cheat
var cookie_jar
var url
-->

### Header review

#sh #curl #cookies

Review Set-Cookie headers.

```sh title:"Review Set-Cookie headers"
curl -skI "$url"
```
<!-- cheat
var url
-->
