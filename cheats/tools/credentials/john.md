# John

John the Ripper helper scripts (`*2john`) extract crackable hashes from various encrypted file formats. Output goes to `hash`, ready for `john hash` or `hashcat`.

<!-- cheat
export john
var hash_file = sh -c 'printf "%s\n" "hash"; find "$PWD/" -maxdepth 1 -type f ! -name ".*" -printf "%f\n" | grep -v "^$(basename "$PWD/")$" | sort' --- --header 'Current directory files'
import wordlist_passwords
-->

## Crack hashes

### LM

Crack LM hashes with John the Ripper.

```sh title:"John Crack LM Hashes"
john --wordlist="$wordlists" --format=lm "$hash_file"
```
<!-- cheat
import john
-->

### NTLM

Crack NTLM hashes with John the Ripper.

```sh title:"John Crack NTLM Hashes"
john --wordlist="$wordlists" --format=nt "$hash_file"
```
<!-- cheat
import john
-->

### NetNTLMv1

Crack NetNTLMv1 hashes with John the Ripper.

```sh title:"John Crack NetNTLMv1 Hashes"
john --wordlist="$wordlists" --format=netntlm "$hash_file"
```
<!-- cheat
import john
-->

### NetNTLMv2

Crack NetNTLMv2 hashes with John the Ripper.

```sh title:"John Crack NetNTLMv2 Hashes"
john --wordlist="$wordlists" --format=netntlmv2 "$hash_file"
```
<!-- cheat
import john
-->

### Raw MD5

Crack raw MD5 hashes with John the Ripper.

```sh title:"John Crack Raw MD5 Hashes"
john --wordlist="$wordlists" --format=raw-md5 "$hash_file"
```
<!-- cheat
import john
-->

## Auth & system hashes

### krb2john

Crack krb2john hashes with John the Ripper.

```sh title:"John Crack Krb2john Hashes"
krb2john $file > hash
```
<!-- cheat
var file
-->

### kdcdump2john

Crack kdcdump2john hashes with John the Ripper.

```sh title:"John Crack Kdcdump2john Hashes"
kdcdump2john $file > hash
```
<!-- cheat
var file
-->

### kirbi2john

Crack kirbi2john hashes with John the Ripper.

```sh title:"John Crack Kirbi2john Hashes"
kirbi2john $file > hash
```
<!-- cheat
var file
-->

### ccache2john

Crack ccache2john hashes with John the Ripper.

```sh title:"John Crack Ccache2john Hashes"
ccache2john $file > hash
```
<!-- cheat
var file
-->

### DPAPImk2john

Crack DPAPImk2john hashes with John the Ripper.

```sh title:"John Crack DPAPImk2john Hashes"
DPAPImk2john $file > hash
```
<!-- cheat
var file
-->

### htdigest2john

Crack htdigest2john hashes with John the Ripper.

```sh title:"John Crack Htdigest2john Hashes"
htdigest2john $file > hash
```
<!-- cheat
var file
-->

### radius2john

Crack radius2john hashes with John the Ripper.

```sh title:"John Crack Radius2john Hashes"
radius2john $file > hash
```
<!-- cheat
var file
-->

### sap2john

Crack sap2john hashes with John the Ripper.

```sh title:"John Crack Sap2john Hashes"
sap2john $file > hash
```
<!-- cheat
var file
-->

### racf2john

Crack racf2john hashes with John the Ripper.

```sh title:"John Crack Racf2john Hashes"
racf2john $file > hash
```
<!-- cheat
var file
-->

### cracf2john

Crack cracf2john hashes with John the Ripper.

```sh title:"John Crack Cracf2john Hashes"
cracf2john $file > hash
```
<!-- cheat
var file
-->

### aix2john

Crack aix2john hashes with John the Ripper.

```sh title:"John Crack Aix2john Hashes"
aix2john $file > hash
```
<!-- cheat
var file
-->

### uaf2john

Crack uaf2john hashes with John the Ripper.

```sh title:"John Crack Uaf2john Hashes"
uaf2john $file > hash
```
<!-- cheat
var file
-->

### sspr2john

Crack sspr2john hashes with John the Ripper.

```sh title:"John Crack Sspr2john Hashes"
sspr2john $file > hash
```
<!-- cheat
var file
-->

### ibmiscanner2john

Crack ibmiscanner2john hashes with John the Ripper.

```sh title:"John Crack Ibmiscanner2john Hashes"
ibmiscanner2john $file > hash
```
<!-- cheat
var file
-->

### ldif2john

Crack ldif2john hashes with John the Ripper.

