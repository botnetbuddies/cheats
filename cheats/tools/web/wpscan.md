# Wpscan


<!-- cheat
export wpscan
var wp_pass_attack_template = printf '%s\n' 'wp-login' 'xmlrpc' 'xmlrpc-multicall' '' --- --header 'Attack method'
-->

## wpscan - Wordpress enum

### WordPress enumeration

Run wpscan with default enumeration (themes, plugins, users, vulnerabilities).

```sh title:"Default wpscan enum: themes/plugins/users/vulns"
wpscan --url $scheme://$domain --enumerate
```
<!-- cheat
import domain_ip
import scheme
import wpscan
-->

### WordPress Docker through Burp

Run wpscan in Docker through Burp with an API token.

```sh title:"Run wpscan Docker through Burp proxy"
sudo docker run -it --network host --rm wpscanteam/wpscan --proxy http://127.0.0.1:8080 --url "$url" --disable-tls-checks -e ap,tt,cb,dbe,u1-20,m --api-token "$wpscan_api_token"
```
<!-- cheat
var url
var wpscan_api_token
-->

## wpscan - Wordpress Brute

### Password attack

Brute users against the chosen attack vector (wp-login form, xmlrpc, xmlrpc-multicall). Multicall is fastest because each request can hold many guesses.

```sh title:"Wpscan Brute users via wp-login / xmlrpc / xmlrpc-multicall"
wpscan --url $scheme://$domain -U $user -P $wordlists --password-attack $wp_pass_attack_template
```
<!-- cheat
import wordlist_passwords
import domain_ip
import scheme
import wpscan
var user
-->
