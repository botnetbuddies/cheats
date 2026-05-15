---
technique: Command Injection Testing
category: injection
targets: Web Applications, APIs
protocols: HTTP
remote_capable: true
tags: web command-injection injection
---

# Command Injection Testing

Command injection testing checks whether user input reaches OS command execution sinks.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Input | Requires a suspected command-influencing parameter |
| Probe | Use non-destructive proof values |
| Callback | Blind checks need an authorized callback endpoint |

## Linux

### Direct probe

#sh #curl #command-injection

Send a controlled command-injection probe.

```sh title:"Send command injection probe"
curl -sk "$url?$param=$probe"
```
<!-- cheat
var url
var param
var probe
-->

### POST probe

#sh #curl #command-injection

Send a controlled command-injection probe in POST data.

```sh title:"Send POST command injection probe"
curl -sk -X POST --data "$params" "$url"
```
<!-- cheat
var params
var url
-->

### Request scan

#sh #commix #command-injection

Run commix against a captured request.

```sh title:"Run commix against request"
commix -r "$request_file" --batch
```
<!-- cheat
var request_file
-->
