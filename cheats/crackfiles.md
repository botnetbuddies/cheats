# Crack Files

## zip

### fcrackzip

Crack a ZIP file with fcrackzip.

```sh title:"Crack ZIP with fcrackzip"
fcrackzip -u -D -p "$wordlist" "$zip_file"
```
<!-- cheat
var wordlist
var zip_file
-->

### zip2john

Extract a ZIP hash and crack it with John.

```sh title:"Extract ZIP hash and crack with John"
zip2john "$zip_file" > zip.john; john zip.john
```
<!-- cheat
var zip_file
-->

## 7z

### 7z2john

Extract a 7z hash and crack it with John.

```sh title:"Extract 7z hash and crack with John"
7z2john "$archive_file" > 7z.john; john 7z.john
```
<!-- cheat
var archive_file
-->

## pdf

### pdfcrack

Crack a PDF password with pdfcrack.

```sh title:"Crack PDF with pdfcrack"
pdfcrack "$pdf_file" -w "$wordlist"
```
<!-- cheat
var pdf_file
var wordlist
-->

### qpdf decrypt

Decrypt a PDF with a known password.

```sh title:"Decrypt PDF with known password"
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

```sh title:"Extract Office hash and crack with John"
office2john "$office_file" > office.hash; john --wordlist "$wordlist" office.hash
```
<!-- cheat
var office_file
var wordlist
-->

## keepass

### keepass2john

Extract a KeePass database hash and crack it with John.

```sh title:"Extract KeePass hash and crack with John"
keepass2john "$kdbx_file" > keepass.hash; john --wordlist "$wordlist" keepass.hash
```
<!-- cheat
var kdbx_file
var wordlist
-->
