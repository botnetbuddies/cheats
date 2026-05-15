# OpenSSL

## csr

### New CSR and key

Create a new private key and certificate signing request.

```sh title:"Create new private key and CSR"
openssl req -new -newkey "rsa:$rsa_bits" -nodes -out "$csr_file" -keyout "$key_file"
```
<!-- cheat
var rsa_bits := 2048
var csr_file
var key_file
-->

### CSR from key

Create a CSR from an existing private key.

```sh title:"Create CSR from existing private key"
openssl req -out "$csr_file" -key "$key_file" -new
```
<!-- cheat
var csr_file
var key_file
-->

### CSR from certificate

Create a CSR from an existing certificate and private key.

```sh title:"Create CSR from certificate and key"
openssl x509 -x509toreq -out "$csr_file" -in "$cert_file" -signkey "$key_file"
```
<!-- cheat
var csr_file
var cert_file
var key_file
-->

## certificates

### Self-signed certificate

Create a self-signed certificate and key.

```sh title:"Create self-signed certificate and key"
openssl req -x509 -sha256 -nodes -days "$days" -newkey "rsa:$rsa_bits" -out "$cert_file" -keyout "$key_file"
```
<!-- cheat
var days := 365
var rsa_bits := 2048
var cert_file
var key_file
-->

### Show certificate

Print certificate details.

```sh title:"Show certificate details"
openssl x509 -in "$cert_file" -text -noout
```
<!-- cheat
var cert_file
-->

### Server certificate chain

Display the remote server certificate chain.

```sh title:"Display server certificate chain"
openssl s_client -connect "$rhost_name:$rport" -showcerts
```
<!-- cheat
var rhost_name
var rport := 443
-->

## keys

### Remove passphrase

Remove a passphrase from a private key.

```sh title:"Remove passphrase from private key"
openssl rsa -in "$key_file" -out "$plaintext_key_file"
```
<!-- cheat
var key_file
var plaintext_key_file
-->

### Check key

Validate a private key.

```sh title:"Validate private key"
openssl rsa -in "$key_file" -check
```
<!-- cheat
var key_file
-->

## convert

### DER to PEM

Convert a DER certificate to PEM.

```sh title:"Convert DER certificate to PEM"
openssl x509 -inform der -in "$cert_file" -out "$pem_file"
```
<!-- cheat
var cert_file
var pem_file
-->

### PEM to DER

Convert a PEM certificate to DER.

```sh title:"Convert PEM certificate to DER"
openssl x509 -outform der -in "$pem_file" -out "$cert_file"
```
<!-- cheat
var pem_file
var cert_file
-->

### PKCS12 to PEM

Convert a PKCS12 file to PEM.

```sh title:"Convert PKCS12 to PEM"
openssl pkcs12 -in "$pkcs12_file" -out "$pem_file" -nodes
```
<!-- cheat
var pkcs12_file
var pem_file
-->

### Extract PKCS12 key

Extract a private key from a PKCS12 file.

```sh title:"Extract private key from PKCS12"
openssl pkcs12 -in "$pkcs12_file" -out "$pem_file" -nodes -nocerts
```
<!-- cheat
var pkcs12_file
var pem_file
-->

### Extract PKCS12 cert

Extract certificates from a PKCS12 file.

```sh title:"Extract certificates from PKCS12"
openssl pkcs12 -in "$pkcs12_file" -out "$pem_file" -nodes -nokeys
```
<!-- cheat
var pkcs12_file
var pem_file
-->

### PEM to PKCS12

Export a certificate and private key to PKCS12.

```sh title:"Export certificate and key to PKCS12"
openssl pkcs12 -export -out "$pkcs12_file" -inkey "$key_file" -in "$cert_file" -certfile "$cert_file"
```
<!-- cheat
var pkcs12_file
var key_file
var cert_file
-->

## validate

### Check CSR

Validate and print a CSR.

```sh title:"Validate CSR"
openssl req -text -noout -verify -in "$csr_file"
```
<!-- cheat
var csr_file
-->

### Check PKCS12

Validate and inspect a PKCS12 file.

```sh title:"Validate PKCS12 file"
openssl pkcs12 -info -in "$pkcs12_file"
```
<!-- cheat
var pkcs12_file
-->

### Certificate modulus

Print the certificate modulus hash for key/cert matching.

```sh title:"Print certificate modulus hash"
openssl x509 -noout -modulus -in "$cert_file" | openssl md5
```
<!-- cheat
var cert_file
-->

### Key modulus

Print the private key modulus hash for key/cert matching.

```sh title:"Print private key modulus hash"
openssl rsa -noout -modulus -in "$key_file" | openssl md5
```
<!-- cheat
var key_file
-->

### CSR modulus

Print the CSR modulus hash for key/cert matching.

```sh title:"Print CSR modulus hash"
openssl req -noout -modulus -in "$csr_file" | openssl md5
```
<!-- cheat
var csr_file
-->
