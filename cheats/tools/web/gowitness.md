# Gowitness

## screenshots

### Nmap XML

Run nmap XML with Gowitness.

Screenshot web services from an nmap XML file with gowitness Docker image.

```sh title:"Gowitness Run Nmap XML"
docker run --rm -v "$(pwd):/data" -p 7171:7171 leonjza/gowitness gowitness nmap -f "/data/$nmap_file"
```
<!-- cheat
var nmap_file
-->

### URL file

Run URL file with Gowitness.

Screenshot URLs from a file with gowitness Docker image.

```sh title:"Gowitness Run URL File"
docker run --rm -v "$(pwd):/data" -p 7171:7171 leonjza/gowitness gowitness file -f "/data/$url_file"
```
<!-- cheat
var url_file
-->
