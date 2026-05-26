# John

John the Ripper helper scripts (`*2john`) extract crackable hashes from various encrypted file formats. Output goes to `hash`, ready for `john hash` or `hashcat`.

<!-- cheat
export john
var hash_file = sh -c 'printf "%s\n" "hash"; find "$PWD/" -maxdepth 1 -type f ! -name ".*" -printf "%f\n" | grep -v "^$(basename "$PWD/")$" | sort' --- --header 'Current directory files'
import wordlist_passwords
-->

## Crack hashes

### LM

Crack LM hashes with John

```sh title:"Crack LM hashes with John"
john --wordlist="$wordlists" --format=lm "$hash_file"
```
<!-- cheat
import john
-->

### NTLM

Crack NTLM hashes with John

```sh title:"Crack NTLM hashes with John"
john --wordlist="$wordlists" --format=nt "$hash_file"
```
<!-- cheat
import john
-->

### NetNTLMv1

Crack NetNTLMv1 hashes with John

```sh title:"Crack NetNTLMv1 hashes with John"
john --wordlist="$wordlists" --format=netntlm "$hash_file"
```
<!-- cheat
import john
-->

### NetNTLMv2

Crack NetNTLMv2 hashes with John

```sh title:"Crack NetNTLMv2 hashes with John"
john --wordlist="$wordlists" --format=netntlmv2 "$hash_file"
```
<!-- cheat
import john
-->

### Raw MD5

Crack raw MD5 hashes with John

```sh title:"Crack raw MD5 hashes with John"
john --wordlist="$wordlists" --format=raw-md5 "$hash_file"
```
<!-- cheat
import john
-->

## Auth & system hashes

### krb2john

Extract crackable hash from a Kerberos .keytab / krb5cc

```sh title:"John Extract crackable hash from a Kerberos .keytab / krb5cc"
krb2john $file > hash
```
<!-- cheat
var file
-->

### kdcdump2john

Extract hashes from an Active Directory KDC .dump file

```sh title:"John Extract hashes from an Active Directory KDC .dump file"
kdcdump2john $file > hash
```
<!-- cheat
var file
-->

### kirbi2john

Extract crackable hash from a Rubeus .kirbi Kerberos ticket

```sh title:"John Extract crackable hash from a Rubeus .kirbi Kerberos ticket"
kirbi2john $file > hash
```
<!-- cheat
var file
-->

### ccache2john

Extract crackable hash from an MIT Kerberos credential cache (ccache, krb5cc_*)

```sh title:"John Extract crackable hash from an MIT Kerberos credential cache (ccache, krb5cc_*)"
ccache2john $file > hash
```
<!-- cheat
var file
-->

### DPAPImk2john

Extract crackable hash from a Windows DPAPI master key blob (under %APPDATA%\Microsoft\Protect\<SID>\)

```sh title:"John Extract crackable hash from a Windows DPAPI master key blob (under %APPDATA%\Microsoft\Protect\<SID>\)"
DPAPImk2john $file > hash
```
<!-- cheat
var file
-->

### htdigest2john

Convert an Apache htdigest file (.htdigest) to john format

```sh title:"Convert an Apache htdigest file (.htdigest) to john format"
htdigest2john $file > hash
```
<!-- cheat
var file
-->

### radius2john

Extract RADIUS authentication hashes from a .pcap / .pcapng

```sh title:"John Extract RADIUS authentication hashes from a .pcap / .pcapng"
radius2john $file > hash
```
<!-- cheat
var file
-->

### sap2john

Extract SAP CODVN B/F/G hashes from USR02 dump

```sh title:"John Extract SAP CODVN B/F/G hashes from USR02 dump"
sap2john $file > hash
```
<!-- cheat
var file
-->

### racf2john

Extract IBM RACF hashes from a database export (.racf)

```sh title:"John Extract IBM RACF hashes from a database export (.racf)"
racf2john $file > hash
```
<!-- cheat
var file
-->

### cracf2john

Extract IBM RACF KDFAES hashes (alternate .racf format)

```sh title:"John Extract IBM RACF KDFAES hashes (alternate .racf format)"
cracf2john $file > hash
```
<!-- cheat
var file
-->

