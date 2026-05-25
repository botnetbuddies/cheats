# Hashcat

<!-- cheat
export hashcat
var hash_file = sh -c 'printf "%s\n" "hash"; find "$PWD/" -maxdepth 1 -type f ! -name ".*" -printf "%f\n" | grep -v "^$(basename "$PWD/")$" | sort' --- --header 'Current directory files'
import wordlist_passwords
import wordlists_users
-->

## hashcat cracking

### Hashcat auto-detect

Crack auto detect with Hashcat.

Crack a hash file with auto mode detection. Hashcat sniffs the format from the file contents instead of forcing `-m`.

```sh title:"Hashcat Crack Auto Detect"
hashcat $hash_file $wordlists
```
<!-- cheat
import hashcat
-->

### MD5 Joomla WordPress

Crack MD5 joomla WordPress with Hashcat.

Crack Joomla or WordPress MD5 hashes with a wordlist.

```sh title:"Hashcat Crack MD5 Joomla WordPress"
hashcat -a 0 -m 400 "$hash_file" "$wordlists"
```
<!-- cheat
import hashcat
-->

### MD5 Joomla WordPress best64

Crack MD5 joomla WordPress best64 with Hashcat.

Crack Joomla or WordPress MD5 hashes with `best64.rule`.

```sh title:"Hashcat Crack MD5 Joomla WordPress Best64"
hashcat -a 0 -m 400 "$hash_file" "$wordlists" -r /usr/share/hashcat/rules/best64.rule
```
<!-- cheat
import hashcat
-->

### Kerberos TGS REP

Crack kerberos TGS REP with Hashcat.

Crack Kerberoast TGS-REP hashes.

```sh title:"Hashcat Crack Kerberos TGS REP"
hashcat -m 13100 -a 0 "$hash_file" "$wordlists"
```
<!-- cheat
import hashcat
-->

### LM

Crack LM with Hashcat.

Crack LM hashes.

```sh title:"Hashcat Crack LM"
hashcat -m 3000 -a 0 "$hash_file" "$wordlists"
```
<!-- cheat
import hashcat
-->

### NTLM

Crack NTLM with Hashcat.

Crack NTLM hashes.

```sh title:"Hashcat Crack NTLM"
hashcat -m 1000 -a 0 "$hash_file" "$wordlists"
```
<!-- cheat
import hashcat
-->

### NetNTLMv1

Crack NetNTLMv1 with Hashcat.

Crack NetNTLMv1 challenge-response hashes.

```sh title:"Hashcat Crack NetNTLMv1"
hashcat -m 5500 -a 0 "$hash_file" "$wordlists"
```
<!-- cheat
import hashcat
-->

### NetNTLMv2

Crack NetNTLMv2 with Hashcat.

Crack NetNTLMv2 challenge-response hashes.

```sh title:"Hashcat Crack NetNTLMv2"
hashcat -m 5600 -a 0 "$hash_file" "$wordlists"
```
<!-- cheat
import hashcat
-->

### NetNTLMv2 combination

Crack NetNTLMv2 combination with Hashcat.

Crack NetNTLMv2 hashes with a combination attack.

```sh title:"Hashcat Crack NetNTLMv2 Combination"
hashcat -m 5600 -a 1 "$hash_file" "$wordlist_a" "$wordlist_b"
```
<!-- cheat
var wordlist_a
var wordlist_b
var hash_file
-->

## hashcat wordlists

### best64.rule mutation

Crack best64.rule mutation with Hashcat.

Generate a mutated wordlist by piping a base list through `best64.rule`. Use the output for fast targeted attacks before reaching for slower rule sets.

```sh title:"Hashcat Crack Best64.rule Mutation"
hashcat --stdout $custom_wordlist -r /usr/share/hashcat/rules/best64.rule > $mutated_list
```
<!-- cheat
var custom_wordlist
var mutated_list
-->