```sh title:"John Crack Ldif2john Hashes"
ldif2john $file > hash
```
<!-- cheat
var file
-->

### ejabberd2john

Crack ejabberd2john hashes with John the Ripper.

```sh title:"John Crack Ejabberd2john Hashes"
ejabberd2john $file > hash
```
<!-- cheat
var file
-->

### prosody2john

Crack prosody2john hashes with John the Ripper.

```sh title:"John Crack Prosody2john Hashes"
prosody2john $file > hash
```
<!-- cheat
var file
-->

### mosquitto2john

Crack mosquitto2john hashes with John the Ripper.

```sh title:"John Crack Mosquitto2john Hashes"
mosquitto2john $file > hash
```
<!-- cheat
var file
-->

### mcafee_epo2john

Crack mcafee epo2john hashes with John the Ripper.

```sh title:"John Crack Mcafee Epo2john Hashes"
mcafee_epo2john $file > hash
```
<!-- cheat
var file
-->

### atmail2john

Crack atmail2john hashes with John the Ripper.

```sh title:"John Crack Atmail2john Hashes"
atmail2john $file > hash
```
<!-- cheat
var file
-->

### aruba2john

Crack aruba2john hashes with John the Ripper.

```sh title:"John Crack Aruba2john Hashes"
aruba2john $file > hash
```
<!-- cheat
var file
-->

### cisco2john

Crack cisco2john hashes with John the Ripper.

```sh title:"John Crack Cisco2john Hashes"
cisco2john $file > hash
```
<!-- cheat
var file
-->

### aem2john

Crack aem2john hashes with John the Ripper.

```sh title:"John Crack Aem2john Hashes"
aem2john $file > hash
```
<!-- cheat
var file
-->

### apex2john

Crack apex2john hashes with John the Ripper.

```sh title:"John Crack Apex2john Hashes"
apex2john $file > hash
```
<!-- cheat
var file
-->

### ps_token2john

Crack ps token2john hashes with John the Ripper.

```sh title:"John Crack Ps Token2john Hashes"
ps_token2john $file > hash
```
<!-- cheat
var file
-->

### pse2john

Crack pse2john hashes with John the Ripper.

```sh title:"John Crack Pse2john Hashes"
pse2john $file > hash
```
<!-- cheat
var file
-->

### sense2john

Crack sense2john hashes with John the Ripper.

```sh title:"John Crack Sense2john Hashes"
sense2john $file > hash
```
<!-- cheat
var file
-->

### adxcsouf2john

Crack adxcsouf2john hashes with John the Ripper.

```sh title:"John Crack Adxcsouf2john Hashes"
adxcsouf2john $file > hash
```
<!-- cheat
var file
-->

## Password managers

### 1password2john

Crack 1password2john hashes with John the Ripper.

```sh title:"John Crack 1password2john Hashes"
1password2john $file > hash
```
<!-- cheat
var file
-->

### bitwarden2john

Crack bitwarden2john hashes with John the Ripper.

```sh title:"John Crack Bitwarden2john Hashes"
bitwarden2john $file > hash
```
<!-- cheat
var file
-->

### dashlane2john

Crack dashlane2john hashes with John the Ripper.

```sh title:"John Crack Dashlane2john Hashes"
dashlane2john $file > hash
```
<!-- cheat
var file
-->

### enpass2john

Crack enpass2john hashes with John the Ripper.

```sh title:"John Crack Enpass2john Hashes"
enpass2john $file > hash
```
<!-- cheat
var file
-->

### keepass2john

Crack keepass2john hashes with John the Ripper.

```sh title:"John Crack Keepass2john Hashes"
keepass2john $file > hash
```
<!-- cheat
var file
-->

### kwallet2john

Crack kwallet2john hashes with John the Ripper.

```sh title:"John Crack Kwallet2john Hashes"
kwallet2john $file > hash
```
<!-- cheat
var file
-->

### keychain2john

Crack keychain2john hashes with John the Ripper.

```sh title:"John Crack Keychain2john Hashes"
keychain2john $file > hash
```
<!-- cheat
var file
-->

### keyring2john

Crack keyring2john hashes with John the Ripper.

```sh title:"John Crack Keyring2john Hashes"
keyring2john $file > hash
```
<!-- cheat
var file
-->

### lastpass2john

Crack lastpass2john hashes with John the Ripper.

```sh title:"John Crack Lastpass2john Hashes"
lastpass2john $file > hash
```
<!-- cheat
var file
-->

### padlock2john

Crack padlock2john hashes with John the Ripper.

