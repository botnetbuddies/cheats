---
tool: SharpDPAPI
category: windows-tool
tags: windows tool sharpdpapi dpapi credentials
---

# SharpDPAPI

SharpDPAPI triages and decrypts DPAPI-protected Windows secrets when user, machine, or domain backup key material is available.

## Windows

### Triage user vaults

#cmd #sharpdpapi #dpapi

Triage current user DPAPI vaults.

```cmd title:"Triage user DPAPI vaults"
SharpDPAPI.exe triage
```
<!-- cheat -->

### Machine credentials

#cmd #sharpdpapi #dpapi

Triage machine-level DPAPI credentials.

```cmd title:"Triage machine DPAPI credentials"
SharpDPAPI.exe machinetriage
```
<!-- cheat -->

### Decrypt with masterkey

#cmd #sharpdpapi #dpapi

Decrypt a DPAPI blob with a known masterkey.

```cmd title:"Decrypt DPAPI blob with masterkey"
SharpDPAPI.exe blob /target:"$blob_file" /mkfile:"$masterkey_file"
```
<!-- cheat
var blob_file
var masterkey_file
-->
