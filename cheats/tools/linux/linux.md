# Linux

## process

### Background process

Execute background process with Linux.

```sh title:"Linux Execute Background Process"
$process &
```
<!-- cheat
var process
-->

### Kill by name

Run kill by name with Linux.

```sh title:"Linux Run Kill by Name"
killall "$process_name"
```
<!-- cheat
var process_name
-->

## crypto

### OpenSSL encrypt file

Run OpenSSL encrypt file with Linux.

```sh title:"Linux Run OpenSSL Encrypt File"
openssl enc -aes-256-cbc -e -in "$input_file" -out "$output_file"
```
<!-- cheat
var input_file
var output_file
-->

### OpenSSL decrypt file

Run OpenSSL decrypt file with Linux.

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

```sh title:"Linux Run Lines to One Line"
grep "$pattern" "$file" | tr '\n' ' '
```
<!-- cheat
var pattern
var file
-->

### Grepable nmap IPs

Extract grepable nmap IPs with Linux.

```sh title:"Linux Extract Grepable Nmap IPs"
grep "$pattern" "$gnmap_file" | cut -d ' ' -f 2 | tr '\n' ' '
```
<!-- cheat
var pattern
var gnmap_file
-->

### JSON to YAML

Convert JSON to YAML with Linux.

```sh title:"Linux Convert JSON to YAML"
ruby -ryaml -rjson -e 'puts YAML.dump(JSON.load(ARGF))' "$json_file"
```
<!-- cheat
var json_file
-->

## recon

### Identify service on port

Enumerate identify service on port with Linux.

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

```sh title:"Linux Create QR Code"
printf '%s\n' "$content" | curl -F-=\<- qrenco.de
```
<!-- cheat
var content
-->
