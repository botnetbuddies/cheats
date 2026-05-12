# Node.js

## grep

### Command execution

Find command execution sinks in JavaScript files.

```sh title:"Find Node.js command execution sinks"
grep -rn --include "*.js" -e '^\(.*\s\|.*child_process.*|\)\(exec\|spawn\|eval\|execSync\|spawnSync\|execFileSync\)(' --color
```
<!-- cheat -->

### Require

Find require calls.

```sh title:"Find Node.js require calls"
grep -rn --include "*.js" -e '^\(.*\s\|\)\(require\)(' --color
```
<!-- cheat -->

### File operations

Find file operation calls in JavaScript files.

```sh title:"Find Node.js file operation calls"
grep -rn --include "*.js" -e '^\(.*\s\|\)\(appendFile\|open\|readFile\|writeFile\|unlink\|rename\|formidable\)(' --color
```
<!-- cheat -->
