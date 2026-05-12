# Linux

## process

### Background process

Run a command in the background.

```sh title:"Run command in background"
$process &
```
<!-- cheat
var process
-->

### Kill by name

Kill processes by name.

```sh title:"Kill processes by name"
killall "$process_name"
```
<!-- cheat
var process_name
-->

## crypto

### OpenSSL encrypt file

Encrypt a file with AES-256-CBC.

```sh title:"Encrypt file with OpenSSL AES-256-CBC"
openssl enc -aes-256-cbc -e -in "$input_file" -out "$output_file"
```
<!-- cheat
var input_file
var output_file
-->

### OpenSSL decrypt file

Decrypt an AES-256-CBC file.

```sh title:"Decrypt file with OpenSSL AES-256-CBC"
openssl enc -aes-256-cbc -d -in "$input_file" -out "$output_file"
```
<!-- cheat
var input_file
var output_file
-->

## transfer

### SCP download file

Copy a file from a remote server to the local host.

```sh title:"SCP file from remote server"
scp "$user@$rhost_ip:$remote_path" "$local_path"
```
<!-- cheat
var user
var rhost_ip
var remote_path
var local_path
-->

### SCP upload file

Copy a local file to a remote server.

```sh title:"SCP file to remote server"
scp "$local_path" "$user@$rhost_ip:$remote_path"
```
<!-- cheat
var local_path
var user
var rhost_ip
var remote_path
-->

### SCP download directory

Recursively copy a remote directory to the local host.

```sh title:"SCP directory from remote server"
scp -r "$user@$rhost_ip:$remote_path" "$local_path"
```
<!-- cheat
var user
var rhost_ip
var remote_path
var local_path
-->

## text

### Lines to one line

Search a file and join matching lines with spaces.

```sh title:"Join matching lines into one line"
grep "$pattern" "$file" | tr '\n' ' '
```
<!-- cheat
var pattern
var file
-->

### Grepable nmap IPs

Extract IPs matching a pattern from a grepable nmap file.

```sh title:"Extract matching IPs from grepable nmap output"
grep "$pattern" "$gnmap_file" | cut -d ' ' -f 2 | tr '\n' ' '
```
<!-- cheat
var pattern
var gnmap_file
-->

### JSON to YAML

Convert JSON to YAML with Ruby.

```sh title:"Convert JSON to YAML with Ruby"
ruby -ryaml -rjson -e 'puts YAML.dump(JSON.load(ARGF))' "$json_file"
```
<!-- cheat
var json_file
-->

## recon

### Identify service on port

Use amap to identify a service listening on a port.

```sh title:"Identify service on host and port"
amap -d "$rhost_ip" "$rport"
```
<!-- cheat
var rhost_ip
var rport
-->

## qr

### QR code

Create a terminal QR code from text using qrenco.de.

```sh title:"Create terminal QR code from text"
printf '%s\n' "$content" | curl -F-=\<- qrenco.de
```
<!-- cheat
var content
-->
