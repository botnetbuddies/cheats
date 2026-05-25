# Gowitness

## screenshots

### Nmap XML

Screenshot web services from an nmap XML file with gowitness Docker image.

```sh title:"Screenshot web services from nmap XML with gowitness"
docker run --rm -v "$(pwd):/data" -p 7171:7171 leonjza/gowitness gowitness nmap -f "/data/$nmap_file"
```
<!-- cheat
var nmap_file
-->

### URL file

Screenshot URLs from a file with gowitness Docker image.

```sh title:"Screenshot URLs from file with gowitness"
docker run --rm -v "$(pwd):/data" -p 7171:7171 leonjza/gowitness gowitness file -f "/data/$url_file"
```
<!-- cheat
var url_file
-->
