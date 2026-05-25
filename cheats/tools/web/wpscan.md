# Wpscan


<!-- cheat
export wpscan
var wp_pass_attack_template = printf '%s\n' 'wp-login' 'xmlrpc' 'xmlrpc-multicall' '' --- --header 'Attack method'
-->

## wpscan - Wordpress enum

### WordPress enumeration

Scan WordPress enumeration with Wpscan.

```sh title:"Wpscan Scan WordPress Enumeration"
wpscan --url $scheme://$domain --enumerate
```
<!-- cheat
import domain_ip
import scheme
import wpscan
-->

### WordPress Docker through Burp

Scan WordPress docker through burp with Wpscan.

```sh title:"Wpscan Scan WordPress Docker Through Burp"
sudo docker run -it --network host --rm wpscanteam/wpscan --proxy http://127.0.0.1:8080 --url "$url" --disable-tls-checks -e ap,tt,cb,dbe,u1-20,m --api-token "$wpscan_api_token"
```
<!-- cheat
var url
var wpscan_api_token
-->

## wpscan - Wordpress Brute

### Password attack

Dump password attack with Wpscan.

```sh title:"Wpscan Dump Password Attack"
wpscan --url $scheme://$domain -U $user -P $wordlists --password-attack $wp_pass_attack_template
```
<!-- cheat
import wordlist_passwords
import domain_ip
import scheme
import wpscan
var user
-->
