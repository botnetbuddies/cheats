# Wfuzz

<!-- cheat
export wfuzz
import wordlist_file
import wordlist_dir
var outfile = printf '%s\n' wfuzz.txt "wfuzz-$(date +%Y%m%d-%H%M%S).txt" --- --header 'Output file'
-->

## fuzz

### Number range

Run number range with Wfuzz.

Fuzz a URL with a numeric range.

```sh title:"Wfuzz Run Number Range"
wfuzz -z range,1-1000 -u "$url_fuzz"
```
<!-- cheat
import wfuzz
var url_fuzz
-->

### Wordlist URL

List wordlist URL with Wfuzz.

Fuzz a URL with a wordlist.

```sh title:"Wfuzz List Wordlist URL"
wfuzz -z "file,$wordlist_dir" -u "$url_fuzz" | tee "$outfile"
```
<!-- cheat
import wfuzz
var url_fuzz
-->

### File wordlist URL

List file wordlist URL with Wfuzz.

Fuzz a URL with the selected file wordlist.

```sh title:"Wfuzz List File Wordlist URL"
wfuzz -z "file,$wordlist_file" -u "$url_fuzz" | tee "$outfile"
```
<!-- cheat
import wfuzz
var url_fuzz
-->

### POST parameter

Run POST parameter with Wfuzz.

Fuzz a POST parameter value.

```sh title:"Wfuzz Run POST Parameter"
wfuzz -z "file,$wordlist_file" -X POST -u "$url" -d "$param=FUZZ" | tee "$outfile"
```
<!-- cheat
import wfuzz
var url
var param
-->
