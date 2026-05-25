# Feroxbuster

<!-- cheat
export feroxbuster
import scheme
import wordlist_file
import wordlist_dir
var outfile = printf '%s\n' ferox.json "ferox-$(date +%Y%m%d-%H%M%S).json" --- --header 'Output file'
-->

## scan

### Default

Run a default feroxbuster scan.

```sh title:"Run default feroxbuster scan"
feroxbuster --url "$url" -w "$wordlist_dir"
```
<!-- cheat
import feroxbuster
var url
-->

### Wordlist

Run feroxbuster with an explicit wordlist.

```sh title:"Run feroxbuster with wordlist"
feroxbuster --url "$url" -w "$wordlist"
```
<!-- cheat
import feroxbuster
var url
var wordlist
-->

### Directory common

Run feroxbuster with the selected directory wordlist.

```sh title:"Run feroxbuster with selected directory wordlist"
feroxbuster --url "$url" -w "$wordlist_dir" --json -o "$outfile"
```
<!-- cheat
import feroxbuster
var url
-->

### File wordlist

Run feroxbuster with the selected file wordlist.

```sh title:"Run feroxbuster with selected file wordlist"
feroxbuster --url "$url" -w "$wordlist_file" --json -o "$outfile"
```
<!-- cheat
import feroxbuster
var url
-->

### Header

Run feroxbuster with a custom header.

```sh title:"Run feroxbuster with custom header"
feroxbuster -u "$url" -H "$header"
```
<!-- cheat
import feroxbuster
var url
var header
-->

### IPv6 no recursion

Run a non-recursive IPv6 scan.

```sh title:"Run non-recursive IPv6 feroxbuster scan"
feroxbuster -u "$scheme://[$ipv6]" --no-recursion -vv
```
<!-- cheat
import feroxbuster
var scheme := https
var ipv6
-->

### Auto bail

Abort or reduce speed when too many errors occur.

```sh title:"Run feroxbuster with auto-bail"
feroxbuster -u "$url" --auto-bail
```
<!-- cheat
import feroxbuster
var url
-->
