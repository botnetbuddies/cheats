# Redis

## connect

### Local

Connect to a local Redis server.

```sh title:"Connect to local Redis"
redis-cli
```
<!-- cheat -->

### Remote default port

Connect to a remote Redis server on the default port.

```sh title:"Connect to remote Redis on 6379"
redis-cli -h "$rhost_ip" -a "$pass"
```
<!-- cheat
var rhost_ip
var pass
-->

### Remote custom port

Connect to a remote Redis server on a custom port.

```sh title:"Connect to remote Redis on custom port"
redis-cli -h "$rhost_ip" -p "$rport" -a "$pass"
```
<!-- cheat
var rhost_ip
var rport
var pass
-->

### TLS with CA

Connect to Redis over TLS with a CA certificate.

```sh title:"Connect to Redis over TLS with CA certificate"
redis-cli -h "$rhost_ip" -p "$rport" --tls --cacert "$ca_cert"
```
<!-- cheat
var rhost_ip
var rport := 6379
var ca_cert
-->

### TLS with client cert

Connect to Redis over TLS with CA, client certificate, and client key.

```sh title:"Connect to Redis over TLS with client certificate"
redis-cli -h "$rhost_ip" -p "$rport" --tls --cacert "$ca_cert" --cert "$client_cert" --key "$client_key"
```
<!-- cheat
var rhost_ip
var rport := 6379
var ca_cert
var client_cert
var client_key
-->
