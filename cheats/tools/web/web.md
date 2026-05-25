# Web

## recon

### Extract linked hosts

Extract linked hosts with Web.

```sh title:"Web Extract Linked Hosts"
curl -k -s "$url" | grep -o 'http://[^"]*' | cut -d "/" -f 3 | sort -u
```
<!-- cheat
var url
-->
