---
technique: Cross-Site Scripting Testing
category: injection
targets: Web Applications
protocols: HTTP, JavaScript
remote_capable: true
tags: web xss injection dalfox
---

# Cross-Site Scripting Testing

XSS testing checks reflected, stored, and DOM sinks while preserving request context and authorization.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| URL | Requires an endpoint with a controllable input |
| Context | Browser behavior depends on sink and encoding context |
| Safety | Use non-destructive proof strings for production testing |

## Linux

### Dalfox URL scan

#sh #dalfox #xss

Scan a URL with Dalfox.

```sh title:"Scan URL for XSS with Dalfox"
dalfox url "$url"
```
<!-- cheat
var url
-->

### Dalfox request scan

#sh #dalfox #xss

Scan a captured request with Dalfox.

```sh title:"Scan request for XSS with Dalfox"
dalfox file "$request_file"
```
<!-- cheat
var request_file
-->

### Reflected parameter probe

#sh #curl #xss

Send a controlled probe value to a parameter.

```sh title:"Send reflected XSS probe"
curl -sk "$url?$param=$probe"
```
<!-- cheat
var url
var param
var probe
-->
