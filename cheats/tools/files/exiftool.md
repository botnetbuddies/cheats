# Exiftool

## exiftool tricks

### Payload inside image

Run payload inside image with Exiftool.

Embed a payload string into the EXIF Comment field. Common stager trick for image-upload endpoints that don't strip metadata before processing.

```sh title:"Exiftool Run Payload Inside Image"
exiftool -Comment='$payloads' $file
```
<!-- cheat
import payloads
import files
import tun_ip
import webserver
-->

