---
technique: Web Directory Discovery
category: content-discovery
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web content-discovery directories ffuf feroxbuster gobuster
---

# Web Directory Discovery

Directory discovery identifies hidden routes, applications, static content, backups, and admin panels.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| URL | Requires an in-scope base URL |
| Wordlist | Choose a list that matches the target language and stack |
| Filtering | Calibrate status, size, and word filters against wildcard responses |

## Linux

### feroxbuster default

#sh #feroxbuster #web

Run a default feroxbuster scan.

```sh title:"Run feroxbuster default scan"
feroxbuster --url "$url"
```
<!-- cheat
var url
-->

### feroxbuster wordlist

#sh #feroxbuster #web

Run feroxbuster with an explicit wordlist.

```sh title:"Run feroxbuster with wordlist"
feroxbuster --url "$url" -w "$wordlist"
```
<!-- cheat
var url
var wordlist
-->

### gobuster basic

#sh #gobuster #web

Run basic directory fuzzing.

```sh title:"Run gobuster directory fuzzing"
gobuster dir -u "$url" -w "$wordlist"
```
<!-- cheat
var url
var wordlist
-->

### gobuster extensions

#sh #gobuster #web

Run directory fuzzing with common extensions.

```sh title:"Run gobuster with common extensions"
gobuster dir -u "$url" -w "$wordlist" -x json,html,php,txt,xml,md
```
<!-- cheat
var url
var wordlist
-->

### ffuf directory

#sh #ffuf #web

Fuzz directories with ffuf.

```sh title:"Fuzz directories with ffuf"
ffuf -u "$url/FUZZ" -w "$wordlist" -ac -o "$outfile"
```
<!-- cheat
var url
var wordlist
var outfile
-->
