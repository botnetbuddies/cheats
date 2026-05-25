# SharpDPAPI

## dpapi

### Triage user vaults

Run triage user vaults with SharpDPAPI.

Triage current user DPAPI vaults.

```cmd title:"SharpDPAPI Run Triage User Vaults"
SharpDPAPI.exe triage
```
<!-- cheat -->

### Machine credentials

Dump machine credentials with SharpDPAPI.

Triage machine-level DPAPI credentials.

```cmd title:"SharpDPAPI Dump Machine Credentials"
SharpDPAPI.exe machinetriage
```
<!-- cheat -->

### Decrypt with masterkey

Run decrypt with masterkey with SharpDPAPI.

Decrypt a DPAPI blob with a known masterkey.

```cmd title:"SharpDPAPI Run Decrypt with Masterkey"
SharpDPAPI.exe blob /target:"$blob_file" /mkfile:"$masterkey_file"
```
<!-- cheat
var blob_file
var masterkey_file
-->
