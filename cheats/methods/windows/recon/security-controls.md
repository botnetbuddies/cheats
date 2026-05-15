---
technique: Windows Security Controls Recon
category: recon
targets: Windows Workstation, Windows Server
protocols: Local
remote_capable: false
tags: windows recon security-controls audit-policy event-forwarding wdigest lsa credential-guard
---

# Windows Security Controls Recon

Security control recon checks local logging, forwarding, credential caching, LSA protection, and Credential Guard posture before choosing credential access or execution paths.

## Windows

### audit policy

```cmd title:"Read Audit policy registry to see what's being logged"
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit
```
<!-- cheat -->

### Windows Event Forwarding

```cmd title:"Check WEF SubscriptionManager for log-forwarding target"
reg query HKLM\Software\Policies\Microsoft\Windows\EventLog\EventForwarding\SubscriptionManager
```
<!-- cheat -->

### WDigest

```cmd title:"Check if WDigest is caching plaintext passwords in LSASS"
reg query 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest' /v UseLogonCredential
```
<!-- cheat -->

### LSA Protection

```cmd title:"Check RunAsPPL flag (LSA Protection) on this host"
reg query 'HKLM\SYSTEM\CurrentControlSet\Control\LSA' /v RunAsPPL
```
<!-- cheat -->

### Credential Guard

```cmd title:"Check LsaCfgFlags to see if Credential Guard is on"
reg query 'HKLM\System\CurrentControlSet\Control\LSA' /v LsaCfgFlags
```
<!-- cheat -->

### cached logons

```cmd title:"Read cached logon count from Winlogon registry"
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v CACHEDLOGONSCOUNT
```
<!-- cheat -->
