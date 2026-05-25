# Wmi

## WMI

### Hotfix list

List hotfix list with Wmi.

List installed hotfixes (patch level + KB ID + install date). Compare against public exploit DBs to find missing patches.

```sh title:"Wmi List Hotfix List"
wmic qfe get Caption,Description,HotFixID,InstalledOn
```
<!-- cheat -->

### Computer system info

Show computer system info with Wmi.

Hostname, domain, manufacturer, model, current user, roles. Quick host fingerprint.

```sh title:"Wmi Show Computer System Info"
wmic computersystem get Name,Domain,Manufacturer,Model,Username,Roles /format:List
```
<!-- cheat -->

### Process list

List process list with Wmi.

List every running process. Spot security tools, AV agents, EDR drivers.

```sh title:"Wmi List Process List"
wmic process list /format:list
```
<!-- cheat -->

### Domain info

Show domain info with Wmi.

Display the domain and DC info from the host's perspective.

```sh title:"Wmi Show Domain Info"
wmic ntdomain list /format:list
```
<!-- cheat -->

### User accounts

Run user accounts with Wmi.

List local user accounts plus any domain accounts that have logged in to this host.

```sh title:"Wmi Run User Accounts"
wmic useraccount list /format:list
```
<!-- cheat -->

### Local groups

List local groups with Wmi.

List every local group on the host.

```sh title:"Wmi List Local Groups"
wmic group list /format:list
```
<!-- cheat -->

### System accounts

Run system accounts with Wmi.

List system / service accounts. Useful for spotting privileged service accounts.

```sh title:"Wmi Run System Accounts"
wmic sysaccount list /format:list
```
<!-- cheat -->
