---
technique: Node Inspector Abuse
category: privilege-escalation
targets: Node.js, Electron, CEF
protocols: HTTP, WebSocket
remote_capable: true
tags: linux privilege-escalation node electron cef inspector devtools
---

# Node Inspector Abuse

Node inspector abuse targets exposed debug ports that provide execution inside the Node.js process context.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Inspector access | The debug port must be reachable locally or remotely |
| Node target | The process must expose a Node inspector, not only browser DevTools |
| Process privilege | Code runs as the inspected process user |

## Linux

### Find inspector processes

#sh #node #recon

Search process arguments for Node inspector flags.

```sh title:"Search for Node inspector processes"
pgrep -af -- '--inspect'
```
<!-- cheat -->

### Probe inspector endpoint

#sh #node #http

List inspector targets exposed by a debug port.

```sh title:"List Node inspector targets"
curl -s "http://$rhost:$rport/json/list"
```
<!-- cheat
var rhost
var rport
-->

### Connect with node inspect

#sh #node #debug

Connect to a Node inspector endpoint.

```sh title:"Connect to Node inspector"
node inspect "$rhost:$rport"
```
<!-- cheat
var rhost
var rport
-->

### Enable inspector with signal

#sh #node #debug

Signal a Node process to start the default inspector when permitted.

```sh title:"Enable Node inspector with signal"
kill -s SIGUSR1 "$pid"
```
<!-- cheat
var pid
-->

### Chrome DevTools version

#sh #devtools #http

Query a Chrome DevTools Protocol endpoint.

```sh title:"Query DevTools version endpoint"
curl -s "http://$rhost:$rport/json/version"
```
<!-- cheat
var rhost
var rport
-->

## Detection

Monitor Node processes started with inspector flags, SIGUSR1 sent to Node services, and access to debug ports such as 9229 and 9222.