```sh title:"John Crack Padlock2john Hashes"
padlock2john $file > hash
```
<!-- cheat
var file
-->

### pwsafe2john

Crack pwsafe2john hashes with John the Ripper.

```sh title:"John Crack Pwsafe2john Hashes"
pwsafe2john $file > hash
```
<!-- cheat
var file
-->

### mozilla2john

Crack mozilla2john hashes with John the Ripper.

```sh title:"John Crack Mozilla2john Hashes"
mozilla2john $file > hash
```
<!-- cheat
var file
-->

### applenotes2john

Crack applenotes2john hashes with John the Ripper.

```sh title:"John Crack Applenotes2john Hashes"
applenotes2john $file > hash
```
<!-- cheat
var file
-->

## Disk & volume encryption

### bitlocker2john

Crack bitlocker2john hashes with John the Ripper.

```sh title:"John Crack Bitlocker2john Hashes"
bitlocker2john $file > hash
```
<!-- cheat
var file
-->

### luks2john

Crack luks2john hashes with John the Ripper.

```sh title:"John Crack Luks2john Hashes"
luks2john $file > hash
```
<!-- cheat
var file
-->

### truecrypt2john

Crack truecrypt2john hashes with John the Ripper.

```sh title:"John Crack Truecrypt2john Hashes"
truecrypt2john $file > hash
```
<!-- cheat
var file
-->

### diskcryptor2john

Crack diskcryptor2john hashes with John the Ripper.

```sh title:"John Crack Diskcryptor2john Hashes"
diskcryptor2john $file > hash
```
<!-- cheat
var file
-->

### bestcrypt2john

Crack bestcrypt2john hashes with John the Ripper.

```sh title:"John Crack Bestcrypt2john Hashes"
bestcrypt2john $file > hash
```
<!-- cheat
var file
-->

### encfs2john

Crack encfs2john hashes with John the Ripper.

```sh title:"John Crack Encfs2john Hashes"
encfs2john $file > hash
```
<!-- cheat
var file
-->

### ecryptfs2john

Crack ecryptfs2john hashes with John the Ripper.

```sh title:"John Crack Ecryptfs2john Hashes"
ecryptfs2john $file > hash
```
<!-- cheat
var file
-->

### geli2john

Crack geli2john hashes with John the Ripper.

```sh title:"John Crack Geli2john Hashes"
geli2john $file > hash
```
<!-- cheat
var file
-->

### openbsd_softraid2john

Crack openbsd softraid2john hashes with John the Ripper.

```sh title:"John Crack Openbsd Softraid2john Hashes"
openbsd_softraid2john $file > hash
```
<!-- cheat
var file
-->

### androidfde2john

Crack androidfde2john hashes with John the Ripper.

```sh title:"John Crack Androidfde2john Hashes"
androidfde2john $file > hash
```
<!-- cheat
var file
-->

### dmg2john

Crack dmg2john hashes with John the Ripper.

```sh title:"John Crack Dmg2john Hashes"
dmg2john $file > hash
```
<!-- cheat
var file
-->

### vdi2john

Crack vdi2john hashes with John the Ripper.

```sh title:"John Crack Vdi2john Hashes"
vdi2john $file > hash
```
<!-- cheat
var file
-->

### vmx2john

Crack vmx2john hashes with John the Ripper.

```sh title:"John Crack Vmx2john Hashes"
vmx2john $file > hash
```
<!-- cheat
var file
-->

### pgpdisk2john

Crack pgpdisk2john hashes with John the Ripper.

```sh title:"John Crack Pgpdisk2john Hashes"
pgpdisk2john $file > hash
```
<!-- cheat
var file
-->

### pgpwde2john

Crack pgpwde2john hashes with John the Ripper.

```sh title:"John Crack Pgpwde2john Hashes"
pgpwde2john $file > hash
```
<!-- cheat
var file
-->

### pgpsda2john

Crack pgpsda2john hashes with John the Ripper.

```sh title:"John Crack Pgpsda2john Hashes"
pgpsda2john $file > hash
```
<!-- cheat
var file
-->

## Archives

### zip2john

Crack zip2john hashes with John the Ripper.

```sh title:"John Crack Zip2john Hashes"
zip2john $file > hash
```
<!-- cheat
var file
-->

### rar2john

Crack rar2john hashes with John the Ripper.

```sh title:"John Crack Rar2john Hashes"
rar2john $file > hash
```
<!-- cheat
var file
-->

### 7z2john

Crack 7z2john hashes with John the Ripper.

