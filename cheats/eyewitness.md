# EyeWitness

## screenshots

### Nmap XML

Run EyeWitness in Docker against an nmap XML file.

```sh title:"Screenshot web services from nmap XML with EyeWitness"
docker run --rm -it -v "$(pwd):/tmp/EyeWitness" eyewitness --web -x "/tmp/EyeWitness/$nmap_file" --prepend-https
```
<!-- cheat
var nmap_file
-->
