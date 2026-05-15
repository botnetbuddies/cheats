# BOF

## cyclic patterns

### Create pattern

Create a cyclic pattern with Metasploit.

```sh title:"Create cyclic pattern"
msf-pattern_create -l "$size"
```
<!-- cheat
var size
-->

### Find offset

Find the offset for a cyclic pattern value.

```sh title:"Find cyclic pattern offset"
msf-pattern_offset -l "$size" -q "$pattern"
```
<!-- cheat
var size
var pattern
-->

### NASM shell

Open Metasploit NASM shell for opcode lookup.

```sh title:"Open Metasploit NASM shell"
msf-nasm_shell
```
<!-- cheat -->

## ropgadget

### Gadgets

List ROP gadgets in a binary.

```sh title:"List ROP gadgets"
ROPgadget --binary "$binary"
```
<!-- cheat
var binary
-->

### ROP chain

Generate a ROP chain.

```sh title:"Generate ROP chain"
ROPgadget --binary "$binary" --ropchain
```
<!-- cheat
var binary
-->

### Opcode

Search for an opcode in executable segments.

```sh title:"Search opcode in executable segments"
ROPgadget --binary "$binary" --opcode "$opcode"
```
<!-- cheat
var binary
var opcode
-->

### String range

Search for a string between two addresses.

```sh title:"Search string between addresses"
ROPgadget --binary "$binary" --string "$string" --range "$start_address-$end_address"
```
<!-- cheat
var binary
var string
var start_address
var end_address
-->

### Only instructions

Show only specific instructions.

```sh title:"Show only specific instructions"
ROPgadget --binary "$binary" --only="$instructions"
```
<!-- cheat
var binary
var instructions
-->

## mona

### Modules

Show loaded modules and protections.

```sh title:"Mona loaded modules"
!mona modules
```
<!-- cheat -->

### Working folder

Set Mona working folder.

```sh title:"Set Mona working folder"
!mona config -set workingfolder "$path"
```
<!-- cheat
var path := c:\logs\%p
-->

### Pattern create

Create a Mona cyclic pattern.

```sh title:"Create Mona cyclic pattern"
!mona pc $pattern_size
```
<!-- cheat
var pattern_size := 400
-->

### Pattern offset

Find a cyclic pattern offset in Mona.

```sh title:"Find Mona cyclic pattern offset"
!mona po $pattern_value
```
<!-- cheat
var pattern_value := 41346541
-->

### Find JMP register

Find pointers that jump to a register, excluding null bytes.

```sh title:"Find JMP register pointers"
!mona jmp -r $register_name -n
```
<!-- cheat
var register_name := esp
-->

### Badchar bytearray

Create a bytearray excluding bad characters.

```sh title:"Create Mona badchar bytearray"
!mona bytearray -cpb "$excluded_bytes"
```
<!-- cheat
var excluded_bytes := '\x00\x0a\x0d'
-->

### Badchar compare

Compare memory against a Mona bytearray file.

```sh title:"Compare Mona badchar bytearray"
!mona compare -f "$input_file" -a "$bytearray_address"
```
<!-- cheat
var input_file := C:\BadChars\bytearray.bin
var bytearray_address := esp
-->

### SEH

Find SEH overwrite pointers.

```sh title:"Find SEH overwrite pointers"
!mona seh
```
<!-- cheat -->

### ROP

Find ROP gadgets with Mona.

```sh title:"Find Mona ROP gadgets"
!mona rop -cm aslr=false,rebase=false
```
<!-- cheat -->
