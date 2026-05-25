# Node.js

## grep

### Command execution

Find command execution with Node.js.

```sh title:"Node.js Find Command Execution"
grep -rn --include "*.js" -e '^\(.*\s\|.*child_process.*|\)\(exec\|spawn\|eval\|execSync\|spawnSync\|execFileSync\)(' --color
```
<!-- cheat -->

### Require

Find require with Node.js.

```sh title:"Node.js Find Require"
grep -rn --include "*.js" -e '^\(.*\s\|\)\(require\)(' --color
```
<!-- cheat -->

### File operations

Find file operations with Node.js.

```sh title:"Node.js Find File Operations"
grep -rn --include "*.js" -e '^\(.*\s\|\)\(appendFile\|open\|readFile\|writeFile\|unlink\|rename\|formidable\)(' --color
```
<!-- cheat -->
