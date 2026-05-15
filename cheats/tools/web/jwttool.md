# JwtTool

<!-- cheat
export jwttool
import wordlist_passwords
-->

## tests

### All tests

Run jwt_tool all tests against a target URL.

```sh title:"Run jwt_tool all tests against target"
python3 jwt_tool.py -M at -t "$url" -rh "Authorization: Bearer $jwt_token" -rh "$header" -rc "$cookies"
```
<!-- cheat
var url
var jwt_token
var header
var cookies
-->

### Reuse query

Reuse a jwt_tool query ID.

```sh title:"Reuse jwt_tool query ID"
python3 jwt_tool.py -Q "$jwttool_id"
```
<!-- cheat
var jwttool_id
-->

### Brute force key

Brute force a JWT signing key with a wordlist.

```sh title:"Brute force JWT signing key"
python3 jwt_tool.py -d "$wordlists" "$jwt_token"
```
<!-- cheat
import jwttool
var jwt_token
-->
