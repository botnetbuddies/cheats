# Find

## files

### By extension

Find Find by extension.

Search the filesystem for files with an extension.

```sh title:"Find by Extension"
find / -type f -name "*.$extension" 2>/dev/null
```
<!-- cheat
var extension
-->

### By owner and group

Find Find by owner and group.

Find files owned by a user and group.

```sh title:"Find by Owner and Group"
find / -type f -user "$user" -group "$group" 2>/dev/null
```
<!-- cheat
var user
var group
-->

### Modified recently

Find modified recently with Find.

Find files modified in the last N days.

```sh title:"Find Modified Recently"
find / -type f -mtime "-$days" 2>/dev/null
```
<!-- cheat
var days
-->

### By size

Find Find by size.

Find files by size expression, such as `+10M` or `500c`.

```sh title:"Find by Size"
find / -type f -size "$size" 2>/dev/null
```
<!-- cheat
var size
-->

### Large files

Find large files with Find.

Find files larger than 10 MB.

```sh title:"Find Large Files"
find / -type f -size +10M 2>/dev/null
```
<!-- cheat -->

### Hidden files

Find hidden files with Find.

Find hidden files under the current directory.

```sh title:"Find Hidden Files"
find . -maxdepth "$depth" -type f -iname ".*" 2>/dev/null
```
<!-- cheat
var depth
-->

## permissions

### SUID binaries

Find SUID binaries with Find.

Find SUID binaries.

```sh title:"Find SUID Binaries"
find / -type f -perm -4000 -exec ls -l {} \; 2>/dev/null
```
<!-- cheat -->

### SGID binaries

Find SGID binaries with Find.

Find SGID binaries.

```sh title:"Find SGID Binaries"
find / -type f -perm -2000 -exec ls -l {} \; 2>/dev/null
```
<!-- cheat -->

### World-writable directories

Find world writable directories with Find.

Find world-writable directories.

```sh title:"Find World Writable Directories"
find / -type d -perm -0002 -print 2>/dev/null
```
<!-- cheat -->

### World-writable files

Find world writable files with Find.

Find world-writable files.

```sh title:"Find World Writable Files"
find / -type f -perm -0002 -print 2>/dev/null
```
<!-- cheat -->

### Executable files

Find executable files with Find.

Find executable files while skipping `/proc`.

```sh title:"Find Executable Files"
find / -type f -executable -not -path "/proc/*" 2>/dev/null
```
<!-- cheat -->

## content

### Password files

Read password files with Find.

Find readable files that contain the word `password`.

```sh title:"Find Read Password Files"
find / -type f -readable -exec grep -Il "password" {} \; 2>/dev/null
```
<!-- cheat -->
