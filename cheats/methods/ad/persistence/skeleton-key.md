---
technique: Skeleton Key
category: persistence
targets: Domain Controllers (LSASS)
protocols: NTLM, Kerberos (RC4)
remote_capable: false
tags: persistence skeleton-key lsass mimikatz in-memory dc master-password kerberos ntlm
---

# Skeleton Key

Skeleton Key patches the LSASS process on a domain controller to install a master password (`mimikatz` by default). All domain users can still authenticate with their real credentials, but any account also accepts the master password. Because the patch is purely in-memory, it is lost on DC reboot. RC4-only Kerberos sessions and NTLM are supported; AES Kerberos is not.

## Windows

Mimikatz is the only known tool implementing this attack and must run on the DC with DA or SYSTEM privileges.

### Mimikatz (inject skeleton key)

#powershell #mimikatz #lsass #da-required

Inject the Skeleton Key master password into LSASS on the current DC session.

```powershell title:"Inject Skeleton Key into LSASS with Mimikatz"
mimikatz "privilege::debug" "misc::skeleton"
```
<!-- cheat -->

## Linux

Skeleton Key requires direct in-process memory patching of LSASS and cannot be performed from a Linux host.
