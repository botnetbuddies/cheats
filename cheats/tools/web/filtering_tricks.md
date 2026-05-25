# Filtering_tricks

## Nmap output filtering trick

### Nmap ports to CSV

List nmap ports to CSV with Filtering_tricks.

Squash an nmap text report into a comma separated port list, ready to paste into another `-p` flag for a deeper scan.

```sh title:"Filtering Tricks List Nmap Ports to CSV"
cat $file | grep /tcp | cut -d/ -f1 | tr '\n' ',' | sed 's/,$/\n/'
```
<!-- cheat
import files
-->

