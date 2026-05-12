# Wfuzz

## fuzz

### Number range

Fuzz a URL with a numeric range.

```sh title:"Fuzz URL with numeric range"
wfuzz -z range,1-1000 -u "$url_fuzz"
```
<!-- cheat
var url_fuzz
-->

### Wordlist URL

Fuzz a URL with a wordlist.

```sh title:"Fuzz URL with wordlist"
wfuzz -z "file,$wordlist" -u "$url_fuzz"
```
<!-- cheat
var wordlist
var url_fuzz
-->

### POST parameter

Fuzz a POST parameter value.

```sh title:"Fuzz POST parameter value"
wfuzz -z "file,$wordlist" -X POST -u "$url" -d "$param=FUZZ"
```
<!-- cheat
var wordlist
var url
var param
-->
