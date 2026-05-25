# Xss

## XSS some simple tricks

### XSS payload + listener

List payload + listener with Xss.

Copy a chosen XSS payload to clipboard and start a netcat listener for the cookie/data callback. Streamlines the paste-and-wait loop.

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

Scan a URL with Dalfox.

```sh title:"XSS Scan Dalfox URL Scan"
dalfox url "$url"
```
<!-- cheat
var url
-->

### Dalfox request scan

Scan dalfox request scan with Xss.

Scan a captured request with Dalfox.

```sh title:"XSS Scan Dalfox Request Scan"
dalfox file "$request_file"
```
<!-- cheat
var request_file
-->

### Reflected parameter probe

Scan reflected parameter probe with Xss.

Send a controlled probe value to a parameter.

```sh title:"XSS Scan Reflected Parameter Probe"
curl -sk "$url?$param=$probe"
```
<!-- cheat
var url
var param
var probe
-->
