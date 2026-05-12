# CVE Bin Tool

## scan

### Target

Scan a file or directory for embedded open source components and CVEs.

```sh title:"Scan file or directory for CVEs"
cve-bin-tool "$target"
```
<!-- cheat
var target
-->

### Offline

Run an offline scan using the local CVE database.

```sh title:"Scan offline with local CVE database"
cve-bin-tool --offline "$target"
```
<!-- cheat
var target
-->

### Component

Scan for a specific component.

```sh title:"Scan for specific component"
cve-bin-tool -r "$component" "$target"
```
<!-- cheat
var component
var target
-->

### HTML report

Build an HTML report.

```sh title:"Build HTML CVE report"
cve-bin-tool -f html "$target"
```
<!-- cheat
var target
-->
