# Gzip

## files

### Compress file

Compress a file in place and append `.gz`.

```sh title:"Compress file in place"
gzip "$path"
```
<!-- cheat
var path
-->

### Decompress file

Decompress a gzip file in place.

```sh title:"Decompress gzip file in place"
gzip -d "$gz_file"
```
<!-- cheat
var gz_file
-->

### Keep original

Compress a file and keep the original.

```sh title:"Compress file and keep original"
gzip -k "$path"
```
<!-- cheat
var path
-->
