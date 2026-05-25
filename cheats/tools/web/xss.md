# Xss

## XSS some simple tricks

### XSS payload + listener

List payload + listener with Xss.

```sh title:"XSS List Payload + Listener"
echo '$xss_payloads' | xclip -sel clip && nc -lvnp $lport
```
<!-- cheat
import webserver
import tun_ip
import xss_quick_payloads
var port
var lport
-->

## scan

### Dalfox URL scan

Scan dalfox URL scan with Xss.

```sh title:"XSS Scan Dalfox URL Scan"
dalfox url "$url"
```
<!-- cheat
var url
-->

### Dalfox request scan

Scan dalfox request scan with Xss.

```sh title:"XSS Scan Dalfox Request Scan"
dalfox file "$request_file"
```
<!-- cheat
var request_file
-->

### Reflected parameter probe

Scan reflected parameter probe with Xss.

```sh title:"XSS Scan Reflected Parameter Probe"
curl -sk "$url?$param=$probe"
```
<!-- cheat
var url
var param
var probe
-->
