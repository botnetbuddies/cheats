# Zip

## create

### Create zip

Create a zip archive from one or more files.

```sh title:"Create zip archive from files"
zip "$archive_name.zip" $files
```
<!-- cheat
var archive_name
var files
-->

### Zip current directory

Create a zip archive containing files in the current directory.

```sh title:"Zip files in current directory"
zip "$archive_name.zip" *
```
<!-- cheat
var archive_name
-->

### Zip folder

Recursively zip a folder.

```sh title:"Recursively zip folder"
zip -r "$archive_name.zip" "$folder"
```
<!-- cheat
var archive_name
var folder
-->

### Add file

Add or update a file inside an existing zip archive.

```sh title:"Add or update file in zip archive"
zip -u "$archive_name.zip" "$file_to_add"
```
<!-- cheat
var archive_name
var file_to_add
-->

### Zip symlink

Store a symlink as a symlink instead of following it.

```sh title:"Zip symlink without following it"
zip --symlinks "$archive_name.zip" "$symlink_file"
```
<!-- cheat
var archive_name
var symlink_file
-->

## inspect

### Zip info

Show zip archive contents and metadata.

```sh title:"Show zip archive info"
zipinfo "$archive_file"
```
<!-- cheat
var archive_file
-->

### Detailed listing

List detailed zip archive contents.

```sh title:"List detailed zip archive contents"
unzip -Z "$archive_file"
```
<!-- cheat
var archive_file
-->

## extract

### Unzip

Extract a zip archive into the current directory.

```sh title:"Extract zip archive"
unzip "$archive_file"
```
<!-- cheat
var archive_file
-->

### Unzip to directory

Extract a zip archive into a destination directory.

```sh title:"Extract zip archive to directory"
unzip "$archive_file" -d "$destination_folder"
```
<!-- cheat
var archive_file
var destination_folder
-->
