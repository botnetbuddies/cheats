# Find

## files

### By extension

Search the filesystem for files with an extension.

```sh title:"Find files by extension"
find / -type f -name "*.$extension" 2>/dev/null
```
<!-- cheat
var extension
-->

### By owner and group

Find files owned by a user and group.

```sh title:"Find files by owner and group"
find / -type f -user "$user" -group "$group" 2>/dev/null
```
<!-- cheat
var user
var group
-->

### Modified recently

Find files modified in the last N days.

```sh title:"Find files modified in last N days"
find / -type f -mtime "-$days" 2>/dev/null
```
<!-- cheat
var days
-->

### By size

Find files by size expression, such as `+10M` or `500c`.

```sh title:"Find files by size expression"
find / -type f -size "$size" 2>/dev/null
```
<!-- cheat
var size
-->

### Large files

Find files larger than 10 MB.

```sh title:"Find files larger than 10 MB"
find / -type f -size +10M 2>/dev/null
```
<!-- cheat -->

### Hidden files

Find hidden files under the current directory.

```sh title:"Find hidden files under current directory"
find . -maxdepth "$depth" -type f -iname ".*" 2>/dev/null
```
<!-- cheat
var depth
-->

## permissions

### SUID binaries

Find SUID binaries.

```sh title:"Find SUID binaries"
find / -type f -perm -4000 -exec ls -l {} \; 2>/dev/null
```
<!-- cheat -->

### SGID binaries

Find SGID binaries.

```sh title:"Find SGID binaries"
find / -type f -perm -2000 -exec ls -l {} \; 2>/dev/null
```
<!-- cheat -->

### World-writable directories

Find world-writable directories.

```sh title:"Find world-writable directories"
find / -type d -perm -0002 -print 2>/dev/null
```
<!-- cheat -->

### World-writable files

Find world-writable files.

```sh title:"Find world-writable files"
find / -type f -perm -0002 -print 2>/dev/null
```
<!-- cheat -->

### Executable files

Find executable files while skipping `/proc`.

```sh title:"Find executable files outside /proc"
find / -type f -executable -not -path "/proc/*" 2>/dev/null
```
<!-- cheat -->

## content

### Password files

Find readable files that contain the word `password`.

```sh title:"Find readable files containing password"
find / -type f -readable -exec grep -Il "password" {} \; 2>/dev/null
```
<!-- cheat -->
