# Ffuf

<!-- cheat
export ffuf
import scheme
import wordlist_host
import wordlist_file
import wordlist_dir
var outfile = printf '%s\n' ffuf.json "ffuf-$(date +%Y%m%d-%H%M%S).json" --- --header 'Output file'
-->

## ffuf

### host

Vhost fuzzing: send the request to the IP and rotate the Host header to find virtual hosts behind the same listener. `-ac` auto-calibrates response filtering.

```sh title:"Ffuf Vhost fuzz via Host header against IP, auto calibrate"
ffuf -t 400 -w $wordlist_host -u $scheme://$rhost_ip -H "Host: FUZZ.$domain" -ac -o ffuf-host-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
import domain_ip
-->

### host with wordlist

Vhost fuzzing with an explicit wordlist.

```sh title:"Ffuf Vhost fuzz with explicit wordlist"
ffuf -w "$wordlist" -u "$url" -H "Host: FUZZ.$domain" -ac -o "$outfile"
```
<!-- cheat
import ffuf
var wordlist
var url
var domain
-->

### file

File-name fuzzing at the document root. Useful for hunting backups, configs, and orphaned scripts.

```sh title:"Ffuf File-name fuzz at document root, JSON output"
ffuf -t 400 -w $wordlist_file -u $scheme://$domain/FUZZ -ac -o ffuf-file-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
import domain_ip
-->

### dir

Recursive directory fuzzing two levels deep. Good first sweep before targeted file fuzzing.

```sh title:"Ffuf Recursive directory fuzz, depth 2, JSON output"
ffuf -t 400 -w $wordlist_dir -u $scheme://$domain/FUZZ -recursion -recursion-depth 2 -ac -o ffuf-dir-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
import domain_ip
-->

### directory common

Directory fuzzing with `dirb/common.txt`.

```sh title:"Ffuf Directory fuzz with dirb common"
ffuf -u "$url/FUZZ" -w /usr/share/wordlists/dirb/common.txt -ac -o "$outfile"
```
<!-- cheat
import ffuf
var url
-->

### directory medium

Directory fuzzing with `directory-list-2.3-medium.txt`.

```sh title:"Ffuf Directory fuzz with directory-list-2.3-medium"
ffuf -u "$url/FUZZ" -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -ac -o "$outfile"
```
<!-- cheat
import ffuf
var url
-->

### GET parameter

Fuzz a GET parameter and filter by response size.

```sh title:"Ffuf Fuzz GET parameter and filter response size"
ffuf -w "$wordlist" -u "$url?$param=FUZZ" -fs "$response_size" -o "$outfile"
```
<!-- cheat
import ffuf
var wordlist
var url
var param
var response_size
-->
