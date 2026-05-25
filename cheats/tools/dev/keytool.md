# Keytool

## keystore

### Generate keypair

Generate keypair with Keytool.

Generate a Java keystore and RSA keypair.

```sh title:"Keytool Generate Keypair"
keytool -genkey -alias "$alias" -keyalg RSA -keystore "$jks_file" -keysize "$rsa_bits"
```
<!-- cheat
var alias
var jks_file
var rsa_bits := 2048
-->

### Generate self-signed

Generate self signed with Keytool.

Generate a self-signed certificate in a keystore.

```sh title:"Keytool Generate Self Signed"
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

Generate CSR with Keytool.

Generate a CSR from an existing keystore entry.

```sh title:"Keytool Generate CSR"
keytool -certreq -alias "$alias" -keystore "$jks_file" -file "$csr_file"
```
<!-- cheat
var alias
var jks_file
var csr_file
-->

### Import CA

Read import CA with Keytool.

Import a root or intermediate CA certificate.

```sh title:"Keytool Read Import CA"
keytool -import -trustcacerts -alias root -file "$cert_file" -keystore "$jks_file"
```
<!-- cheat
var cert_file
var jks_file
-->

### Import signed cert

Read import signed cert with Keytool.

Import a signed primary certificate.

```sh title:"Keytool Read Import Signed Cert"
keytool -import -trustcacerts -alias "$alias" -file "$cert_file" -keystore "$jks_file"
```
<!-- cheat
var alias
var cert_file
var jks_file
-->

### List keystore

List keystore with Keytool.

List certificates in a keystore.

```sh title:"Keytool List Keystore"
keytool -list -v -keystore "$jks_file"
```
<!-- cheat
var jks_file
-->

### List alias

List alias with Keytool.

List one keystore entry by alias.

```sh title:"Keytool List Alias"
keytool -list -v -keystore "$jks_file" -alias "$alias"
```
<!-- cheat
var jks_file
var alias
-->

### Delete alias

Remove alias with Keytool.

Delete an entry from a keystore.

```sh title:"Keytool Remove Alias"
keytool -delete -alias "$alias" -keystore "$jks_file"
```
<!-- cheat
var alias
var jks_file
-->

### Change password

Dump change password with Keytool.

Change a keystore password.

```sh title:"Keytool Dump Change Password"
keytool -storepasswd -keystore "$jks_file" -new "$new_pass"
```
<!-- cheat
var jks_file
var new_pass
-->

### Export certificate

Read export certificate with Keytool.

Export a certificate from a keystore.

```sh title:"Keytool Read Export Certificate"
keytool -export -alias "$alias" -file "$cert_file" -keystore "$jks_file"
```
<!-- cheat
var alias
var cert_file
var jks_file
-->

## certificates

### Print certificate

Show certificate with Keytool.

Print a standalone certificate.

```sh title:"Keytool Show Certificate"
keytool -printcert -v -file "$cert_file"
```
<!-- cheat
var cert_file
-->

### List default CAs

List default CAs with Keytool.

List the trusted CAs in Java's default truststore.

```sh title:"Keytool List Default CAs"
keytool -list -v -keystore "$java_home/jre/lib/security/cacerts"
```
<!-- cheat
var java_home
-->

### Import default CA

Read import default CA with Keytool.

Import a CA into Java's default truststore.

```sh title:"Keytool Read Import Default CA"
keytool -import -trustcacerts -file "$pem_file" -alias "$alias" -keystore "$java_home/jre/lib/security/cacerts"
```
<!-- cheat
var pem_file
var alias
var java_home
-->
