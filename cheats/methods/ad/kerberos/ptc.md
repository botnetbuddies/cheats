---
technique: Pass the Cache
category: kerberos
targets: Services, Domain Controllers
protocols: Kerberos
remote_capable: true
tags: kerberos pass-the-cache ptc ccache linux-tickets ticket-reuse ad
---

# Pass the Cache

Pass the Cache is the UNIX equivalent of Pass the Ticket. Kerberos tickets on Linux systems are stored in `.ccache` files (credential cache) rather than Windows memory. Stolen or forged `.ccache` files can be referenced via the `KRB5CCNAME` environment variable and used by any Kerberos-aware tool. The mechanics are identical to Pass the Ticket, the only difference is the ticket format and storage location.

## Linux

### KRB5CCNAME export

#bash #ccache

Reference a `.ccache` file so all Kerberos-aware tools in the shell use that ticket.

```sh title:"Export ccache path to use stolen or forged ticket"
export KRB5CCNAME="$ccache_file"
```
<!-- cheat
var ccache_file
-->

### ticketConverter.py (Windows to Linux)

#impacket #conversion

Convert a Windows `.kirbi` ticket to a Linux `.ccache` file for use with UNIX tools.

```sh title:"Convert kirbi to ccache for use on Linux"
ticketConverter.py "$kirbi_file" "$ccache_file"
```
<!-- cheat
var kirbi_file
var ccache_file
-->
