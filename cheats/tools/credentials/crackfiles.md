# Crack Files

<!-- cheat
export crackfiles
import wordlist_passwords
var archive_file = sh -c 'printf "%s\n" ""; find "$PWD/" -maxdepth 1 -type f ! -name ".*" -printf "%f\n" | sort' --- --header 'Current directory files'
-->

## zip

### fcrackzip

Crack a ZIP file with fcrackzip.

```sh title:"Crack Files Crack ZIP with fcrackzip"
fcrackzip -u -D -p "$wordlists" "$zip_file"
```
<!-- cheat
import crackfiles
var zip_file
-->

### zip2john

Extract a ZIP hash and crack it with John.

```sh title:"Crack Files Extract ZIP hash and crack with John"
zip2john "$zip_file" > zip.john; john --wordlist "$wordlists" zip.john
```
<!-- cheat
import crackfiles
var zip_file
-->

## 7z

### 7z2john

Extract a 7z hash and crack it with John.

```sh title:"Crack Files Extract 7z hash and crack with John"
7z2john "$archive_file" > 7z.john; john --wordlist "$wordlists" 7z.john
```
<!-- cheat
import crackfiles
-->

## pdf

### pdfcrack

Crack a PDF password with pdfcrack.

```sh title:"Crack Files Crack PDF with pdfcrack"
pdfcrack "$pdf_file" -w "$wordlists"
```
<!-- cheat
import crackfiles
var pdf_file
-->

### qpdf decrypt

Decrypt a PDF with a known password.

```sh title:"Crack Files Decrypt PDF with known password"
qpdf --password="$pass" --decrypt "$encrypted_pdf" "$plaintext_pdf"
```
<!-- cheat
var pass
var encrypted_pdf
var plaintext_pdf
-->

## office

### office2john

Extract an Office document hash and crack it with John.

```sh title:"Crack Files Extract Office hash and crack with John"
office2john "$office_file" > office.hash; john --wordlist "$wordlists" office.hash
```
<!-- cheat
import crackfiles
var office_file
-->

## keepass

### keepass2john

Extract a KeePass database hash and crack it with John.

```sh title:"Crack Files Extract KeePass hash and crack with John"
keepass2john "$kdbx_file" > keepass.hash; john --wordlist "$wordlists" keepass.hash
```
<!-- cheat
import crackfiles
var kdbx_file
-->
