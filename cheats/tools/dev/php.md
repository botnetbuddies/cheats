# PHP

## grep

### Include sinks

Find include/require calls using variable input.

```sh title:"Find PHP include/require sinks"
grep -rn --include "*.php" -e '^\(.*\s\|\)\(include\|require\|virtual\|require_once\|include_once\)\(\s\|(\).*\$' --color
```
<!-- cheat -->

### File read sinks

Find file read functions using variable input.

```sh title:"Find PHP file read sinks"
grep -rn --include "*.php" -e '^\(.*\s\|\)\(readfile\|file_get_contents\|stream_get_contents\|show_source\|fopen\|file\|fpassthru\|gzopen\|gzfile\|gzpassthru\|readgzfile\)\(\s\|(\).*\$' --color
```
<!-- cheat -->

### Command execution sinks

Find command execution and eval-like sinks using variable input.

```sh title:"Find PHP command execution sinks"
grep -rn --include "*.php" -e '^\(.*\s\|\)\(eval\|popen\|pcntl_exec\|assert\|proc_open\|create_function\|call_user_func\|call_user_func_array\|exec\|shell_exec\|system\|passthru\|virtual\)([^)]*\$' --color
```
<!-- cheat -->

### Regex replace sinks

Find replacement functions using variable input.

```sh title:"Find PHP regex replace sinks"
grep -rn --include "*.php" -e '^\(.*\s\|\)\(preg_replace\|ereg_replace\|eregi_replace\|mb_ereg_replace\|mb_eregi_replace\)(.*\$' --color
```
<!-- cheat -->

### Unserialize

Find unserialize calls using variable input.

```sh title:"Find PHP unserialize calls"
grep -rn --include "*.php" -e '^\(.*\s\|\)unserialize(.*\$' --color
```
<!-- cheat -->

### LDAP

Find LDAP search calls using variable input.

```sh title:"Find PHP ldap_search calls"
grep -rn --include "*.php" -e '^\(.*\s\|\)ldap_search(.*\$' --color
```
<!-- cheat -->

### XPath

Find XPath use with variable input.

```sh title:"Find PHP XPath use"
grep -rn --include "*.php" -e '^\(.*\s\|\)xpath.*\$' --color
```
<!-- cheat -->

### Mail

Find mail calls using variable input.

```sh title:"Find PHP mail calls"
grep -rn --include "*.php" -e '^\(.*\s\|\)mail(.*\$' --color
```
<!-- cheat -->

### Output sinks

Find echo/print calls using variable input.

```sh title:"Find PHP output sinks"
grep -rn --include "*.php" -e '^\(.*\s\|\)\(echo\|printf\|print\)\(\s\|(\).*\$' --color
```
<!-- cheat -->

### Weak comparison

Find weak comparisons against variables or zero.

```sh title:"Find PHP weak comparisons"
grep -rn --include "*.php" -e '\(\$[^=]\|0\)\s*==\s*\(0\|\$[^=]\)' --color
```
<!-- cheat -->

### Entry points

Find common PHP superglobal entry points.

```sh title:"Find PHP superglobal entry points"
grep -rn --include "*.php" -e '\($_GET\|$_POST\|$_FILES\|$REQUEST\|$_COOKIES\|$_SESSION\|$_SERVER\|$_GLOBALS\)' --color
```
<!-- cheat -->

### Callbacks

Find callback-taking PHP functions using variable input.

```sh title:"Find PHP callback sinks"
grep -rn --include "*.php" -e '^\(.*\s\|\)\(ob_start\|array_diff_uassoc\|array_diff_ukey\|array_filter\|array_intersect_uassoc\|array_intersect_ukey\|array_map\|array_reduce\|array_udiff_assoc\|array_udiff_uassoc\|array_udiff\|array_uintersect_assoc\|array_uintersect_uassoc\|array_uintersect\|array_walk_recursive\|array_walk\|assert_options\|uasort\|uksort\|usort\|preg_replace_callback\|spl_autoload_register\|iterator_apply\|register_shutdown_function\|register_tick_function\|set_error_handler\|set_exception_handler\|session_set_save_handler\|sqlite_create_aggregate\|sqlite_create_function\)(.*\$' --color
```
<!-- cheat -->

### SQL-ish variable use

Find `where` or `query` lines using variable input.

```sh title:"Find PHP SQL-ish variable use"
grep -rni --include "*.php" -e '\(where\|query\).*\$'
```
<!-- cheat -->

## wrappers

### LFI base64 filter

Read a PHP file through the base64 filter wrapper.

```sh title:"Read PHP file through base64 filter wrapper"
curl "$url?$param=php://filter/read=convert.base64-encode/resource=$file.php"
```
<!-- cheat
var url
var param
var file
-->
