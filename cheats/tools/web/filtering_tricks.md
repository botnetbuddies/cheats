# Filtering_tricks

## Nmap output filtering trick

### Nmap ports to CSV

Squash an nmap text report into a comma separated port list, ready to paste into another `-p` flag for a deeper scan.

```sh title:"Filtering_tricks Squash nmap report into CSV port list for -p"
cat $file | grep /tcp | cut -d/ -f1 | tr '\n' ',' | sed 's/,$/\n/'
```
<!-- cheat
import files
-->

