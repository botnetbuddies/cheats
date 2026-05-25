# Tar

## create

### Create tar

Create an uncompressed tar archive.

```sh title:"Create uncompressed tar archive"
tar cf "$archive_name.tar" $files
```
<!-- cheat
var archive_name
var files
-->

### Create tar.gz

Create a gzip-compressed tar archive.

```sh title:"Create gzip-compressed tar archive"
tar czf "$archive_name.tar.gz" $files
```
<!-- cheat
var archive_name
var files
-->

## extract

### Extract tar

Extract an uncompressed tar archive into the current directory.

```sh title:"Extract tar archive"
tar xf "$archive_file"
```
<!-- cheat
var archive_file
-->

### Extract tar.gz

Extract a gzip-compressed tar archive into the current directory.

```sh title:"Extract gzip-compressed tar archive"
tar xzf "$archive_file"
```
<!-- cheat
var archive_file
-->

### List tar contents

List archive contents without extracting files.

```sh title:"List tar archive contents"
tar tf "$archive_file"
```
<!-- cheat
var archive_file
-->
