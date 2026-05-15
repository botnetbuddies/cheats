---
technique: CredentialCracking
category: credential-access
targets: Hashes, Kerberos Material, Captured Responses
protocols: NTLM, Kerberos
remote_capable: false
tags: cracking hashcat john ntlm kerberos asreproast kerberoast ad
---

# CredentialCracking

Cracking turns captured hashes, Kerberos roast material, and cached credential blobs into plaintext passwords when pass-the-hash, pass-the-ticket, or key-based impersonation is not enough. Match the hash type before choosing wordlist, rule, mask, or brute-force attacks.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Hash mode | Common AD modes include NT `1000`, NTLMv2 `5600`, DCC2 `2100`, ASREPRoast `18200`, and Kerberoast `13100` |
| Wordlist | Use domain-specific lists when possible |
| Rules or masks | Add rules for human passwords and masks for known formats |

## Linux

### hashcat dictionary

#hashcat #dictionary

Run a straight dictionary attack against a hash file.

```sh title:"Crack hashes with hashcat dictionary mode"
hashcat --attack-mode 0 --hash-type $hash_type "$hashes_file" "$wordlist_file"
```
<!-- cheat
var hash_type
var hashes_file
var wordlist_file
-->

### hashcat rules

#hashcat #rules

Run a dictionary attack with rules and loopback against a hash file.

```sh title:"Crack hashes with hashcat rules and loopback"
hashcat --loopback --attack-mode 0 --rules-file "$rules_file" --hash-type $hash_type "$hashes_file" "$wordlist_file"
```
<!-- cheat
var rules_file
var hash_type
var hashes_file
var wordlist_file
-->

### hashcat fixed mask

#hashcat #mask

Run a mask attack for a known password pattern.

```sh title:"Crack hashes with hashcat mask attack"
hashcat --attack-mode 3 --hash-type $hash_type "$hashes_file" "$mask"
```
<!-- cheat
var hash_type
var hashes_file
var mask
-->

### hashcat incremental mask

#hashcat #mask

Run an incremental brute-force attack across a mask length range.

```sh title:"Crack hashes with hashcat incremental mask"
hashcat --attack-mode 3 --increment --increment-min $min_length --increment-max $max_length --hash-type $hash_type "$hashes_file" "$mask"
```
<!-- cheat
var min_length
var max_length
var hash_type
var hashes_file
var mask
-->

### hashcat custom charset

#hashcat #mask

Run a mask attack with custom character sets for known password structure.

```sh title:"Crack hashes with hashcat custom charsets"
hashcat --attack-mode 3 --custom-charset1 "$charset1" --custom-charset2 "$charset2" --custom-charset3 "$charset3" --hash-type $hash_type "$hashes_file" "$mask"
```
<!-- cheat
var charset1
var charset2
var charset3
var hash_type
var hashes_file
var mask
-->

### john wordlist

#john #dictionary

Run John the Ripper against a hash file with a wordlist.

```sh title:"Crack hashes with John wordlist mode"
john --wordlist="$wordlist_file" "$hashes_file"
```
<!-- cheat
var wordlist_file
var hashes_file
-->

### john format

#john #format

Run John the Ripper with an explicit hash format.

```sh title:"Crack hashes with John explicit format"
john --format="$john_format" --wordlist="$wordlist_file" "$hashes_file"
```
<!-- cheat
var john_format
var wordlist_file
var hashes_file
-->

### john show

#john #results

Show cracked passwords from John the Ripper's pot file.

```sh title:"Show cracked passwords with John"
john --show "$hashes_file"
```
<!-- cheat
var hashes_file
-->
