# OpenSSL

## csr

### New CSR and key

Create CSR and key with OpenSSL.

Create a new private key and certificate signing request.

```sh title:"OpenSSL Create CSR and Key"
openssl req -new -newkey "rsa:$rsa_bits" -nodes -out "$csr_file" -keyout "$key_file"
```
<!-- cheat
var rsa_bits := 2048
var csr_file
var key_file
-->

### CSR from key

Create CSR from key with OpenSSL.

Create a CSR from an existing private key.

```sh title:"OpenSSL Create CSR from Key"
openssl req -out "$csr_file" -key "$key_file" -new
```
<!-- cheat
var csr_file
var key_file
-->

### CSR from certificate

Read CSR from certificate with OpenSSL.

Create a CSR from an existing certificate and private key.

```sh title:"OpenSSL Read CSR from Certificate"
openssl x509 -x509toreq -out "$csr_file" -in "$cert_file" -signkey "$key_file"
```
<!-- cheat
var csr_file
var cert_file
var key_file
-->

## certificates

### Self-signed certificate

Read self signed certificate with OpenSSL.

Create a self-signed certificate and key.

```sh title:"OpenSSL Read Self Signed Certificate"
openssl req -x509 -sha256 -nodes -days "$days" -newkey "rsa:$rsa_bits" -out "$cert_file" -keyout "$key_file"
```
<!-- cheat
var days := 365
var rsa_bits := 2048
var cert_file
var key_file
-->

### Show certificate

Show certificate with OpenSSL.

Print certificate details.

```sh title:"OpenSSL Show Certificate"
openssl x509 -in "$cert_file" -text -noout
```
<!-- cheat
var cert_file
-->

### Server certificate chain

Read server certificate chain with OpenSSL.

Display the remote server certificate chain.

```sh title:"OpenSSL Read Server Certificate Chain"
openssl s_client -connect "$rhost_name:$rport" -showcerts
```
<!-- cheat
var rhost_name
var rport := 443
-->

## keys

### Remove passphrase

Remove passphrase with OpenSSL.

Remove a passphrase from a private key.

```sh title:"OpenSSL Remove Passphrase"
openssl rsa -in "$key_file" -out "$plaintext_key_file"
```
<!-- cheat
var key_file
var plaintext_key_file
-->

### Check key

Check key with OpenSSL.

Validate a private key.

```sh title:"OpenSSL Check Key"
openssl rsa -in "$key_file" -check
```
<!-- cheat
var key_file
-->

## convert

### DER to PEM

Read DER to PEM with OpenSSL.

Convert a DER certificate to PEM.

```sh title:"OpenSSL Read DER to PEM"
openssl x509 -inform der -in "$cert_file" -out "$pem_file"
```
<!-- cheat
var cert_file
var pem_file
-->

### PEM to DER

Read PEM to DER with OpenSSL.

Convert a PEM certificate to DER.

```sh title:"OpenSSL Read PEM to DER"
openssl x509 -outform der -in "$pem_file" -out "$cert_file"
```
<!-- cheat
var pem_file
var cert_file
-->

### PKCS12 to PEM

Convert PKCS12 to PEM with OpenSSL.

Convert a PKCS12 file to PEM.

```sh title:"OpenSSL Convert PKCS12 to PEM"
openssl pkcs12 -in "$pkcs12_file" -out "$pem_file" -nodes
```
<!-- cheat
var pkcs12_file
var pem_file
-->

### Extract PKCS12 key

Extract PKCS12 key with OpenSSL.

Extract a private key from a PKCS12 file.

```sh title:"OpenSSL Extract PKCS12 Key"
openssl pkcs12 -in "$pkcs12_file" -out "$pem_file" -nodes -nocerts
```
<!-- cheat
var pkcs12_file
var pem_file
-->

### Extract PKCS12 cert

Extract PKCS12 cert with OpenSSL.

Extract certificates from a PKCS12 file.

```sh title:"OpenSSL Extract PKCS12 Cert"
openssl pkcs12 -in "$pkcs12_file" -out "$pem_file" -nodes -nokeys
```
<!-- cheat
var pkcs12_file
var pem_file
-->

### PEM to PKCS12

Read PEM to PKCS12 with OpenSSL.

Export a certificate and private key to PKCS12.

```sh title:"OpenSSL Read PEM to PKCS12"
openssl pkcs12 -export -out "$pkcs12_file" -inkey "$key_file" -in "$cert_file" -certfile "$cert_file"
```
<!-- cheat
var pkcs12_file
var key_file
var cert_file
-->

## validate

### Check CSR

Check CSR with OpenSSL.

Validate and print a CSR.

```sh title:"OpenSSL Check CSR"
openssl req -text -noout -verify -in "$csr_file"
```
<!-- cheat
var csr_file
-->

### Check PKCS12

Check PKCS12 with OpenSSL.

Validate and inspect a PKCS12 file.

```sh title:"OpenSSL Check PKCS12"
openssl pkcs12 -info -in "$pkcs12_file"
```
<!-- cheat
var pkcs12_file
-->

### Certificate modulus

Read certificate modulus with OpenSSL.

Print the certificate modulus hash for key/cert matching.

```sh title:"OpenSSL Read Certificate Modulus"
openssl x509 -noout -modulus -in "$cert_file" | openssl md5
```
<!-- cheat
var cert_file
-->

### Key modulus

Dump key modulus with OpenSSL.

Print the private key modulus hash for key/cert matching.

```sh title:"OpenSSL Dump Key Modulus"
openssl rsa -noout -modulus -in "$key_file" | openssl md5
```
<!-- cheat
var key_file
-->

### CSR modulus

Dump CSR modulus with OpenSSL.

Print the CSR modulus hash for key/cert matching.

```sh title:"OpenSSL Dump CSR Modulus"
openssl req -noout -modulus -in "$csr_file" | openssl md5
```
<!-- cheat
var csr_file
-->
