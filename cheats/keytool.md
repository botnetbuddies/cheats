# Keytool

## keystore

### Generate keypair

Generate a Java keystore and RSA keypair.

```sh title:"Generate Java keystore and RSA keypair"
keytool -genkey -alias "$alias" -keyalg RSA -keystore "$jks_file" -keysize "$rsa_bits"
```
<!-- cheat
var alias
var jks_file
var rsa_bits := 2048
-->

### Generate self-signed

Generate a self-signed certificate in a keystore.

```sh title:"Generate self-signed cert in Java keystore"
keytool -genkey -keyalg RSA -alias "$alias" -keystore "$jks_file" -storepass "$store_pass" -validity "$days" -keysize "$rsa_bits"
```
<!-- cheat
var alias
var jks_file
var store_pass
var days := 365
var rsa_bits := 2048
-->

### CSR

Generate a CSR from an existing keystore entry.

```sh title:"Generate CSR from Java keystore"
keytool -certreq -alias "$alias" -keystore "$jks_file" -file "$csr_file"
```
<!-- cheat
var alias
var jks_file
var csr_file
-->

### Import CA

Import a root or intermediate CA certificate.

```sh title:"Import CA certificate into Java keystore"
keytool -import -trustcacerts -alias root -file "$cert_file" -keystore "$jks_file"
```
<!-- cheat
var cert_file
var jks_file
-->

### Import signed cert

Import a signed primary certificate.

```sh title:"Import signed certificate into Java keystore"
keytool -import -trustcacerts -alias "$alias" -file "$cert_file" -keystore "$jks_file"
```
<!-- cheat
var alias
var cert_file
var jks_file
-->

### List keystore

List certificates in a keystore.

```sh title:"List Java keystore entries"
keytool -list -v -keystore "$jks_file"
```
<!-- cheat
var jks_file
-->

### List alias

List one keystore entry by alias.

```sh title:"List Java keystore alias"
keytool -list -v -keystore "$jks_file" -alias "$alias"
```
<!-- cheat
var jks_file
var alias
-->

### Delete alias

Delete an entry from a keystore.

```sh title:"Delete Java keystore alias"
keytool -delete -alias "$alias" -keystore "$jks_file"
```
<!-- cheat
var alias
var jks_file
-->

### Change password

Change a keystore password.

```sh title:"Change Java keystore password"
keytool -storepasswd -keystore "$jks_file" -new "$new_pass"
```
<!-- cheat
var jks_file
var new_pass
-->

### Export certificate

Export a certificate from a keystore.

```sh title:"Export certificate from Java keystore"
keytool -export -alias "$alias" -file "$cert_file" -keystore "$jks_file"
```
<!-- cheat
var alias
var cert_file
var jks_file
-->

## certificates

### Print certificate

Print a standalone certificate.

```sh title:"Print certificate details with keytool"
keytool -printcert -v -file "$cert_file"
```
<!-- cheat
var cert_file
-->

### List default CAs

List the trusted CAs in Java's default truststore.

```sh title:"List Java default trusted CAs"
keytool -list -v -keystore "$java_home/jre/lib/security/cacerts"
```
<!-- cheat
var java_home
-->

### Import default CA

Import a CA into Java's default truststore.

```sh title:"Import CA into Java default truststore"
keytool -import -trustcacerts -file "$pem_file" -alias "$alias" -keystore "$java_home/jre/lib/security/cacerts"
```
<!-- cheat
var pem_file
var alias
var java_home
-->
