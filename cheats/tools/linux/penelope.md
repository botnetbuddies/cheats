# Penelope

<!-- cheat
export penelope
var tool = sh -c 'printf "%s\n" "$linux_tools/pspy"; find "$linux_tools/" -maxdepth 1 -type f ! -name ".*" -printf "%p\n" | sort' --- --header 'Linux tools'
-->

## penelope - file upload

### Quick file upload

Upload quick file upload with Penelope.

Upload a tool from your `$linux_tools` collection straight into the penelope session.

```sh title:"Penelope Upload Quick File Upload"
upload $tool
```
<!-- cheat
import penelope
var tool
-->

### Run peass-ng

Run peass ng with Penelope.

Run linpeas inside the penelope session (auto recon for Linux privesc).

```sh title:"Penelope Run Peass Ng"
run peass_ng
```
<!-- cheat -->

### Run lse

Run lse with Penelope.

Run lse (Linux Smart Enumeration) inside the penelope session.

```sh title:"Penelope Run Lse"
run lse
```
<!-- cheat -->
