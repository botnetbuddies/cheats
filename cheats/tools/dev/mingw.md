# MinGW

## compile

### Windows PE 32-bit

Compile a Windows 32-bit PE executable from C source on Linux.

```sh title:"MinGW Compile Windows 32-bit PE from C source"
i686-w64-mingw32-gcc "$source_c" -lws2_32 -o "$output_exe"
```
<!-- cheat
var source_c
var output_exe
-->
