---
technique: WebClient Service
category: lateral-movement
targets: Windows WebClient
protocols: WebDAV, HTTP
remote_capable: false
tags: windows webclient webdav coercion relay sharpstartwebclient
---

# WebClient Service

The WebClient service enables WebDAV access from Windows. When it is running, coercion paths can force HTTP authentication to WebDAV-style UNC paths, which can support relay scenarios where SMB relay is blocked.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Installed service | Workstations commonly include WebClient. Servers often do not |
| Local execution | SharpStartWebclient runs on the current host |
| Relay listener | Prepare the HTTP relay or capture listener before triggering authentication |

## Windows

### Check WebClient service

#cmd #service

Check whether WebClient exists and its current state.

```cmd title:"Query WebClient service"
sc query WebClient
```
<!-- cheat -->

### Start WebClient service

#cmd #service

Start WebClient through native service control.

```cmd title:"Start WebClient service"
sc start WebClient
```
<!-- cheat -->

### Start WebClient with SharpStartWebclient

#powershell #sharpstartwebclient

Force the WebClient service to start through SharpStartWebclient.

```powershell title:"Start WebClient with SharpStartWebclient"
.\SharpStartWebclient.exe
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows-side WebClient service handling.
