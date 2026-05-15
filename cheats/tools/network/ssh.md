# Ssh

## ssh - Port forwarding

### Local forward

SSH local port forward: bind a local port on your box that tunnels through the SSH host to the named target/port.

```sh title:"Local forward, tunnel local port through SSH host"
ssh -L $lport:$domain:$rport $user@$domain
```
<!-- cheat
import domain_ip
import users
var lport
var rport
-->

### Reverse forward

SSH reverse forward: open a port on the SSH host that tunnels back to a local port. Used to expose your listener to the target's network.

```sh title:"Reverse forward, expose local port on SSH host"
ssh -R $rport:localhost:$lport $user@$domain
```
<!-- cheat
import domain_ip
import users
var rport
var lport
-->

### Dynamic SOCKS proxy

Start a dynamic SOCKS proxy through SSH.

```sh title:"Start dynamic SOCKS proxy through SSH"
ssh -D "$socks_port" "$user@$rhost_ip"
```
<!-- cheat
var socks_port
var user
var rhost_ip
-->

### Local forward explicit host

Bind a local port that forwards through SSH to a chosen remote host and port.

```sh title:"Local forward to explicit remote host"
ssh -L "$lport:$remote_host:$rport" "$user@$rhost_ip"
```
<!-- cheat
var lport
var remote_host
var rport
var user
var rhost_ip
-->

### Remote forward explicit bind

Open a remote bind address and port that forwards back to a local host and port. Requires `GatewayPorts yes` for non-loopback remote binds.

```sh title:"Remote forward with explicit bind address"
ssh -R "$remote_bind:$rport:$local_host:$lport" "$user@$rhost_ip"
```
<!-- cheat
var remote_bind
var rport
var local_host
var lport
var user
var rhost_ip
-->

## ssh - Keys

### Start agent

Start ssh-agent and add your default key.

```sh title:"Start ssh-agent and add default key"
eval "$(ssh-agent -s)"; ssh-add
```
<!-- cheat -->

### Keyscan

Fetch a server public SSH host key.

```sh title:"Fetch SSH host public key"
ssh-keyscan -t rsa -p "$rport" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 22
-->

## ssh - Legacy

### Old key exchange

Connect to a legacy SSH server that only supports group1 SHA1 key exchange.

```sh title:"Connect with legacy DH group1 SHA1 KEX"
ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 "$user@$rhost_ip"
```
<!-- cheat
var user
var rhost_ip
-->

## ssh - Metasploit

### Enum users

Enumerate SSH usernames with Metasploit.

```sh title:"Enumerate SSH usernames with Metasploit"
msfconsole -x "use scanner/ssh/ssh_enumusers; set RHOSTS $rhost_ip; set USER_FILE $wordlists_users; set CHECK_FALSE true; run; exit"
```
<!-- cheat
import wordlists_users
var rhost_ip
-->
