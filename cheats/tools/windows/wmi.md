# Wmi

## WMI

### Hotfix list

List hotfix list with Wmi.

```sh title:"Wmi List Hotfix List"
wmic qfe get Caption,Description,HotFixID,InstalledOn
```
<!-- cheat -->

### Computer system info

Show computer system info with Wmi.

```sh title:"Wmi Show Computer System Info"
wmic computersystem get Name,Domain,Manufacturer,Model,Username,Roles /format:List
```
<!-- cheat -->

### Process list

List process list with Wmi.

```sh title:"Wmi List Process List"
wmic process list /format:list
```
<!-- cheat -->

### Domain info

Show domain info with Wmi.

```sh title:"Wmi Show Domain Info"
wmic ntdomain list /format:list
```
<!-- cheat -->

### User accounts

Run user accounts with Wmi.

```sh title:"Wmi Run User Accounts"
wmic useraccount list /format:list
```
<!-- cheat -->

### Local groups

List local groups with Wmi.

```sh title:"Wmi List Local Groups"
wmic group list /format:list
```
<!-- cheat -->

### System accounts

Run system accounts with Wmi.

```sh title:"Wmi Run System Accounts"
wmic sysaccount list /format:list
```
<!-- cheat -->
