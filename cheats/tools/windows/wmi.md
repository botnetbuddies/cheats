# Wmi

## WMI

### Hotfix list

List installed hotfixes (patch level + KB ID + install date). Compare against public exploit DBs to find missing patches.

```sh title:"List installed hotfixes, compare against exploit DBs"
wmic qfe get Caption,Description,HotFixID,InstalledOn
```
<!-- cheat -->

### Computer system info

Hostname, domain, manufacturer, model, current user, roles. Quick host fingerprint.

```sh title:"Hostname, domain, model, current user, roles"
wmic computersystem get Name,Domain,Manufacturer,Model,Username,Roles /format:List
```
<!-- cheat -->

### Process list

List every running process. Spot security tools, AV agents, EDR drivers.

```sh title:"List running processes (spot AV/EDR drivers)"
wmic process list /format:list
```
<!-- cheat -->

### Domain info

Display the domain and DC info from the host's perspective.

```sh title:"Domain and DC info from host perspective"
wmic ntdomain list /format:list
```
<!-- cheat -->

### User accounts

List local user accounts plus any domain accounts that have logged in to this host.

```sh title:"Local + cached domain users that touched this host"
wmic useraccount list /format:list
```
<!-- cheat -->

### Local groups

List every local group on the host.

```sh title:"List every local group on the host"
wmic group list /format:list
```
<!-- cheat -->

### System accounts

List system / service accounts. Useful for spotting privileged service accounts.

```sh title:"System / service accounts (spot privileged services)"
wmic sysaccount list /format:list
```
<!-- cheat -->
