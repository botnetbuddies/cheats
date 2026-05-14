# Uv

## uv

### install uv

Installs the `uv` Python package manager from Astral. Fast drop-in replacement for pip/pipx/venv, written in Rust. Required before any of the `uv tool install` commands below will work.

```sh title:"Install uv via astral shell script"
curl -LsSf https://astral.sh/uv/install.sh | sh
```
<!-- cheat -->

## uv - install tool

### impacket

Collection of Python classes for working with network protocols (SMB, MSRPC, Kerberos). Provides classic offensive tools like `secretsdump.py`, `psexec.py`, `wmiexec.py`, `GetNPUsers.py`, and `GetUserSPNs.py`. Fortra fork is the actively maintained one.

```sh title:"Install impacket suite (secretsdump, psexec, etc) from fortra fork"
uv tool install git+https://github.com/fortra/impacket.git
```
<!-- cheat -->

### netexec

Successor to CrackMapExec. Swiss-army knife for pentesting networks - sprays credentials, enumerates SMB/LDAP/WinRM/MSSQL/RDP/SSH/FTP, dumps secrets, and runs modules across hosts in parallel. Invoked as `nxc`.

```sh title:"Install NetExec (nxc), network pentesting swiss army knife"
uv tool install git+https://github.com/Pennyw0rth/NetExec
```
<!-- cheat -->

### bloodhound-ce-python

Python-based BloodHound ingestor. The `bloodhound-ce` branch targets BloodHound Community Edition (the newer Specter Ops rewrite) - use this instead of the legacy branch if your BloodHound server is CE.

```sh title:"Install BloodHound.py collector for BloodHound Community Edition"
uv tool install git+https://github.com/dirkjanm/BloodHound.py.git@bloodhound-ce
```
<!-- cheat -->

### bloodyAD

Active Directory privilege escalation framework that talks directly to LDAP/SAMR over the wire - no need to drop binaries on the target. Great for manipulating ACLs, changing passwords, and abusing delegation without touching Windows.

```sh title:"Install bloodyAD, Active Directory privesc framework (LDAP/SAMR)"
uv tool install git+https://github.com/CravateRouge/bloodyAD.git
```
<!-- cheat -->

### git-dumper

Reconstructs a full git repository from an exposed `.git/` directory on a webserver. Common web recon finding - run this against any site where `/.git/HEAD` returns 200 to pull source code, secrets, and history.

```sh title:"Install git-dumper, extracts .git directories from exposed web servers"
uv tool install git+https://github.com/arthaud/git-dumper.git
```
<!-- cheat -->

### certipy

AD Certificate Services (ADCS) enumeration and abuse. Finds vulnerable certificate templates (ESC1–ESC15), requests certs, performs Shadow Credentials attacks, and handles Pass-the-Cert authentication. Essential for any AD engagement with ADCS in scope.

```sh title:"Install Certipy, AD Certificate Services (ADCS) enum and abuse"
uv tool install git+https://github.com/ly4k/Certipy.git
```
<!-- cheat -->

### penelope

Shell handler that upgrades dumb reverse shells to fully interactive PTYs automatically. Handles tab completion, job control, and file transfer. A nicer alternative to `nc -lvnp` + manual `stty` dance.

```sh title:"Install Penelope shell handler, auto upgrades reverse shells to PTY"
uv tool install git+https://github.com/brightio/penelope.git
```
<!-- cheat -->

### responder

LLMNR, NBT-NS, and MDNS poisoner. Sits on a network segment and answers broadcast name-resolution requests to trick hosts into authenticating to you - captures NetNTLMv1/v2 hashes for offline cracking or relay.

```sh title:"Install Responder, LLMNR/NBT-NS/MDNS poisoner for hash capture"
uv tool install git+https://github.com/lgandx/Responder.git
```
<!-- cheat -->

### powerview.py

Python port of PowerSploit's PowerView. Interactive shell for Active Directory enumeration and abuse over LDAP/LDAPS/GC/ADWS - Kerberoasting, ASREPRoasting, ACL recon, RBCD/shadow-credentials staging, DNS edits, GPO inspection, and remote SMB/RPC operations without dropping anything on Windows.

```sh title:"Install powerview.py, interactive AD enumeration/abuse over LDAP"
uv tool install git+https://github.com/aniqfakhrul/powerview.py
```
<!-- cheat -->