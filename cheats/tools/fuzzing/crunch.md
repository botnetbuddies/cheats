# Crunch

## wordlists

### Hex

List hex with Crunch.

Generate a hex wordlist.

```sh title:"Crunch List Hex"
crunch "$min_length" "$max_length" 0123456789ABCDEF -o "$output_file"
```
<!-- cheat
var min_length := 2
var max_length := 8
var output_file
-->

### Charset

List charset with Crunch.

Generate a wordlist from a Crunch charset.

```sh title:"Crunch List Charset"
crunch "$min_length" "$max_length" -f /usr/share/crunch/charset.lst "$charset" -o "$output_file"
```
<!-- cheat
var min_length
var max_length
var charset := mixalpha-numeric
var output_file
-->

### Pattern

List pattern with Crunch.

Generate a wordlist from a pattern. `@` is lowercase, `,` is uppercase, `%` is digit, and `^` is symbol.

```sh title:"Crunch List Pattern"
crunch "$min_length" "$max_length" -t "$pattern" -o "$output_file"
```
<!-- cheat
var min_length := 8
var max_length := 8
var pattern := ,@@@%%%^
var output_file
-->

### Password pattern

Dump password pattern with Crunch.

Generate `password` plus two digits and one symbol.

```sh title:"Crunch Dump Password Pattern"
crunch 10 10 -t 'password%%^' -o "$output_file"
```
<!-- cheat
var output_file
-->
