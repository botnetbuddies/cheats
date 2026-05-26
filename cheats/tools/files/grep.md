# Grep

## search

### Basic search

Search for text in a file.

```sh title:"Grep Search for text in file"
grep "$pattern" "$file"
```
<!-- cheat
var pattern
var file
-->

### Case insensitive

Search for text without matching case.

```sh title:"Grep Case-insensitive search in file"
grep -i "$pattern" "$file"
```
<!-- cheat
var pattern
var file
-->

### Show filename

Search and always print the filename for each match.

```sh title:"Grep Search and print matching filename"
grep -H "$pattern" "$file"
```
<!-- cheat
var pattern
var file
-->

### Recursive extension

Recursively search only files with a chosen extension.

```sh title:"Grep Recursive search by file extension"
grep -rn --include "*.$extension" "$pattern" .
```
<!-- cheat
var extension
var pattern
-->

### Either pattern

Search for either of two patterns.

```sh title:"Grep Search for either of two patterns"
grep -E "$pattern_a|$pattern_b" "$file"
```
<!-- cheat
var pattern_a
var pattern_b
var file
-->

## extract hashes

### MD5

Extract 32-character hex hashes from text files.

```sh title:"Grep Extract MD5-like hashes from txt files"
grep -hEo '(^|[^a-fA-F0-9])[a-fA-F0-9]{32}([^a-fA-F0-9]|$)' *.txt | grep -Eo '[a-fA-F0-9]{32}' > md5-hashes.txt
```
<!-- cheat -->

### SHA1

Extract 40-character hex hashes from text files.

```sh title:"Grep Extract SHA1-like hashes from txt files"
grep -hEo '(^|[^a-fA-F0-9])[a-fA-F0-9]{40}([^a-fA-F0-9]|$)' *.txt | grep -Eo '[a-fA-F0-9]{40}' > sha1-hashes.txt
```
<!-- cheat -->

### SHA256

Extract 64-character hex hashes from text files.

```sh title:"Grep Extract SHA256-like hashes from txt files"
grep -hEo '(^|[^a-fA-F0-9])[a-fA-F0-9]{64}([^a-fA-F0-9]|$)' *.txt | grep -Eo '[a-fA-F0-9]{64}' > sha256-hashes.txt
```
<!-- cheat -->

### SHA512

Extract 128-character hex hashes from text files.

```sh title:"Grep Extract SHA512-like hashes from txt files"
grep -hEo '(^|[^a-fA-F0-9])[a-fA-F0-9]{128}([^a-fA-F0-9]|$)' *.txt | grep -Eo '[a-fA-F0-9]{128}' > sha512-hashes.txt
```
<!-- cheat -->

### MySQL old

Extract old MySQL password hashes from text files.

```sh title:"Grep Extract old MySQL hashes from txt files"
grep -hEo '[0-7][0-9a-f]{7}[0-7][0-9a-f]{7}' *.txt > mysql-old-hashes.txt
```
<!-- cheat -->

### Blowfish

Extract bcrypt or Blowfish-style hashes from text files.

```sh title:"Grep Extract bcrypt/Blowfish hashes from txt files"
grep -hEo '\$2[aby]\$[0-9]{2}\$[./A-Za-z0-9]{53}' *.txt > blowfish-hashes.txt
```
<!-- cheat -->

### Joomla

Extract Joomla-style MD5 hash and salt pairs from text files.

```sh title:"Grep Extract Joomla hash:salt pairs from txt files"
grep -hEo '[0-9A-Za-z]{32}:[0-9A-Za-z]{16,32}' *.txt > joomla-hashes.txt
```
<!-- cheat -->

### vBulletin

Extract vBulletin-style MD5 hash and salt pairs from text files.

```sh title:"Grep Extract vBulletin hash:salt pairs from txt files"
grep -hEo '[0-9A-Za-z]{32}:.{3,32}' *.txt > vbulletin-hashes.txt
```
<!-- cheat -->

### phpBB3

Extract phpBB3 MD5 hashes from text files.

```sh title:"Grep Extract phpBB3 MD5 hashes from txt files"
grep -hEo '\$H\$[./A-Za-z0-9]{31}' *.txt > phpbb3-md5.txt
```
<!-- cheat -->

### WordPress

Extract WordPress MD5 hashes from text files.

```sh title:"Grep Extract WordPress MD5 hashes from txt files"
grep -hEo '\$P\$[./A-Za-z0-9]{31}' *.txt > wordpress-md5.txt
```
<!-- cheat -->

### Drupal 7

Extract Drupal 7 hashes from text files.

```sh title:"Grep Extract Drupal 7 hashes from txt files"
grep -hEo '\$S\$[./A-Za-z0-9]{52}' *.txt > drupal-7.txt
```
<!-- cheat -->

### Unix MD5

Extract old Unix MD5 crypt hashes from text files.

```sh title:"Grep Extract Unix MD5 crypt hashes from txt files"
grep -hEo '\$1\$[./A-Za-z0-9]{8}\$[./A-Za-z0-9]{22}' *.txt > md5-unix-old.txt
```
<!-- cheat -->

### Apache apr1

Extract Apache apr1 MD5 hashes from text files.

```sh title:"Grep Extract Apache apr1 MD5 hashes from txt files"
grep -hEo '\$apr1\$[./A-Za-z0-9]{8}\$[./A-Za-z0-9]{22}' *.txt > md5-apr1.txt
```
<!-- cheat -->

### sha512crypt

Extract Unix SHA512 crypt hashes from text files.

```sh title:"Grep Extract Unix SHA512 crypt hashes from txt files"
grep -hEo '\$6\$[./A-Za-z0-9]{1,16}\$[./A-Za-z0-9]{86}' *.txt > sha512crypt.txt
```
<!-- cheat -->

## extract text

### Emails

Extract email addresses from a file.

```sh title:"Grep Extract email addresses from file"
grep -Eo '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' "$file"
```
<!-- cheat
var file
-->

### IPv4 addresses

Extract valid IPv4 addresses from a file.

```sh title:"Grep Extract IPv4 addresses from file"
grep -Eo '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}' "$file"
```
<!-- cheat
var file
-->

### Password words

Search for common password-related words.

```sh title:"Grep Search password-related terms"
grep -iE 'pwd|passw|password|passwd' "$file"
```
<!-- cheat
var file
-->

### Login words

Search for common user and login-related words.

```sh title:"Grep Search user/login-related terms"
grep -iE 'user|invalid|authentication|login' "$file"
```
<!-- cheat
var file
-->

### HTTP URLs

Extract HTTP and HTTPS URLs from a file.

```sh title:"Grep Extract HTTP URLs from file"
grep -Eo 'https?://[^" >]+' "$file" > http-urls.txt
```
<!-- cheat
var file
-->
