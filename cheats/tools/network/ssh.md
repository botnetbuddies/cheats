# Ssh

## ssh - Port forwarding

### Local forward

Run local forward with Ssh.

```sh title:"Ssh Run Local Forward"
ssh -L $lport:$domain:$rport $user@$domain
```
<!-- cheat
import domain_ip
import users
var lport
var rport
-->

### Reverse forward

Start reverse forward with Ssh.

```sh title:"Ssh Start Reverse Forward"
ssh -R $rport:localhost:$lport $user@$domain
```
<!-- cheat
import domain_ip
import users
var rport
var lport
-->

### Dynamic SOCKS proxy

Start dynamic SOCKS proxy with Ssh.

```sh title:"Ssh Start Dynamic SOCKS Proxy"
ssh -D "$socks_port" "$user@$rhost_ip"
```
<!-- cheat
var socks_port
var user
var rhost_ip
-->

### Local forward explicit host

Run local forward explicit host with Ssh.

```sh title:"Ssh Run Local Forward Explicit Host"
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

Start remote forward explicit bind with Ssh.

```sh title:"Ssh Start Remote Forward Explicit Bind"
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

Start agent with Ssh.

```sh title:"Ssh Start Agent"
eval "$(ssh-agent -s)"; ssh-add
```
<!-- cheat -->

### Keyscan

Scan keyscan with Ssh.

```sh title:"Ssh Scan Keyscan"
ssh-keyscan -t rsa -p "$rport" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 22
-->

## ssh - Legacy

### Old key exchange

Set old key exchange with Ssh.

```sh title:"Ssh Set Old Key Exchange"
ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 "$user@$rhost_ip"
```
<!-- cheat
var user
var rhost_ip
-->

## ssh - Metasploit

### Enum users

Enumerate enum users with Ssh.

```sh title:"Ssh Enumerate Enum Users"
msfconsole -x "use scanner/ssh/ssh_enumusers; set RHOSTS $rhost_ip; set USER_FILE $wordlists_users; set CHECK_FALSE true; run; exit"
```
<!-- cheat
import wordlists_users
var rhost_ip
-->
