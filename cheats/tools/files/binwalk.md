# Binwalk

## firmware

### Extract recursively

Extract recursively with Binwalk.

Recursively extract files from firmware.

```sh title:"Binwalk Extract Recursively"
binwalk -Me "$firmware_file"
```
<!-- cheat
var firmware_file
-->

### Entropy

Run entropy with Binwalk.

Compute entropy for a firmware file.

```sh title:"Binwalk Run Entropy"
binwalk -E "$firmware_file"
```
<!-- cheat
var firmware_file
-->

### Signatures

Scan signatures with Binwalk.

Scan a firmware file for known signatures.

```sh title:"Binwalk Scan Signatures"
binwalk "$firmware_file"
```
<!-- cheat
var firmware_file
-->
