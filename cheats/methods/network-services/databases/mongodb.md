---
technique: MongoDB Enumeration
category: databases
targets: MongoDB
protocols: MongoDB
remote_capable: true
tags: network-services mongodb database
---

# MongoDB Enumeration

MongoDB enumeration checks server metadata, authentication requirements, visible databases, collections, and weak default exposure.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 27017 | Requires MongoDB reachability |
| Credentials | Some deployments expose unauthenticated reads |
| Shell | Commands assume mongo or mongosh client syntax |

## Linux

### Nmap enum

#sh #nmap #mongodb

Run default MongoDB nmap scripts.

```sh title:"Run MongoDB nmap enumeration scripts"
nmap -sV --script "mongo* and default" -p "$rport" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 27017
-->

### Connect host

#sh #mongosh #mongodb

Connect to MongoDB.

```sh title:"Connect to MongoDB"
mongosh "mongodb://$rhost_ip:$rport"
```
<!-- cheat
var rhost_ip
var rport := 27017
-->

### Connect database

#sh #mongosh #mongodb

Connect to a MongoDB database with credentials.

```sh title:"Connect to MongoDB database"
mongosh "mongodb://$user:$pass@$rhost_ip:$rport/$database"
```
<!-- cheat
var user
var pass
var rhost_ip
var rport := 27017
var database
-->

### Server status

#sh #mongosh #mongodb

Read MongoDB server status.

```sh title:"Read MongoDB server status"
mongosh "mongodb://$rhost_ip:$rport/admin" --eval "db.runCommand({serverStatus:1})"
```
<!-- cheat
var rhost_ip
var rport := 27017
-->

### List databases

#sh #mongosh #mongodb

List MongoDB databases.

```sh title:"List MongoDB databases"
mongosh "mongodb://$rhost_ip:$rport/admin" --eval "db.adminCommand({listDatabases:1})"
```
<!-- cheat
var rhost_ip
var rport := 27017
-->
