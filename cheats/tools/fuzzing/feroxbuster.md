# Feroxbuster

## scan

### Default

Run a default feroxbuster scan.

```sh title:"Run default feroxbuster scan"
feroxbuster --url "$url"
```
<!-- cheat
var url
-->

### Wordlist

Run feroxbuster with an explicit wordlist.

```sh title:"Run feroxbuster with wordlist"
feroxbuster --url "$url" -w "$wordlist"
```
<!-- cheat
var url
var wordlist
-->

### Header

Run feroxbuster with a custom header.

```sh title:"Run feroxbuster with custom header"
feroxbuster -u "$url" -H "$header"
```
<!-- cheat
var url
var header
-->

### IPv6 no recursion

Run a non-recursive IPv6 scan.

```sh title:"Run non-recursive IPv6 feroxbuster scan"
feroxbuster -u "$scheme://[$ipv6]" --no-recursion -vv
```
<!-- cheat
var scheme := https
var ipv6
-->

### Auto bail

Abort or reduce speed when too many errors occur.

```sh title:"Run feroxbuster with auto-bail"
feroxbuster -u "$url" --auto-bail
```
<!-- cheat
var url
-->
