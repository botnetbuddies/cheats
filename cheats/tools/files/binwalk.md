# Binwalk

## firmware

### Extract recursively

Recursively extract files from firmware.

```sh title:"Binwalk Recursively extract firmware files"
binwalk -Me "$firmware_file"
```
<!-- cheat
var firmware_file
-->

### Entropy

Compute entropy for a firmware file.

```sh title:"Binwalk Compute firmware entropy"
binwalk -E "$firmware_file"
```
<!-- cheat
var firmware_file
-->

### Signatures

Scan a firmware file for known signatures.

```sh title:"Binwalk Scan firmware for signatures"
binwalk "$firmware_file"
```
<!-- cheat
var firmware_file
-->
