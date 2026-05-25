# EyeWitness

## screenshots

### Nmap XML

Run nmap XML with EyeWitness.

Run EyeWitness in Docker against an nmap XML file.

```sh title:"EyeWitness Run Nmap XML"
docker run --rm -it -v "$(pwd):/tmp/EyeWitness" eyewitness --web -x "/tmp/EyeWitness/$nmap_file" --prepend-https
```
<!-- cheat
var nmap_file
-->
