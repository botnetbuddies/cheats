# Zip

## create

### Create zip

Create zip with Zip.

```sh title:"Zip Create Zip"
zip "$archive_name.zip" $files
```
<!-- cheat
var archive_name
var files
-->

### Zip current directory

Create current directory with Zip.

```sh title:"Zip Create Current Directory"
zip "$archive_name.zip" *
```
<!-- cheat
var archive_name
-->

### Zip folder

Create folder with Zip.

```sh title:"Zip Create Folder"
zip -r "$archive_name.zip" "$folder"
```
<!-- cheat
var archive_name
var folder
-->

### Add file

Add file with Zip.

```sh title:"Zip Add File"
zip -u "$archive_name.zip" "$file_to_add"
```
<!-- cheat
var archive_name
var file_to_add
-->

### Zip symlink

Create symlink with Zip.

```sh title:"Zip Create Symlink"
zip --symlinks "$archive_name.zip" "$symlink_file"
```
<!-- cheat
var archive_name
var symlink_file
-->

## inspect

### Zip info

Show info with Zip.

```sh title:"Zip Show Info"
zipinfo "$archive_file"
```
<!-- cheat
var archive_file
-->

### Detailed listing

List detailed listing with Zip.

```sh title:"Zip List Detailed Listing"
unzip -Z "$archive_file"
```
<!-- cheat
var archive_file
-->

## extract

### Unzip

Extract unzip with Zip.

```sh title:"Zip Extract Unzip"
unzip "$archive_file"
```
<!-- cheat
var archive_file
-->

### Unzip to directory

Extract unzip to directory with Zip.

```sh title:"Zip Extract Unzip to Directory"
unzip "$archive_file" -d "$destination_folder"
```
<!-- cheat
var archive_file
var destination_folder
-->
