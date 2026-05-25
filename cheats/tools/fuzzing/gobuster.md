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

Run basic with Gobuster.

```sh title:"Gobuster Run Basic"
gobuster dir -u "$url" -w "$wordlist_dir" -o "$outfile"
```
<!-- cheat
import gobuster
var url
-->

### Common extensions

Run common extensions with Gobuster.

```sh title:"Gobuster Run Common Extensions"
gobuster dir -u "$url" -w "$wordlist_file" -x json,html,php,txt,xml,md -o "$outfile"
```
<!-- cheat
import gobuster
var url
-->

### Higher threads

Read higher threads with Gobuster.

```sh title:"Gobuster Read Higher Threads"
gobuster dir -u "$url" -w "$wordlist_dir" -t 30 -o "$outfile"
```
<!-- cheat
import gobuster
var url
-->

## vhost

### Vhost discovery

Discover vhost discovery with Gobuster.

```sh title:"Gobuster Discover Vhost Discovery"
gobuster vhost -u "$url" -w "$wordlist_host" -o "$outfile"
```
<!-- cheat
import gobuster
var url
-->
