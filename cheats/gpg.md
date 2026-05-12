# GPG

## keys

### Version

Print the installed GPG version and supported algorithms.

```sh title:"Print GPG version and algorithms"
gpg --version
```
<!-- cheat -->

### Generate key

Start the interactive key generation wizard.

```sh title:"Generate a new GPG key"
gpg --gen-key
```
<!-- cheat -->

### List keys

List public keys in the local keyring.

```sh title:"List public keys"
gpg --list-keys
```
<!-- cheat -->

### Send public key

Upload a public key to a keyserver.

```sh title:"Upload public key to keyserver"
gpg --keyserver "$key_server" --send-keys "$public_key"
```
<!-- cheat
var key_server
var public_key
-->

### Export public key

Export a public key to a file.

```sh title:"Export public key to file"
gpg --output "$output_file" --export "$key_name"
```
<!-- cheat
var output_file
var key_name
-->

### Import public key

Import a public key file into the local keyring.

```sh title:"Import public key file"
gpg --import "$input_file"
```
<!-- cheat
var input_file
-->

## files

### Encrypt file

Encrypt a file for a recipient key.

```sh title:"Encrypt file for recipient key"
gpg --output "$output_file" --encrypt --recipient "$public_key" "$input_file"
```
<!-- cheat
var output_file
var public_key
var input_file
-->

### Decrypt file

Decrypt a GPG-encrypted file to an output path.

```sh title:"Decrypt file to output path"
gpg --output "$output_file" --decrypt "$input_file"
```
<!-- cheat
var output_file
var input_file
-->

## signatures

### Sign file

Create a signed GPG message containing the file data.

```sh title:"Create signed GPG file"
gpg --output "$signature_file" --sign "$input_file"
```
<!-- cheat
var signature_file
var input_file
-->

### Verify signed file

Verify and decrypt a signed GPG message.

```sh title:"Verify signed GPG file"
gpg --output "$output_file" --decrypt "$signature_file"
```
<!-- cheat
var output_file
var signature_file
-->

### Clearsign file

Create a cleartext signed file.

```sh title:"Create cleartext signature"
gpg --clearsign "$input_file"
```
<!-- cheat
var input_file
-->

### Detached signature

Create a detached signature for a file.

```sh title:"Create detached signature"
gpg --output "$signature_file" --detach-sig "$input_file"
```
<!-- cheat
var signature_file
var input_file
-->

### Verify detached signature

Verify a detached signature against its original file.

```sh title:"Verify detached signature"
gpg --verify "$signature_file" "$input_file"
```
<!-- cheat
var signature_file
var input_file
-->
