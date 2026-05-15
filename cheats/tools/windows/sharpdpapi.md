# SharpDPAPI

## dpapi

### Triage user vaults

Triage current user DPAPI vaults.

```cmd title:"Triage user DPAPI vaults"
SharpDPAPI.exe triage
```
<!-- cheat -->

### Machine credentials

Triage machine-level DPAPI credentials.

```cmd title:"Triage machine DPAPI credentials"
SharpDPAPI.exe machinetriage
```
<!-- cheat -->

### Decrypt with masterkey

Decrypt a DPAPI blob with a known masterkey.

```cmd title:"Decrypt DPAPI blob with masterkey"
SharpDPAPI.exe blob /target:"$blob_file" /mkfile:"$masterkey_file"
```
<!-- cheat
var blob_file
var masterkey_file
-->
