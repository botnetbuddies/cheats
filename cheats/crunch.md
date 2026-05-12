# Crunch

## wordlists

### Hex

Generate a hex wordlist.

```sh title:"Generate hex wordlist"
crunch "$min_length" "$max_length" 0123456789ABCDEF -o "$output_file"
```
<!-- cheat
var min_length := 2
var max_length := 8
var output_file
-->

### Charset

Generate a wordlist from a Crunch charset.

```sh title:"Generate wordlist from Crunch charset"
crunch "$min_length" "$max_length" -f /usr/share/crunch/charset.lst "$charset" -o "$output_file"
```
<!-- cheat
var min_length
var max_length
var charset := mixalpha-numeric
var output_file
-->

### Pattern

Generate a wordlist from a pattern. `@` is lowercase, `,` is uppercase, `%` is digit, and `^` is symbol.

```sh title:"Generate wordlist from Crunch pattern"
crunch "$min_length" "$max_length" -t "$pattern" -o "$output_file"
```
<!-- cheat
var min_length := 8
var max_length := 8
var pattern := ,@@@%%%^
var output_file
-->

### Password pattern

Generate `password` plus two digits and one symbol.

```sh title:"Generate password%%^ pattern wordlist"
crunch 10 10 -t 'password%%^' -o "$output_file"
```
<!-- cheat
var output_file
-->
