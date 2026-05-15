---
technique: NetworkShareSecrets
category: credential-dumping
targets: SMB Shares, File Shares, Workstations, Servers
protocols: SMB, LDAP
remote_capable: true
tags: credential-dumping network-shares smb files snaffler manspider powerview ad
---

# NetworkShareSecrets

Network shares often contain credentials in scripts, configuration files, logs, spreadsheets, and user documents. Share hunting focuses on finding sensitive strings and file types at scale before pulling only the evidence worth inspecting.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Share access | Domain user access is usually enough to find broadly readable files |
| Scope | Search by subnet, host list, domain computers, or a specific UNC path |
| Keywords | Start with credential-oriented strings such as `password`, `pwd`, `sqlplus`, `connectionString`, and `private` |

## Windows

### findstr XML/INI/TXT

#cmd #native #files

Search common text configuration files for password strings from the current directory.

```cmd title:"Search common text files for passwords with findstr"
findstr /snip password *.xml *.ini *.txt
```
<!-- cheat -->

### findstr all files

#cmd #native #files

Search all files below the current directory for password strings.

```cmd title:"Search all files for passwords with findstr"
findstr /snip password *
```
<!-- cheat -->

### PowerView recent files

#powershell #powerview #files

Find recently accessed interesting files with PowerView.

```powershell title:"Find recently accessed interesting files with PowerView"
Find-InterestingFile -LastAccessTime (Get-Date).AddDays(-7)
```
<!-- cheat -->

### PowerView keyword search

#powershell #powerview #files

Find files with sensitive keywords in their names using PowerView.

```powershell title:"Find keyword-matching files with PowerView"
Find-InterestingFile -Include "$keywords"
```
<!-- cheat
var keywords
-->

### PowerView Office documents

#powershell #powerview #files #office

Find Office documents on a specific share using PowerView.

```powershell title:"Find Office documents on share with PowerView"
Find-InterestingFile -Path "\\$server\$share" -OfficeDocs
```
<!-- cheat
var share
-->

### Snaffler domain

#powershell #snaffler #smb

Snaffle readable shares across the domain for credential-bearing files.

```powershell title:"Snaffle domain shares for secrets"
.\Snaffler.exe -d "$domain" -c -s
```
<!-- cheat
import domain_ip
-->

### Snaffler hosts

#powershell #snaffler #smb

Snaffle readable shares on a specific host list.

```powershell title:"Snaffle selected hosts for secrets"
.\Snaffler.exe -n "$hosts" -s
```
<!-- cheat
var hosts
-->

### Snaffler directory

#powershell #snaffler #files

Snaffle a specific local or mounted directory.

```powershell title:"Snaffle a specific directory for secrets"
.\Snaffler.exe -i "$path" -s
```
<!-- cheat
var path
-->

## Linux

### manspider content search

#python #smb #files

Search SMB shares across a subnet for credential-oriented content with manspider.

```sh title:"Search shares for credential content with manspider"
manspider.py --threads 50 "$subnet" -d "$domain" -u "$user" -p "$pass" --content "$keywords"
```
<!-- cheat
import domain_ip
import users
import passwords
var subnet
var keywords
-->

### manspider file name search

#python #smb #files

Search SMB shares across a subnet for sensitive file names with manspider.

```sh title:"Search shares for sensitive file names with manspider"
manspider.py --threads 50 "$subnet" -d "$domain" -u "$user" -p "$pass" --filename "$patterns"
```
<!-- cheat
import domain_ip
import users
import passwords
var subnet
var patterns
-->

### smbclient list shares

#smb #native #enum

List shares on a target before mounting or spidering manually.

```sh title:"List target SMB shares with smbclient"
smbclient -L "//$target" -U "$domain/$user%$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var target
-->

### grep mounted share

#bash #files #manual

Search a mounted share for password strings in common text files.

```sh title:"Search mounted share text files for passwords"
grep -RIni --include="*.txt" --include="*.ini" --include="*.xml" password "$mount_path"
```
<!-- cheat
var mount_path
-->
