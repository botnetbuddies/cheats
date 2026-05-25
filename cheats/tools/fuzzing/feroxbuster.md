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

Scan default with Feroxbuster.

Run a default feroxbuster scan.

```sh title:"Feroxbuster Scan Default"
feroxbuster --url "$url" -w "$wordlist_dir"
```
<!-- cheat
import feroxbuster
var url
-->

### Wordlist

Scan wordlist with Feroxbuster.

Run feroxbuster with an explicit wordlist.

```sh title:"Feroxbuster Scan Wordlist"
feroxbuster --url "$url" -w "$wordlist"
```
<!-- cheat
import feroxbuster
var url
var wordlist
-->

### Directory common

Scan directory common with Feroxbuster.

Run feroxbuster with the selected directory wordlist.

```sh title:"Feroxbuster Scan Directory Common"
feroxbuster --url "$url" -w "$wordlist_dir" --json -o "$outfile"
```
<!-- cheat
import feroxbuster
var url
-->

### File wordlist

Scan file wordlist with Feroxbuster.

Run feroxbuster with the selected file wordlist.

```sh title:"Feroxbuster Scan File Wordlist"
feroxbuster --url "$url" -w "$wordlist_file" --json -o "$outfile"
```
<!-- cheat
import feroxbuster
var url
-->

### Header

Scan header with Feroxbuster.

Run feroxbuster with a custom header.

```sh title:"Feroxbuster Scan Header"
feroxbuster -u "$url" -H "$header"
```
<!-- cheat
import feroxbuster
var url
var header
-->

### IPv6 no recursion

Scan IPv6 no recursion with Feroxbuster.

Run a non-recursive IPv6 scan.

```sh title:"Feroxbuster Scan IPv6 No Recursion"
feroxbuster -u "$scheme://[$ipv6]" --no-recursion -vv
```
<!-- cheat
import feroxbuster
var scheme := https
var ipv6
-->

### Auto bail

Scan auto bail with Feroxbuster.

Abort or reduce speed when too many errors occur.

```sh title:"Feroxbuster Scan Auto Bail"
feroxbuster -u "$url" --auto-bail
```
<!-- cheat
import feroxbuster
var url
-->
