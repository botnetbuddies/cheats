# Exiftool

## exiftool tricks

### Payload inside image

Run payload inside image with Exiftool.

```sh title:"Exiftool Run Payload Inside Image"
exiftool -Comment='$payloads' $file
```
<!-- cheat
import payloads
import files
import tun_ip
import webserver
-->

