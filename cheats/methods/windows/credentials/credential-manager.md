---
technique: Windows Credential Manager
category: credentials
targets: Windows Credential Manager
protocols: Local
remote_capable: false
tags: windows credentials credential-manager vault cmdkey
---

# Windows Credential Manager

Credential Manager stores saved Windows, generic, and web credentials that may be reusable for local movement or application access.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User context | Saved credentials are scoped to the current user |
| DPAPI access | Decryption depends on user context, master keys, or backup keys |

## Windows

### List saved credentials

#cmd #cmdkey #credentials

List saved Credential Manager entries.

```cmd title:"List saved Credential Manager entries"
cmdkey /list
```
<!-- cheat -->

### Add saved credential

#cmd #cmdkey #credentials

Add a saved credential for a target host.

```cmd title:"Add saved Windows credential"
cmdkey /add:"$rhost_name" /user:"$user" /pass:"$pass"
```
<!-- cheat
var rhost_name
var user
var pass
-->

### Delete saved credential

#cmd #cmdkey #cleanup

Delete a saved credential for a target host.

```cmd title:"Delete saved Windows credential"
cmdkey /delete:"$rhost_name"
```
<!-- cheat
var rhost_name
-->

### Vault cmdlets

#powershell #vault #credentials

List available vault cmdlets on the host.

```powershell title:"List vault cmdlets"
Get-Command *Vault*
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows Credential Manager.
