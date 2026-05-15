---
tool: Rubeus
category: windows-tool
tags: windows tool rubeus kerberos tickets
---

# Rubeus

Rubeus operates on Kerberos tickets from Windows, including triage, dump, import, request, and renewal workflows.

## Windows

### Triage tickets

#cmd #rubeus #kerberos

List Kerberos tickets in current logon sessions.

```cmd title:"Triage Kerberos tickets"
Rubeus.exe triage
```
<!-- cheat -->

### Dump tickets

#cmd #rubeus #kerberos

Dump Kerberos tickets from accessible sessions.

```cmd title:"Dump Kerberos tickets"
Rubeus.exe dump
```
<!-- cheat -->

### Import ticket

#cmd #rubeus #kerberos

Import a base64 or kirbi Kerberos ticket.

```cmd title:"Import Kerberos ticket"
Rubeus.exe ptt /ticket:"$ticket_file"
```
<!-- cheat
var ticket_file
-->