### aix2john

Extract AIX hashes from /etc/security/passwd

```sh title:"John Extract AIX hashes from /etc/security/passwd"
aix2john $file > hash
```
<!-- cheat
var file
-->

### uaf2john

Extract OpenVMS User Authorization File hashes (SYSUAF.DAT)

```sh title:"John Extract OpenVMS User Authorization File hashes (SYSUAF.DAT)"
uaf2john $file > hash
```
<!-- cheat
var file
-->

### sspr2john

Extract NetIQ SecureLogin / SSPR password hashes (.xml export)

```sh title:"John Extract NetIQ SecureLogin / SSPR password hashes (.xml export)"
sspr2john $file > hash
```
<!-- cheat
var file
-->

### ibmiscanner2john

Extract IBM i (AS/400) password hashes from ibmiscanner output (.txt)

```sh title:"John Extract IBM i (AS/400) password hashes from ibmiscanner output (.txt)"
ibmiscanner2john $file > hash
```
<!-- cheat
var file
-->

### ldif2john

Extract password hashes from an LDAP .ldif export

```sh title:"John Extract password hashes from an LDAP .ldif export"
ldif2john $file > hash
```
<!-- cheat
var file
-->

### ejabberd2john

Extract Ejabberd XMPP server hashes (ejabberd.yml / Mnesia .DCD)

```sh title:"John Extract Ejabberd XMPP server hashes (ejabberd.yml / Mnesia .DCD)"
ejabberd2john $file > hash
```
<!-- cheat
var file
-->

### prosody2john

