# Filtering_tricks

## Nmap output filtering trick

### Nmap ports to CSV

List nmap ports to CSV with Filtering_tricks.

```sh title:"Filtering Tricks List Nmap Ports to CSV"
cat $file | grep /tcp | cut -d/ -f1 | tr '\n' ',' | sed 's/,$/\n/'
```
<!-- cheat
import files
-->

