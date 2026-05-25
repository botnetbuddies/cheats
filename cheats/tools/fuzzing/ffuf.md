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

Run host with Ffuf.

```sh title:"Ffuf Run Host"
ffuf -t 400 -w $wordlist_host -u $scheme://$rhost_ip -H "Host: FUZZ.$domain" -ac -o ffuf-host-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
import domain_ip
-->

### host with wordlist

List host with wordlist with Ffuf.

```sh title:"Ffuf List Host with Wordlist"
ffuf -w "$wordlist" -u "$url" -H "Host: FUZZ.$domain" -ac -o "$outfile"
```
<!-- cheat
import ffuf
var wordlist
var url
var domain
-->

### file

Run file with Ffuf.

```sh title:"Ffuf Run File"
ffuf -t 400 -w $wordlist_file -u $scheme://$domain/FUZZ -ac -o ffuf-file-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
import domain_ip
-->

### dir

Run dir with Ffuf.

```sh title:"Ffuf Run Dir"
ffuf -t 400 -w $wordlist_dir -u $scheme://$domain/FUZZ -recursion -recursion-depth 2 -ac -o ffuf-dir-$(date +%Y%m%d-%H%M%S).json
```
<!-- cheat
import ffuf
import domain_ip
-->

### directory common

Run directory common with Ffuf.

```sh title:"Ffuf Run Directory Common"
ffuf -u "$url/FUZZ" -w /usr/share/wordlists/dirb/common.txt -ac -o "$outfile"
```
<!-- cheat
import ffuf
var url
-->

### directory medium

List directory medium with Ffuf.

```sh title:"Ffuf List Directory Medium"
ffuf -u "$url/FUZZ" -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -ac -o "$outfile"
```
<!-- cheat
import ffuf
var url
-->

### GET parameter

Get parameter with Ffuf.

```sh title:"Ffuf Get Parameter"
ffuf -w "$wordlist" -u "$url?$param=FUZZ" -fs "$response_size" -o "$outfile"
```
<!-- cheat
import ffuf
var wordlist
var url
var param
var response_size
-->