Extract Prosody XMPP server hashes (accounts/*.dat)

```sh title:"John Extract Prosody XMPP server hashes (accounts/*.dat)"
prosody2john $file > hash
```
<!-- cheat
var file
-->

### mosquitto2john

Extract Mosquitto MQTT broker hashes (passwd file from mosquitto_passwd)

```sh title:"John Extract Mosquitto MQTT broker hashes (passwd file from mosquitto_passwd)"
mosquitto2john $file > hash
```
<!-- cheat
var file
-->

### mcafee_epo2john

Extract McAfee ePolicy Orchestrator hashes (ePO .xml dump)

```sh title:"John Extract McAfee ePolicy Orchestrator hashes (ePO .xml dump)"
mcafee_epo2john $file > hash
```
<!-- cheat
var file
-->

### atmail2john

Extract Atmail webmail hashes (mysqldump .sql)

```sh title:"John Extract Atmail webmail hashes (mysqldump .sql)"
atmail2john $file > hash
```
<!-- cheat
var file
-->

### aruba2john

Extract Aruba network device hashes from config (.cfg)

```sh title:"John Extract Aruba network device hashes from config (.cfg)"
aruba2john $file > hash
```
<!-- cheat
var file
-->

### cisco2john

Extract Cisco IOS / ASA hashes from running-config (.cfg / .txt)

```sh title:"John Extract Cisco IOS / ASA hashes from running-config (.cfg / .txt)"
cisco2john $file > hash
```
<!-- cheat
var file
-->

### aem2john

Extract Adobe Experience Manager hashes (rep:authorizables .xml export)

```sh title:"John Extract Adobe Experience Manager hashes (rep:authorizables .xml export)"
aem2john $file > hash
```
<!-- cheat
var file
-->

### apex2john

Extract Oracle APEX hashes (FLOWS_FILES .sql dump)

```sh title:"John Extract Oracle APEX hashes (FLOWS_FILES .sql dump)"
apex2john $file > hash
```
<!-- cheat
var file
-->

### ps_token2john

Convert PeopleSoft SSO PS_TOKEN cookie to crackable form

```sh title:"John Convert PeopleSoft SSO PS_TOKEN cookie to crackable form"
ps_token2john $file > hash
```
<!-- cheat
var file
-->

### pse2john

Extract SAP Personal Security Environment hashes (.pse)

```sh title:"John Extract SAP Personal Security Environment hashes (.pse)"
pse2john $file > hash
```
<!-- cheat
var file
-->

### sense2john

Extract Sense smart-home hashes (config.json)

```sh title:"John Extract Sense smart-home hashes (config.json)"
sense2john $file > hash
```
<!-- cheat
var file
-->

### adxcsouf2john

Extract AD CS unattend file hashes (.UnattendFile.xml)

```sh title:"John Extract AD CS unattend file hashes (.UnattendFile.xml)"
adxcsouf2john $file > hash
```
<!-- cheat
var file
-->

## Password managers

### 1password2john

Extract crackable hash from a 1Password vault (.opvault / .agilekeychain)

```sh title:"John Extract crackable hash from a 1Password vault (.opvault / .agilekeychain)"
1password2john $file > hash
```
<!-- cheat
var file
-->

### bitwarden2john

Extract crackable hash from a Bitwarden vault (data.json)

```sh title:"John Extract crackable hash from a Bitwarden vault (data.json)"
bitwarden2john $file > hash
```
<!-- cheat
var file
-->

### dashlane2john

Extract crackable hash from a Dashlane vault (localSettings.aes)

```sh title:"John Extract crackable hash from a Dashlane vault (localSettings.aes)"
dashlane2john $file > hash
```
<!-- cheat
var file
-->

### enpass2john

Extract crackable hash from an Enpass vault (.walletx / vault.enpassdb)

```sh title:"John Extract crackable hash from an Enpass vault (.walletx / vault.enpassdb)"
enpass2john $file > hash
```
<!-- cheat
var file
-->

### keepass2john

Extract crackable hash from a KeePass database (.kdb / .kdbx)

```sh title:"John Extract crackable hash from a KeePass database (.kdb / .kdbx)"
keepass2john $file > hash
```
<!-- cheat
var file
-->

### kwallet2john

Extract crackable hash from a KDE Wallet (.kwl / kdewallet)

```sh title:"John Extract crackable hash from a KDE Wallet (.kwl / kdewallet)"
kwallet2john $file > hash
```
<!-- cheat
var file
-->

### keychain2john

Extract crackable hash from a macOS keychain (.keychain / .keychain-db)

```sh title:"John Extract crackable hash from a macOS keychain (.keychain / .keychain-db)"
keychain2john $file > hash
```
<!-- cheat
var file
-->

### keyring2john

Extract crackable hash from a GNOME Keyring (.keyring / login.keyring)

```sh title:"John Extract crackable hash from a GNOME Keyring (.keyring / login.keyring)"
keyring2john $file > hash
```
<!-- cheat
var file
-->

### lastpass2john

Extract crackable hash from a LastPass vault (lp.suid / vault.db)

```sh title:"John Extract crackable hash from a LastPass vault (lp.suid / vault.db)"
lastpass2john $file > hash
```
<!-- cheat
var file
-->

### padlock2john

Extract crackable hash from a Padlock vault (.padlock / .json)

```sh title:"John Extract crackable hash from a Padlock vault (.padlock / .json)"
padlock2john $file > hash
```
<!-- cheat
var file
-->

### pwsafe2john

Extract crackable hash from a Password Safe database (.psafe3)

```sh title:"John Extract crackable hash from a Password Safe database (.psafe3)"
pwsafe2john $file > hash
```
<!-- cheat
var file
-->

### mozilla2john

Extract crackable hash from Firefox saved logins (key3.db / key4.db)

```sh title:"John Extract crackable hash from Firefox saved logins (key3.db / key4.db)"
mozilla2john $file > hash
```
<!-- cheat
var file
-->

### applenotes2john

Extract crackable hash from a password-protected Apple Note (NoteStore.sqlite)

```sh title:"John Extract crackable hash from a password-protected Apple Note (NoteStore.sqlite)"
applenotes2john $file > hash
```
<!-- cheat
var file
-->

## Disk & volume encryption

### bitlocker2john

Extract crackable hash from a BitLocker volume image (.vhd / raw .img)

```sh title:"John Extract crackable hash from a BitLocker volume image (.vhd / raw .img)"
bitlocker2john $file > hash
```
<!-- cheat
var file
-->

### luks2john

Extract crackable hash from a LUKS volume (raw .img / dd of /dev/sdaN)

```sh title:"John Extract crackable hash from a LUKS volume (raw .img / dd of /dev/sdaN)"
luks2john $file > hash
```
<!-- cheat
var file
-->

### truecrypt2john

Extract crackable hash from a TrueCrypt / VeraCrypt container (.tc / .hc)

```sh title:"John Extract crackable hash from a TrueCrypt / VeraCrypt container (.tc / .hc)"
truecrypt2john $file > hash
```
<!-- cheat
var file
-->

### diskcryptor2john

Extract crackable hash from a DiskCryptor volume header (.dcb)

```sh title:"John Extract crackable hash from a DiskCryptor volume header (.dcb)"
diskcryptor2john $file > hash
```
<!-- cheat
var file
-->

### bestcrypt2john

Extract crackable hash from a Jetico BestCrypt container (.jbc)

```sh title:"John Extract crackable hash from a Jetico BestCrypt container (.jbc)"
bestcrypt2john $file > hash
```
<!-- cheat
var file
-->

### encfs2john

Extract crackable hash from an EncFS directory (.encfs6.xml)

```sh title:"John Extract crackable hash from an EncFS directory (.encfs6.xml)"
encfs2john $file > hash
```
<!-- cheat
var file
-->

### ecryptfs2john

Extract crackable hash from an eCryptfs wrapped passphrase (~/.ecryptfs/wrapped-passphrase)

```sh title:"John Extract crackable hash from an eCryptfs wrapped passphrase (~/.ecryptfs/wrapped-passphrase)"
ecryptfs2john $file > hash
```
<!-- cheat
var file
-->

### geli2john

Extract crackable hash from a FreeBSD GELI volume (provider .eli metadata)

```sh title:"John Extract crackable hash from a FreeBSD GELI volume (provider .eli metadata)"
geli2john $file > hash
```
<!-- cheat
var file
-->

### openbsd_softraid2john

Extract crackable hash from an OpenBSD softraid CRYPTO volume (raw partition image)

```sh title:"John Extract crackable hash from an OpenBSD softraid CRYPTO volume (raw partition image)"
openbsd_softraid2john $file > hash
```
<!-- cheat
var file
-->

### androidfde2john

Extract crackable hash from Android FDE footer (encryptable.img / footer)

```sh title:"John Extract crackable hash from Android FDE footer (encryptable.img / footer)"
androidfde2john $file > hash
```
<!-- cheat
var file
-->

### dmg2john

Extract crackable hash from an Apple disk image (.dmg)

```sh title:"John Extract crackable hash from an Apple disk image (.dmg)"
dmg2john $file > hash
```
<!-- cheat
var file
-->

### vdi2john

Extract crackable hash from a VirtualBox image (.vdi)

```sh title:"John Extract crackable hash from a VirtualBox image (.vdi)"
vdi2john $file > hash
```
<!-- cheat
var file
-->

### vmx2john

Extract crackable hash from a VMware encrypted VM (.vmx / .vmdk)

```sh title:"John Extract crackable hash from a VMware encrypted VM (.vmx / .vmdk)"
vmx2john $file > hash
```
<!-- cheat
var file
-->

### pgpdisk2john

Extract crackable hash from a PGPdisk virtual volume (.pgd)

```sh title:"John Extract crackable hash from a PGPdisk virtual volume (.pgd)"
pgpdisk2john $file > hash
```
<!-- cheat
var file
-->

### pgpwde2john

Extract crackable hash from PGP Whole Disk Encryption (raw boot sectors)

```sh title:"John Extract crackable hash from PGP Whole Disk Encryption (raw boot sectors)"
pgpwde2john $file > hash
```
<!-- cheat
var file
-->

### pgpsda2john

Extract crackable hash from a PGP Self-Decrypting Archive (.exe SDA)

```sh title:"John Extract crackable hash from a PGP Self-Decrypting Archive (.exe SDA)"
pgpsda2john $file > hash
```
<!-- cheat
var file
-->

## Archives

### zip2john

Extract crackable hash from a password-protected zip (.zip)

```sh title:"John Extract crackable hash from a password-protected zip (.zip)"
zip2john $file > hash
```
<!-- cheat
var file
-->

### rar2john

Extract crackable hash from a RAR archive (.rar)

```sh title:"John Extract crackable hash from a RAR archive (.rar)"
rar2john $file > hash
```
<!-- cheat
var file
-->

### 7z2john

Extract crackable hash from a 7-Zip archive (.7z)

```sh title:"John Extract crackable hash from a 7-Zip archive (.7z)"
7z2john $file > hash
```
<!-- cheat
var file
-->

### androidbackup2john

Extract crackable hash from an Android adb backup (.ab)

```sh title:"John Extract crackable hash from an Android adb backup (.ab)"
androidbackup2john $file > hash
```
<!-- cheat
var file
-->

### itunes_backup2john

Extract crackable hash from an encrypted iTunes backup (Manifest.plist / Manifest.db)

```sh title:"John Extract crackable hash from an encrypted iTunes backup (Manifest.plist / Manifest.db)"
itunes_backup2john $file > hash
```
<!-- cheat
var file
-->

### restic2john

Extract crackable hash from a restic repository (config file under repo/)

```sh title:"John Extract crackable hash from a restic repository (config file under repo/)"
restic2john $file > hash
```
<!-- cheat
var file
-->

## Documents

### pdf2john

Extract crackable hash from a password-protected PDF (.pdf)

```sh title:"John Extract crackable hash from a password-protected PDF (.pdf)"
pdf2john $file > hash
```
<!-- cheat
var file
-->

### office2john

Extract crackable hash from a password-protected MS Office doc (.doc / .docx / .xls / .xlsx / .ppt / .pptx)

```sh title:"John Extract crackable hash from a password-protected MS Office doc (.doc / .docx / .xls / .xlsx / .ppt / .pptx)"
office2john $file > hash
```
<!-- cheat
var file
-->

### libreoffice2john

Extract crackable hash from a password-protected LibreOffice doc (.odt / .ods / .odp)

```sh title:"John Extract crackable hash from a password-protected LibreOffice doc (.odt / .ods / .odp)"
libreoffice2john $file > hash
```
<!-- cheat
var file
-->

### staroffice2john

Extract crackable hash from a password-protected StarOffice doc (.sxw / .sxc / .sxi)

```sh title:"John Extract crackable hash from a password-protected StarOffice doc (.sxw / .sxc / .sxi)"
staroffice2john $file > hash
```
<!-- cheat
var file
-->

### iwork2john

Extract crackable hash from a password-protected Apple iWork file (.pages / .numbers / .key)

```sh title:"John Extract crackable hash from a password-protected Apple iWork file (.pages / .numbers / .key)"
iwork2john $file > hash
```
<!-- cheat
var file
-->

### lotus2john

Extract crackable hash from a Lotus Notes ID file (user.id)

```sh title:"John Extract crackable hash from a Lotus Notes ID file (user.id)"
lotus2john $file > hash
```
<!-- cheat
var file
-->

### money2john

Extract crackable hash from a Microsoft Money database (.mny)

```sh title:"John Extract crackable hash from a Microsoft Money database (.mny)"
money2john $file > hash
```
<!-- cheat
var file
-->

### lion2john

Extract crackable hash from a macOS 10.7 Lion shadow (/var/db/dslocal/nodes/Default/users/<user>.plist)

```sh title:"John Extract crackable hash from a macOS 10.7 Lion shadow (/var/db/dslocal/nodes/Default/users/<user>.plist)"
lion2john $file > hash
```
<!-- cheat
var file
-->

### mac2john

Extract crackable hash from a macOS user shadow (.plist)

```sh title:"John Extract crackable hash from a macOS user shadow (.plist)"
mac2john $file > hash
```
<!-- cheat
var file
-->

## Crypto wallets

### bitcoin2john

Extract crackable hash from a Bitcoin Core wallet (wallet.dat)

```sh title:"John Extract crackable hash from a Bitcoin Core wallet (wallet.dat)"
bitcoin2john $file > hash
```
<!-- cheat
var file
-->

### bitshares2john

Extract crackable hash from a BitShares wallet (.wallet / .json)

```sh title:"John Extract crackable hash from a BitShares wallet (.wallet / .json)"
bitshares2john $file > hash
```
<!-- cheat
var file
-->

### blockchain2john

Extract crackable hash from a Blockchain.com wallet backup (wallet.aes.json)

```sh title:"John Extract crackable hash from a Blockchain.com wallet backup (wallet.aes.json)"
blockchain2john $file > hash
```
<!-- cheat
var file
-->

### electrum2john

Extract crackable hash from an Electrum wallet (default_wallet / .wallet)

```sh title:"John Extract crackable hash from an Electrum wallet (default_wallet / .wallet)"
electrum2john $file > hash
```
<!-- cheat
var file
-->

### ethereum2john

Extract crackable hash from an Ethereum wallet (UTC--*.json keystore)

```sh title:"John Extract crackable hash from an Ethereum wallet (UTC--*.json keystore)"
ethereum2john $file > hash
```
<!-- cheat
var file
-->

### monero2john

Extract crackable hash from a Monero wallet (.keys)

```sh title:"John Extract crackable hash from a Monero wallet (.keys)"
monero2john $file > hash
```
<!-- cheat
var file
-->

### multibit2john

Extract crackable hash from a MultiBit Bitcoin wallet (.wallet / .key)

```sh title:"John Extract crackable hash from a MultiBit Bitcoin wallet (.wallet / .key)"
multibit2john $file > hash
```
<!-- cheat
var file
-->

### tezos2john

Extract crackable hash from a Tezos wallet (encrypted secret key string)

```sh title:"John Extract crackable hash from a Tezos wallet (encrypted secret key string)"
tezos2john $file > hash
```
<!-- cheat
var file
-->

### neo2john

Extract crackable hash from a NEO wallet (.json NEP-6)

```sh title:"John Extract crackable hash from a NEO wallet (.json NEP-6)"
neo2john $file > hash
```
<!-- cheat
var file
-->

## Network captures

### pcap2john

Extract crackable hashes from a generic packet capture (.pcap / .pcapng)

```sh title:"John Extract crackable hashes from a generic packet capture (.pcap / .pcapng)"
pcap2john $file > hash
```
<!-- cheat
var file
-->

### hccap2john

Convert an old hashcat WPA capture (.hccap) to john format

```sh title:"Convert an old hashcat WPA capture (.hccap) to john format"
hccap2john $file > hash
```
<!-- cheat
var file
-->

### hccapx2john

Convert a hashcat WPA capture (.hccapx) to john format

```sh title:"Convert a hashcat WPA capture (.hccapx) to john format"
hccapx2john $file > hash
```
<!-- cheat
var file
-->

### wpapcap2john

Extract WPA/WPA2 handshake hash from a packet capture (.pcap / .pcapng)

```sh title:"John Extract WPA/WPA2 handshake hash from a packet capture (.pcap / .pcapng)"
wpapcap2john $file > hash
```
<!-- cheat
var file
-->

### vncpcap2john

Extract VNC challenge/response hash from a packet capture (.pcap)

```sh title:"John Extract VNC challenge/response hash from a packet capture (.pcap)"
vncpcap2john $file > hash
```
<!-- cheat
var file
-->

### sipdump2john

Extract SIP digest auth hash from a sipdump output (.txt)

```sh title:"John Extract SIP digest auth hash from a sipdump output (.txt)"
sipdump2john $file > hash
```
<!-- cheat
var file
-->

### ikescan2john

Extract IKE PSK hash from ike-scan output (-A capture)

```sh title:"John Extract IKE PSK hash from ike-scan output (-A capture)"
ikescan2john $file > hash
```
<!-- cheat
var file
-->

### known_hosts2john

Extract hashed entries from an SSH known_hosts file (~/.ssh/known_hosts)

```sh title:"John Extract hashed entries from an SSH known_hosts file (~/.ssh/known_hosts)"
known_hosts2john $file > hash
```
<!-- cheat
var file
-->

## Keys, certs & crypto

### ssh2john

Extract crackable hash from an encrypted SSH private key (id_rsa / id_ed25519 / id_ecdsa)

```sh title:"John Extract crackable hash from an encrypted SSH private key (id_rsa / id_ed25519 / id_ecdsa)"
ssh2john $file > hash
```
<!-- cheat
var file
-->

### putty2john

Extract crackable hash from a PuTTY private key (.ppk)

```sh title:"John Extract crackable hash from a PuTTY private key (.ppk)"
putty2john $file > hash
```
<!-- cheat
var file
-->

### gpg2john

Extract crackable hash from a GPG secret keyring (.gpg / secring.gpg / .asc)

```sh title:"John Extract crackable hash from a GPG secret keyring (.gpg / secring.gpg / .asc)"
gpg2john $file > hash
```
<!-- cheat
var file
-->

### pem2john

Extract crackable hash from an encrypted PEM private key (.pem / .key)

```sh title:"John Extract crackable hash from an encrypted PEM private key (.pem / .key)"
pem2john $file > hash
```
<!-- cheat
var file
-->

### pfx2john

Extract crackable hash from a PKCS#12 file (.pfx / .p12)

```sh title:"John Extract crackable hash from a PKCS#12 file (.pfx / .p12)"
pfx2john $file > hash
```
<!-- cheat
var file
-->

### openssl2john

Extract crackable hash from an OpenSSL enc'd file (.enc, openssl enc -aes-256-cbc output)

```sh title:"John Extract crackable hash from an OpenSSL enc'd file (.enc, openssl enc -aes-256-cbc output)"
openssl2john $file > hash
```
<!-- cheat
var file
-->

### keystore2john

Extract crackable hash from a Java keystore (.jks / .keystore)

```sh title:"John Extract crackable hash from a Java keystore (.jks / .keystore)"
keystore2john $file > hash
```
<!-- cheat
var file
-->

### bks2john

Extract crackable hash from a BouncyCastle keystore (.bks)

```sh title:"John Extract crackable hash from a BouncyCastle keystore (.bks)"
bks2john $file > hash
```
<!-- cheat
var file
-->

### axcrypt2john

Extract crackable hash from an AxCrypt-encrypted file (.axx)

```sh title:"John Extract crackable hash from an AxCrypt-encrypted file (.axx)"
axcrypt2john $file > hash
```
<!-- cheat
var file
-->

### zed2john

Extract crackable hash from a ZED!-encrypted container (.zed)

```sh title:"John Extract crackable hash from a ZED!-encrypted container (.zed)"
zed2john $file > hash
```
<!-- cheat
var file
-->

## Apps & misc

### ansible2john

Extract crackable hash from an ansible-vault file (.yml / vault.yml)

```sh title:"John Extract crackable hash from an ansible-vault file (.yml / vault.yml)"
ansible2john $file > hash
```
<!-- cheat
var file
-->

### filezilla2john

Extract stored credentials from FileZilla (sitemanager.xml / recentservers.xml)

```sh title:"John Extract stored credentials from FileZilla (sitemanager.xml / recentservers.xml)"
filezilla2john $file > hash
```
<!-- cheat
var file
-->

### deepsound2john

Extract crackable hash from a DeepSound stego carrier (.wav / .mp3 / .flac)

```sh title:"John Extract crackable hash from a DeepSound stego carrier (.wav / .mp3 / .flac)"
deepsound2john $file > hash
```
<!-- cheat
var file
-->

### strip2john

Extract crackable hash from a STRIP password manager backup (.strip / .csv)

```sh title:"John Extract crackable hash from a STRIP password manager backup (.strip / .csv)"
strip2john $file > hash
```
<!-- cheat
var file
-->

### signal2john

Extract crackable hash from a Signal Desktop database (config.json / db.sqlite)

```sh title:"John Extract crackable hash from a Signal Desktop database (config.json / db.sqlite)"
signal2john $file > hash
```
<!-- cheat
var file
-->

### telegram2john

Extract crackable hash from a Telegram local passcode (D877F783D5D3EF8C / settings file)

```sh title:"John Extract crackable hash from a Telegram local passcode (D877F783D5D3EF8C / settings file)"
telegram2john $file > hash
```
<!-- cheat
var file
-->

### andotp2john

Extract crackable hash from an andOTP encrypted backup (.aes / .json.aes)

```sh title:"John Extract crackable hash from an andOTP encrypted backup (.aes / .json.aes)"
andotp2john $file > hash
```
<!-- cheat
var file
-->
