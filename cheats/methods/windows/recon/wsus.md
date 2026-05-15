---
technique: Windows WSUS Recon
category: recon
targets: Windows Workstation, Windows Server
protocols: Local
remote_capable: false
tags: windows recon wsus windows-update registry
---

# Windows WSUS Recon

WSUS recon checks whether a host is configured to receive updates from an internal WSUS server. This can identify update infrastructure and help assess whether WSUS abuse or spoofing paths are relevant.

## Windows

### WSUS server (cmd)

```cmd title:"Read configured WSUS server URL from registry"
reg query HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate /v WUServer
```
<!-- cheat -->

### WSUS server (powershell)

```powershell title:"Read WSUS server URL via Get-ItemProperty"
Get-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate -Name "WUServer"
```
<!-- cheat -->
