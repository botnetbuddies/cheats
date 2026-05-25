# Penelope

<!-- cheat
export penelope
var tool = sh -c 'printf "%s\n" "$linux_tools/pspy"; find "$linux_tools/" -maxdepth 1 -type f ! -name ".*" -printf "%p\n" | sort' --- --header 'Linux tools'
-->

## penelope - file upload

### Quick file upload

Upload a tool from your `$linux_tools` collection straight into the penelope session.

```sh title:"Push tool from $linux_tools into penelope session"
upload $tool
```
<!-- cheat
import penelope
var tool
-->

### Run peass-ng

Run linpeas inside the penelope session (auto recon for Linux privesc).

```sh title:"Penelope Auto Linux privesc recon via linpeas inside session"
run peass_ng
```
<!-- cheat -->

### Run lse

Run lse (Linux Smart Enumeration) inside the penelope session.

```sh title:"Penelope Linux Smart Enumeration inside the session"
run lse
```
<!-- cheat -->
