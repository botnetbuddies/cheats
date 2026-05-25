# EyeWitness

## screenshots

### Nmap XML

Run nmap XML with EyeWitness.

```sh title:"EyeWitness Run Nmap XML"
docker run --rm -it -v "$(pwd):/tmp/EyeWitness" eyewitness --web -x "/tmp/EyeWitness/$nmap_file" --prepend-https
```
<!-- cheat
var nmap_file
-->