```sh title:"John Crack 7z2john Hashes"
7z2john $file > hash
```
<!-- cheat
var file
-->

### androidbackup2john

Crack androidbackup2john hashes with John the Ripper.

```sh title:"John Crack Androidbackup2john Hashes"
androidbackup2john $file > hash
```
<!-- cheat
var file
-->

### itunes_backup2john

Crack itunes backup2john hashes with John the Ripper.

```sh title:"John Crack Itunes Backup2john Hashes"
itunes_backup2john $file > hash
```
<!-- cheat
var file
-->

### restic2john

Crack restic2john hashes with John the Ripper.

```sh title:"John Crack Restic2john Hashes"
restic2john $file > hash
```
<!-- cheat
var file
-->

## Documents

### pdf2john

Crack pdf2john hashes with John the Ripper.

```sh title:"John Crack Pdf2john Hashes"
pdf2john $file > hash
```
<!-- cheat
var file
-->

### office2john

Crack office2john hashes with John the Ripper.

```sh title:"John Crack Office2john Hashes"
office2john $file > hash
```
<!-- cheat
var file
-->

### libreoffice2john

Crack libreoffice2john hashes with John the Ripper.

```sh title:"John Crack Libreoffice2john Hashes"
libreoffice2john $file > hash
```
<!-- cheat
var file
-->

### staroffice2john

Crack staroffice2john hashes with John the Ripper.

```sh title:"John Crack Staroffice2john Hashes"
staroffice2john $file > hash
```
<!-- cheat
var file
-->

### iwork2john

Crack iwork2john hashes with John the Ripper.

```sh title:"John Crack Iwork2john Hashes"
iwork2john $file > hash
```
<!-- cheat
var file
-->

### lotus2john

Crack lotus2john hashes with John the Ripper.

```sh title:"John Crack Lotus2john Hashes"
lotus2john $file > hash
```
<!-- cheat
var file
-->

### money2john

Crack money2john hashes with John the Ripper.

```sh title:"John Crack Money2john Hashes"
money2john $file > hash
```
<!-- cheat
var file
-->

### lion2john

Crack lion2john hashes with John the Ripper.

```sh title:"John Crack Lion2john Hashes"
lion2john $file > hash
```
<!-- cheat
var file
-->

### mac2john

Crack mac2john hashes with John the Ripper.

```sh title:"John Crack Mac2john Hashes"
mac2john $file > hash
```
<!-- cheat
var file
-->

## Crypto wallets

### bitcoin2john

Crack bitcoin2john hashes with John the Ripper.

```sh title:"John Crack Bitcoin2john Hashes"
bitcoin2john $file > hash
```
<!-- cheat
var file
-->

### bitshares2john

Crack bitshares2john hashes with John the Ripper.

```sh title:"John Crack Bitshares2john Hashes"
bitshares2john $file > hash
```
<!-- cheat
var file
-->

### blockchain2john

Crack blockchain2john hashes with John the Ripper.

```sh title:"John Crack Blockchain2john Hashes"
blockchain2john $file > hash
```
<!-- cheat
var file
-->

### electrum2john

Crack electrum2john hashes with John the Ripper.

```sh title:"John Crack Electrum2john Hashes"
electrum2john $file > hash
```
<!-- cheat
var file
-->

### ethereum2john

Crack ethereum2john hashes with John the Ripper.

```sh title:"John Crack Ethereum2john Hashes"
ethereum2john $file > hash
```
<!-- cheat
var file
-->

### monero2john

Crack monero2john hashes with John the Ripper.

```sh title:"John Crack Monero2john Hashes"
monero2john $file > hash
```
<!-- cheat
var file
-->

### multibit2john

Crack multibit2john hashes with John the Ripper.

```sh title:"John Crack Multibit2john Hashes"
multibit2john $file > hash
```
<!-- cheat
var file
-->

### tezos2john

Crack tezos2john hashes with John the Ripper.

```sh title:"John Crack Tezos2john Hashes"
tezos2john $file > hash
```
<!-- cheat
var file
-->

### neo2john

Crack neo2john hashes with John the Ripper.

```sh title:"John Crack Neo2john Hashes"
neo2john $file > hash
```
<!-- cheat
var file
-->

## Network captures

### pcap2john

Crack pcap2john hashes with John the Ripper.

```sh title:"John Crack Pcap2john Hashes"
pcap2john $file > hash
```
<!-- cheat
var file
-->

### hccap2john

Crack hccap2john hashes with John the Ripper.

```sh title:"John Crack Hccap2john Hashes"
hccap2john $file > hash
```
<!-- cheat
var file
-->

