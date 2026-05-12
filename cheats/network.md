# Network

## public ip

### IP info

Query ipinfo.io for an IP address.

```sh title:"Query ipinfo.io for IP details"
curl "https://ipinfo.io/$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Current public IP

Show your current public IP details.

```sh title:"Show current public IP details"
curl https://ipinfo.io/
```
<!-- cheat -->

### Current public IP plaintext

Show only your current public IP.

```sh title:"Show current public IP"
curl https://ipecho.net/plain/
```
<!-- cheat -->

## egress

### Curl port check

Test outbound connectivity to a port with portquiz.

```sh title:"Test outbound port with curl"
curl "portquiz.net:$rport"
```
<!-- cheat
var rport
-->

### Netcat port check

Test outbound connectivity to a port with netcat.

```sh title:"Test outbound port with netcat"
nc -v portquiz.net "$rport"
```
<!-- cheat
var rport
-->
