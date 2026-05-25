# GPG

## keys

### Version

Show version with GPG.

Print the installed GPG version and supported algorithms.

```sh title:"GPG Show Version"
gpg --version
```
<!-- cheat -->

### Generate key

Generate key with GPG.

Start the interactive key generation wizard.

```sh title:"GPG Generate Key"
gpg --gen-key
```
<!-- cheat -->

### List keys

List keys with GPG.

List public keys in the local keyring.

```sh title:"GPG List Keys"
gpg --list-keys
```
<!-- cheat -->

### Send public key

Start send public key with GPG.

Upload a public key to a keyserver.

```sh title:"GPG Start Send Public Key"
gpg --keyserver "$key_server" --send-keys "$public_key"
```
<!-- cheat
var key_server
var public_key
-->

### Export public key

Run export public key with GPG.

Export a public key to a file.

```sh title:"GPG Run Export Public Key"
gpg --output "$output_file" --export "$key_name"
```
<!-- cheat
var output_file
var key_name
-->

### Import public key

Run import public key with GPG.

Import a public key file into the local keyring.

```sh title:"GPG Run Import Public Key"
gpg --import "$input_file"
```
<!-- cheat
var input_file
-->

## files

### Encrypt file

Run encrypt file with GPG.

Encrypt a file for a recipient key.

```sh title:"GPG Run Encrypt File"
gpg --output "$output_file" --encrypt --recipient "$public_key" "$input_file"
```
<!-- cheat
var output_file
var public_key
var input_file
-->

### Decrypt file

Run decrypt file with GPG.

Decrypt a GPG-encrypted file to an output path.

```sh title:"GPG Run Decrypt File"
gpg --output "$output_file" --decrypt "$input_file"
```
<!-- cheat
var output_file
var input_file
-->

## signatures

### Sign file

Create sign file with GPG.

Create a signed GPG message containing the file data.

```sh title:"GPG Create Sign File"
gpg --output "$signature_file" --sign "$input_file"
```
<!-- cheat
var signature_file
var input_file
-->

### Verify signed file

Run verify signed file with GPG.

Verify and decrypt a signed GPG message.

```sh title:"GPG Run Verify Signed File"
gpg --output "$output_file" --decrypt "$signature_file"
```
<!-- cheat
var output_file
var signature_file
-->

### Clearsign file

Create clearsign file with GPG.

Create a cleartext signed file.

```sh title:"GPG Create Clearsign File"
gpg --clearsign "$input_file"
```
<!-- cheat
var input_file
-->

### Detached signature

Create detached signature with GPG.

Create a detached signature for a file.

```sh title:"GPG Create Detached Signature"
gpg --output "$signature_file" --detach-sig "$input_file"
```
<!-- cheat
var signature_file
var input_file
-->

### Verify detached signature

Run verify detached signature with GPG.

Verify a detached signature against its original file.

```sh title:"GPG Run Verify Detached Signature"
gpg --verify "$signature_file" "$input_file"
```
<!-- cheat
var signature_file
var input_file
-->
