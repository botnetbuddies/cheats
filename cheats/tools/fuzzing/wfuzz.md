# Wfuzz

<!-- cheat
export wfuzz
import wordlist_file
import wordlist_dir
var outfile = printf '%s\n' wfuzz.txt "wfuzz-$(date +%Y%m%d-%H%M%S).txt" --- --header 'Output file'
-->

## fuzz

### Number range

Fuzz a URL with a numeric range.

```sh title:"Fuzz URL with numeric range"
wfuzz -z range,1-1000 -u "$url_fuzz"
```
<!-- cheat
import wfuzz
var url_fuzz
-->

### Wordlist URL

Fuzz a URL with a wordlist.

```sh title:"Fuzz URL with wordlist"
wfuzz -z "file,$wordlist_dir" -u "$url_fuzz" | tee "$outfile"
```
<!-- cheat
import wfuzz
var url_fuzz
-->

### File wordlist URL

Fuzz a URL with the selected file wordlist.

```sh title:"Fuzz URL with selected file wordlist"
wfuzz -z "file,$wordlist_file" -u "$url_fuzz" | tee "$outfile"
```
<!-- cheat
import wfuzz
var url_fuzz
-->

### POST parameter

Fuzz a POST parameter value.

```sh title:"Fuzz POST parameter value"
wfuzz -z "file,$wordlist_file" -X POST -u "$url" -d "$param=FUZZ" | tee "$outfile"
```
<!-- cheat
import wfuzz
var url
var param
-->
