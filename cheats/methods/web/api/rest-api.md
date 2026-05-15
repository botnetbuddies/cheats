---
technique: REST API Testing
category: api
targets: REST APIs
protocols: HTTP, JSON
remote_capable: true
tags: web api rest json
---

# REST API Testing

REST API testing checks methods, content types, authorization, object access, and schema or documentation exposure.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Endpoint | Requires an API route |
| Auth | Compare anonymous, low-privilege, and high-privilege tokens |
| Body | Keep JSON request bodies in variables or files |

## Linux

### JSON GET

#sh #curl #api

Send a JSON API GET request.

```sh title:"Send JSON API GET request"
curl -sk -H "Accept: application/json" "$url"
```
<!-- cheat
var url
-->

### JSON POST

#sh #curl #api

Send a JSON API POST request.

```sh title:"Send JSON API POST request"
curl -sk -X POST -H "Content-Type: application/json" --data "$json_body" "$url"
```
<!-- cheat
var json_body
var url
-->

### Bearer request

#sh #curl #api

Send a bearer-authenticated API request.

```sh title:"Send bearer-authenticated API request"
curl -sk -H "Authorization: Bearer $token" "$url"
```
<!-- cheat
var token
var url
-->

### OpenAPI probe

#sh #curl #api

Check a common OpenAPI document path.

```sh title:"Check OpenAPI document"
curl -sk "$url/openapi.json"
```
<!-- cheat
var url
-->
