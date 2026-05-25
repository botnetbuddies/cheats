# Redis

## connect

### Local

Run local with Redis.

```sh title:"Redis Run Local"
redis-cli
```
<!-- cheat -->

### Remote default port

Run remote default port with Redis.

```sh title:"Redis Run Remote Default Port"
redis-cli -h "$rhost_ip" -a "$pass"
```
<!-- cheat
var rhost_ip
var pass
-->

### Remote custom port

Run remote custom port with Redis.

```sh title:"Redis Run Remote Custom Port"
redis-cli -h "$rhost_ip" -p "$rport" -a "$pass"
```
<!-- cheat
var rhost_ip
var rport
var pass
-->

### TLS with CA

Read TLS with CA with Redis.

```sh title:"Redis Read TLS with CA"
redis-cli -h "$rhost_ip" -p "$rport" --tls --cacert "$ca_cert"
```
<!-- cheat
var rhost_ip
var rport := 6379
var ca_cert
-->

### TLS with client cert

Read TLS with client cert with Redis.

```sh title:"Redis Read TLS with Client Cert"
redis-cli -h "$rhost_ip" -p "$rport" --tls --cacert "$ca_cert" --cert "$client_cert" --key "$client_key"
```
<!-- cheat
var rhost_ip
var rport := 6379
var ca_cert
var client_cert
var client_key
-->

## recon

### Server info

Read server info with Redis.

```sh title:"Redis Read Server Info"
redis-cli -h "$rhost_ip" -p "$rport" -a "$pass" INFO
```
<!-- cheat
var rhost_ip
var rport := 6379
var pass
-->

### Key count

List key count with Redis.

```sh title:"Redis List Key Count"
redis-cli -h "$rhost_ip" -p "$rport" -a "$pass" DBSIZE
```
<!-- cheat
var rhost_ip
var rport := 6379
var pass
-->
