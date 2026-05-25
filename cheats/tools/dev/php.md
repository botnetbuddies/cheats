# PHP

## grep

### Include sinks

Find include sinks with PHP.

Find include/require calls using variable input.

```sh title:"PHP Find Include Sinks"
grep -rn --include "*.php" -e '^\(.*\s\|\)\(include\|require\|virtual\|require_once\|include_once\)\(\s\|(\).*\$' --color
```
<!-- cheat -->

### File read sinks

Read file read sinks with PHP.

Find file read functions using variable input.

```sh title:"PHP Read File Read Sinks"
grep -rn --include "*.php" -e '^\(.*\s\|\)\(readfile\|file_get_contents\|stream_get_contents\|show_source\|fopen\|file\|fpassthru\|gzopen\|gzfile\|gzpassthru\|readgzfile\)\(\s\|(\).*\$' --color
```
<!-- cheat -->

### Command execution sinks

Find command execution sinks with PHP.

Find command execution and eval-like sinks using variable input.

```sh title:"PHP Find Command Execution Sinks"
grep -rn --include "*.php" -e '^\(.*\s\|\)\(eval\|popen\|pcntl_exec\|assert\|proc_open\|create_function\|call_user_func\|call_user_func_array\|exec\|shell_exec\|system\|passthru\|virtual\)([^)]*\$' --color
```
<!-- cheat -->

### Regex replace sinks

Find regex replace sinks with PHP.

Find replacement functions using variable input.

```sh title:"PHP Find Regex Replace Sinks"
grep -rn --include "*.php" -e '^\(.*\s\|\)\(preg_replace\|ereg_replace\|eregi_replace\|mb_ereg_replace\|mb_eregi_replace\)(.*\$' --color
```
<!-- cheat -->

### Unserialize

Find unserialize with PHP.

Find unserialize calls using variable input.

```sh title:"PHP Find Unserialize"
grep -rn --include "*.php" -e '^\(.*\s\|\)unserialize(.*\$' --color
```
<!-- cheat -->

### LDAP

Find LDAP with PHP.

Find LDAP search calls using variable input.

```sh title:"PHP Find LDAP"
grep -rn --include "*.php" -e '^\(.*\s\|\)ldap_search(.*\$' --color
```
<!-- cheat -->

### XPath

Find XPath with PHP.

Find XPath use with variable input.

```sh title:"PHP Find XPath"
grep -rn --include "*.php" -e '^\(.*\s\|\)xpath.*\$' --color
```
<!-- cheat -->

### Mail

Find mail with PHP.

Find mail calls using variable input.

```sh title:"PHP Find Mail"
grep -rn --include "*.php" -e '^\(.*\s\|\)mail(.*\$' --color
```
<!-- cheat -->

### Output sinks

Find output sinks with PHP.

Find echo/print calls using variable input.

```sh title:"PHP Find Output Sinks"
grep -rn --include "*.php" -e '^\(.*\s\|\)\(echo\|printf\|print\)\(\s\|(\).*\$' --color
```
<!-- cheat -->

### Weak comparison

Find weak comparison with PHP.

Find weak comparisons against variables or zero.

```sh title:"PHP Find Weak Comparison"
grep -rn --include "*.php" -e '\(\$[^=]\|0\)\s*==\s*\(0\|\$[^=]\)' --color
```
<!-- cheat -->

### Entry points

Find entry points with PHP.

Find common PHP superglobal entry points.

```sh title:"PHP Find Entry Points"
grep -rn --include "*.php" -e '\($_GET\|$_POST\|$_FILES\|$REQUEST\|$_COOKIES\|$_SESSION\|$_SERVER\|$_GLOBALS\)' --color
```
<!-- cheat -->

### Callbacks

Find callbacks with PHP.

Find callback-taking PHP functions using variable input.

```sh title:"PHP Find Callbacks"
grep -rn --include "*.php" -e '^\(.*\s\|\)\(ob_start\|array_diff_uassoc\|array_diff_ukey\|array_filter\|array_intersect_uassoc\|array_intersect_ukey\|array_map\|array_reduce\|array_udiff_assoc\|array_udiff_uassoc\|array_udiff\|array_uintersect_assoc\|array_uintersect_uassoc\|array_uintersect\|array_walk_recursive\|array_walk\|assert_options\|uasort\|uksort\|usort\|preg_replace_callback\|spl_autoload_register\|iterator_apply\|register_shutdown_function\|register_tick_function\|set_error_handler\|set_exception_handler\|session_set_save_handler\|sqlite_create_aggregate\|sqlite_create_function\)(.*\$' --color
```
<!-- cheat -->

### SQL-ish variable use

Find SQL ish variable use with PHP.

Find `where` or `query` lines using variable input.

```sh title:"PHP Find SQL Ish Variable Use"
grep -rni --include "*.php" -e '\(where\|query\).*\$'
```
<!-- cheat -->

## wrappers

### LFI base64 filter

Read LFI base64 filter with PHP.

Read a PHP file through the base64 filter wrapper.

```sh title:"PHP Read LFI Base64 Filter"
curl "$url?$param=php://filter/read=convert.base64-encode/resource=$file.php"
```
<!-- cheat
var url
var param
var file
-->
