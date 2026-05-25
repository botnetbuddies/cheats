# Binwalk

## firmware

### Extract recursively

Extract recursively with Binwalk.

```sh title:"Binwalk Extract Recursively"
binwalk -Me "$firmware_file"
```
<!-- cheat
var firmware_file
-->

### Entropy

Run entropy with Binwalk.

```sh title:"Binwalk Run Entropy"
binwalk -E "$firmware_file"
```
<!-- cheat
var firmware_file
-->

### Signatures

Scan signatures with Binwalk.

```sh title:"Binwalk Scan Signatures"
binwalk "$firmware_file"
```
<!-- cheat
var firmware_file
-->
