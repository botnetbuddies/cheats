# Gobuster

<!-- cheat
export gobuster
import wordlist_host
import wordlist_file
import wordlist_dir
var outfile = printf '%s\n' gobuster.txt "gobuster-$(date +%Y%m%d-%H%M%S).txt" --- --header 'Output file'
-->

## dir

### Basic

Run basic directory fuzzing.

```sh title:"Basic gobuster directory fuzz"
gobuster dir -u "$url" -w "$wordlist_dir" -o "$outfile"
```
<!-- cheat
import gobuster
var url
-->

### Common extensions

Run directory fuzzing with common web extensions.

```sh title:"Gobuster directory fuzz with common extensions"
gobuster dir -u "$url" -w "$wordlist_file" -x json,html,php,txt,xml,md -o "$outfile"
```
<!-- cheat
import gobuster
var url
-->

### Higher threads

Run directory fuzzing with 30 threads.

```sh title:"Gobuster directory fuzz with 30 threads"
gobuster dir -u "$url" -w "$wordlist_dir" -t 30 -o "$outfile"
```
<!-- cheat
import gobuster
var url
-->

## vhost

### Vhost discovery

Run virtual host discovery with the selected host wordlist.

```sh title:"Gobuster vhost discovery with selected host wordlist"
gobuster vhost -u "$url" -w "$wordlist_host" -o "$outfile"
```
<!-- cheat
import gobuster
var url
-->
