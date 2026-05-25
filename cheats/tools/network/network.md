# Network

## public ip

### IP info

Show IP info with Network.

Query ipinfo.io for an IP address.

```sh title:"Network Show IP Info"
curl "https://ipinfo.io/$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Current public IP

Show current public IP with Network.

Show your current public IP details.

```sh title:"Network Show Current Public IP"
curl https://ipinfo.io/
```
<!-- cheat -->

### Current public IP plaintext

Show current public IP plaintext with Network.

Show only your current public IP.

```sh title:"Network Show Current Public IP Plaintext"
curl https://ipecho.net/plain/
```
<!-- cheat -->

## egress

### Curl port check

Check curl port check with Network.

Test outbound connectivity to a port with portquiz.

```sh title:"Network Check Curl Port Check"
curl "portquiz.net:$rport"
```
<!-- cheat
var rport
-->

### Netcat port check

Check netcat port check with Network.

Test outbound connectivity to a port with netcat.

```sh title:"Network Check Netcat Port Check"
nc -v portquiz.net "$rport"
```
<!-- cheat
var rport
-->
