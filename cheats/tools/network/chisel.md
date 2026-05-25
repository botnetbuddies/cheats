# Chisel

## server

### Reverse server

Start reverse server with Chisel.

Start a reverse-capable Chisel server on your machine.

```sh title:"Chisel Start Reverse Server"
./chisel server -v -p "$server_port" --reverse
```
<!-- cheat
var server_port := 8000
-->

## client

### Reverse port forward

Start reverse port forward with Chisel.

Expose a port from the client side on the server side.

```sh title:"Chisel Start Reverse Port Forward"
./chisel client -v "$server_ip:$server_port" "R:$server_side_port:$client_side_host:$client_side_port"
```
<!-- cheat
var server_ip
var server_port := 8000
var server_side_port
var client_side_host := localhost
var client_side_port
-->

### Forward server listener to client

List forward server listener to client with Chisel.

Expose a server-side listener to the client side.

```sh title:"Chisel List Forward Server Listener to Client"
./chisel client -v "$server_ip:$server_port" "$client_side_host:$client_side_port:$server_side_host:$server_side_port"
```
<!-- cheat
var server_ip
var server_port := 8000
var client_side_host := 0.0.0.0
var client_side_port
var server_side_host := 127.0.0.1
var server_side_port
-->

### Reverse SOCKS

Start reverse SOCKS with Chisel.

Create a reverse SOCKS proxy on the Chisel server.

```sh title:"Chisel Start Reverse SOCKS"
./chisel client "$server_ip:$server_port" R:socks
```
<!-- cheat
var server_ip
var server_port := 8000
-->
