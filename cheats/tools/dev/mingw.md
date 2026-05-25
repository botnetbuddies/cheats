# MinGW

## compile

### Windows PE 32-bit

Run windows PE 32 bit with MinGW.

Compile a Windows 32-bit PE executable from C source on Linux.

```sh title:"MinGW Run Windows PE 32 Bit"
i686-w64-mingw32-gcc "$source_c" -lws2_32 -o "$output_exe"
```
<!-- cheat
var source_c
var output_exe
-->