### hccapx2john

Crack hccapx2john hashes with John the Ripper.

```sh title:"John Crack Hccapx2john Hashes"
hccapx2john $file > hash
```
<!-- cheat
var file
-->

### wpapcap2john

Crack wpapcap2john hashes with John the Ripper.

```sh title:"John Crack Wpapcap2john Hashes"
wpapcap2john $file > hash
```
<!-- cheat
var file
-->

### vncpcap2john

Crack vncpcap2john hashes with John the Ripper.

```sh title:"John Crack Vncpcap2john Hashes"
vncpcap2john $file > hash
```
<!-- cheat
var file
-->

### sipdump2john

Crack sipdump2john hashes with John the Ripper.

```sh title:"John Crack Sipdump2john Hashes"
sipdump2john $file > hash
```
<!-- cheat
var file
-->

### ikescan2john

Crack ikescan2john hashes with John the Ripper.

```sh title:"John Crack Ikescan2john Hashes"
ikescan2john $file > hash
```
<!-- cheat
var file
-->

### known_hosts2john

Crack known hosts2john hashes with John the Ripper.

```sh title:"John Crack Known Hosts2john Hashes"
known_hosts2john $file > hash
```
<!-- cheat
var file
-->

## Keys, certs & crypto

### ssh2john

Crack ssh2john hashes with John the Ripper.

```sh title:"John Crack Ssh2john Hashes"
ssh2john $file > hash
```
<!-- cheat
var file
-->

### putty2john

Crack putty2john hashes with John the Ripper.

```sh title:"John Crack Putty2john Hashes"
putty2john $file > hash
```
<!-- cheat
var file
-->

### gpg2john

Crack gpg2john hashes with John the Ripper.

```sh title:"John Crack Gpg2john Hashes"
gpg2john $file > hash
```
<!-- cheat
var file
-->

### pem2john

Crack pem2john hashes with John the Ripper.

```sh title:"John Crack Pem2john Hashes"
pem2john $file > hash
```
<!-- cheat
var file
-->

### pfx2john

Crack pfx2john hashes with John the Ripper.

```sh title:"John Crack Pfx2john Hashes"
pfx2john $file > hash
```
<!-- cheat
var file
-->

### openssl2john

Crack openssl2john hashes with John the Ripper.

```sh title:"John Crack Openssl2john Hashes"
openssl2john $file > hash
```
<!-- cheat
var file
-->

### keystore2john

Crack keystore2john hashes with John the Ripper.

```sh title:"John Crack Keystore2john Hashes"
keystore2john $file > hash
```
<!-- cheat
var file
-->

### bks2john

Crack bks2john hashes with John the Ripper.

```sh title:"John Crack Bks2john Hashes"
bks2john $file > hash
```
<!-- cheat
var file
-->

### axcrypt2john

Crack axcrypt2john hashes with John the Ripper.

```sh title:"John Crack Axcrypt2john Hashes"
axcrypt2john $file > hash
```
<!-- cheat
var file
-->

### zed2john

Crack zed2john hashes with John the Ripper.

```sh title:"John Crack Zed2john Hashes"
zed2john $file > hash
```
<!-- cheat
var file
-->

## Apps & misc

### ansible2john

Crack ansible2john hashes with John the Ripper.

```sh title:"John Crack Ansible2john Hashes"
ansible2john $file > hash
```
<!-- cheat
var file
-->

### filezilla2john

Crack filezilla2john hashes with John the Ripper.

```sh title:"John Crack Filezilla2john Hashes"
filezilla2john $file > hash
```
<!-- cheat
var file
-->

### deepsound2john

Crack deepsound2john hashes with John the Ripper.

```sh title:"John Crack Deepsound2john Hashes"
deepsound2john $file > hash
```
<!-- cheat
var file
-->

### strip2john

Crack strip2john hashes with John the Ripper.

```sh title:"John Crack Strip2john Hashes"
strip2john $file > hash
```
<!-- cheat
var file
-->

### signal2john

Crack signal2john hashes with John the Ripper.

```sh title:"John Crack Signal2john Hashes"
signal2john $file > hash
```
<!-- cheat
var file
-->

### telegram2john

Crack telegram2john hashes with John the Ripper.

```sh title:"John Crack Telegram2john Hashes"
telegram2john $file > hash
```
<!-- cheat
var file
-->

### andotp2john

Crack andotp2john hashes with John the Ripper.

```sh title:"John Crack Andotp2john Hashes"
andotp2john $file > hash
```
<!-- cheat
var file
-->
