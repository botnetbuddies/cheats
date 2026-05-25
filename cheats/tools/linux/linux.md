# Linux

## process

### Background process

Execute background process with Linux.

Run a command in the background.

```sh title:"Linux Execute Background Process"
$process &
```
<!-- cheat
var process
-->

### Kill by name

Run kill by name with Linux.

Kill processes by name.

```sh title:"Linux Run Kill by Name"
killall "$process_name"
```
<!-- cheat
var process_name
-->

## crypto

### OpenSSL encrypt file

Run OpenSSL encrypt file with Linux.

Encrypt a file with AES-256-CBC.

```sh title:"Linux Run OpenSSL Encrypt File"
openssl enc -aes-256-cbc -e -in "$input_file" -out "$output_file"
```
<!-- cheat
var input_file
var output_file
-->

### OpenSSL decrypt file

Run OpenSSL decrypt file with Linux.

Decrypt an AES-256-CBC file.

```sh title:"Linux Run OpenSSL Decrypt File"
openssl enc -aes-256-cbc -d -in "$input_file" -out "$output_file"
```
<!-- cheat
var input_file
var output_file
-->

## transfer

### SCP download file

Download SCP download file with Linux.

Copy a file from a remote server to the local host.

```sh title:"Linux Download SCP Download File"
scp "$user@$rhost_ip:$remote_path" "$local_path"
```
<!-- cheat
var user
var rhost_ip
var remote_path
var local_path
-->

### SCP upload file

Start SCP upload file with Linux.

Copy a local file to a remote server.

```sh title:"Linux Start SCP Upload File"
scp "$local_path" "$user@$rhost_ip:$remote_path"
```
<!-- cheat
var local_path
var user
var rhost_ip
var remote_path
-->

### SCP download directory

Download SCP download directory with Linux.

Recursively copy a remote directory to the local host.

```sh title:"Linux Download SCP Download Directory"
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

Run lines to one line with Linux.

Search a file and join matching lines with spaces.

```sh title:"Linux Run Lines to One Line"
grep "$pattern" "$file" | tr '\n' ' '
```
<!-- cheat
var pattern
var file
-->

### Grepable nmap IPs

Extract grepable nmap IPs with Linux.

Extract IPs matching a pattern from a grepable nmap file.

```sh title:"Linux Extract Grepable Nmap IPs"
grep "$pattern" "$gnmap_file" | cut -d ' ' -f 2 | tr '\n' ' '
```
<!-- cheat
var pattern
var gnmap_file
-->

### JSON to YAML

Convert JSON to YAML with Linux.

Convert JSON to YAML with Ruby.

```sh title:"Linux Convert JSON to YAML"
ruby -ryaml -rjson -e 'puts YAML.dump(JSON.load(ARGF))' "$json_file"
```
<!-- cheat
var json_file
-->

## recon

### Identify service on port

Enumerate identify service on port with Linux.

Use amap to identify a service listening on a port.

```sh title:"Linux Enumerate Identify Service on Port"
amap -d "$rhost_ip" "$rport"
```
<!-- cheat
var rhost_ip
var rport
-->

## qr

### QR code

Create QR code with Linux.

Create a terminal QR code from text using qrenco.de.

```sh title:"Linux Create QR Code"
printf '%s\n' "$content" | curl -F-=\<- qrenco.de
```
<!-- cheat
var content
-->
