# Web

## recon

### Extract linked hosts

Extract linked HTTP hosts from a page.

```sh title:"Web Extract linked HTTP hosts from page"
curl -k -s "$url" | grep -o 'http://[^"]*' | cut -d "/" -f 3 | sort -u
```
<!-- cheat
var url
-->
