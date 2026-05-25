# Gzip

## files

### Compress file

Run compress file with Gzip.

Compress a file in place and append `.gz`.

```sh title:"Gzip Run Compress File"
gzip "$path"
```
<!-- cheat
var path
-->

### Decompress file

Run decompress file with Gzip.

Decompress a gzip file in place.

```sh title:"Gzip Run Decompress File"
gzip -d "$gz_file"
```
<!-- cheat
var gz_file
-->

### Keep original

Run keep original with Gzip.

Compress a file and keep the original.

```sh title:"Gzip Run Keep Original"
gzip -k "$path"
```
<!-- cheat
var path
-->
