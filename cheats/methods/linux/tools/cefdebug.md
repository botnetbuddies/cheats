---
tool: cefdebug
category: linux-tool
tags: linux tool cefdebug electron cef devtools
---

# cefdebug

cefdebug discovers and interacts with CEF, Electron, and Chromium debug endpoints exposed through DevTools.

## Linux

### Discover endpoints

#sh #cefdebug #devtools

Discover local DevTools endpoints.

```sh title:"Discover DevTools endpoints"
./cefdebug
```
<!-- cheat -->

### Evaluate code

#sh #cefdebug #devtools

Evaluate a prepared expression against a DevTools WebSocket URL.

```sh title:"Evaluate DevTools expression"
./cefdebug --url "$websocket_url" --code "$code"
```
<!-- cheat
var websocket_url
var code
-->

### Check process version

#sh #cefdebug #node

Evaluate `process.version` against a Node-capable inspector endpoint.

```sh title:"Check Node process version"
./cefdebug --url "$websocket_url" --code "process.version"
```
<!-- cheat
var websocket_url
-->
