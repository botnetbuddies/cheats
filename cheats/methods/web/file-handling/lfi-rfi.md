---
technique: LFI and RFI Testing
category: file-handling
targets: Web Applications
protocols: HTTP, File Inclusion
remote_capable: true
tags: web lfi rfi file-inclusion
---

# LFI and RFI Testing

LFI and RFI testing checks whether file path inputs can read local files or include remote resources.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| File parameter | Requires a suspected path or template parameter |
| Payloads | Use authorized benign files and callbacks |
| Platform | Path syntax differs by operating system and framework |

## Linux

### LFI probe

#sh #curl #lfi

Send a local file inclusion probe.

```sh title:"Send LFI probe"
curl -sk "$url?$param=$file_path"
```
<!-- cheat
var url
var param
var file_path
-->

### Traversal fuzz

#sh #ffuf #lfi

Fuzz path traversal payloads.

```sh title:"Fuzz LFI payloads"
ffuf -w "$wordlist" -u "$url?$param=FUZZ" -ac -o "$outfile"
```
<!-- cheat
var wordlist
var url
var param
var outfile
-->

### Remote include probe

#sh #curl #rfi

Send a remote include probe.

```sh title:"Send RFI probe"
curl -sk "$url?$param=$remote_url"
```
<!-- cheat
var url
var param
var remote_url
-->
