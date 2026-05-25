# Crack Files

<!-- cheat
export crackfiles
import wordlist_passwords
var archive_file = sh -c 'printf "%s\n" ""; find "$PWD/" -maxdepth 1 -type f ! -name ".*" -printf "%f\n" | sort' --- --header 'Current directory files'
-->

## zip

### fcrackzip

Crack fcrackzip with Crack Files.

```sh title:"Crack Files Crack Fcrackzip"
fcrackzip -u -D -p "$wordlists" "$zip_file"
```
<!-- cheat
import crackfiles
var zip_file
-->

### zip2john

Crack zip2john with Crack Files.

```sh title:"Crack Files Crack Zip2john"
zip2john "$zip_file" > zip.john; john --wordlist "$wordlists" zip.john
```
<!-- cheat
import crackfiles
var zip_file
-->

## 7z

### 7z2john

Crack 7z2john with Crack Files.

```sh title:"Crack Files Crack 7z2john"
7z2john "$archive_file" > 7z.john; john --wordlist "$wordlists" 7z.john
```
<!-- cheat
import crackfiles
-->

## pdf

### pdfcrack

Crack pdfcrack with Crack Files.

```sh title:"Crack Files Crack Pdfcrack"
pdfcrack "$pdf_file" -w "$wordlists"
```
<!-- cheat
import crackfiles
var pdf_file
-->

### qpdf decrypt

Dump qpdf decrypt with Crack Files.

```sh title:"Crack Files Dump Qpdf Decrypt"
qpdf --password="$pass" --decrypt "$encrypted_pdf" "$plaintext_pdf"
```
<!-- cheat
var pass
var encrypted_pdf
var plaintext_pdf
-->

## office

### office2john

Crack office2john with Crack Files.

```sh title:"Crack Files Crack Office2john"
office2john "$office_file" > office.hash; john --wordlist "$wordlists" office.hash
```
<!-- cheat
import crackfiles
var office_file
-->

## keepass

### keepass2john

Crack keepass2john with Crack Files.

```sh title:"Crack Files Crack Keepass2john"
keepass2john "$kdbx_file" > keepass.hash; john --wordlist "$wordlists" keepass.hash
```
<!-- cheat
import crackfiles
var kdbx_file
-->
