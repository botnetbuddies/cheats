# Tar

## create

### Create tar

Create tar with Tar.

Create an uncompressed tar archive.

```sh title:"Tar Create Tar"
tar cf "$archive_name.tar" $files
```
<!-- cheat
var archive_name
var files
-->

### Create tar.gz

Create tar.gz with Tar.

Create a gzip-compressed tar archive.

```sh title:"Tar Create Tar.gz"
tar czf "$archive_name.tar.gz" $files
```
<!-- cheat
var archive_name
var files
-->

## extract

### Extract tar

Extract tar with Tar.

Extract an uncompressed tar archive into the current directory.

```sh title:"Tar Extract Tar"
tar xf "$archive_file"
```
<!-- cheat
var archive_file
-->

### Extract tar.gz

Extract tar.gz with Tar.

Extract a gzip-compressed tar archive into the current directory.

```sh title:"Tar Extract Tar.gz"
tar xzf "$archive_file"
```
<!-- cheat
var archive_file
-->

### List tar contents

List tar contents with Tar.

List archive contents without extracting files.

```sh title:"Tar List Tar Contents"
tar tf "$archive_file"
```
<!-- cheat
var archive_file
-->
