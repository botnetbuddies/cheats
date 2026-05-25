# JwtTool

<!-- cheat
export jwttool
import wordlist_passwords
-->

## tests

### All tests

Enumerate all tests with JwtTool.

```sh title:"JwtTool Enumerate All Tests"
python3 jwt_tool.py -M at -t "$url" -rh "Authorization: Bearer $jwt_token" -rh "$header" -rc "$cookies"
```
<!-- cheat
var url
var jwt_token
var header
var cookies
-->

### Reuse query

Enumerate reuse query with JwtTool.

```sh title:"JwtTool Enumerate Reuse Query"
python3 jwt_tool.py -Q "$jwttool_id"
```
<!-- cheat
var jwttool_id
-->

### Brute force key

Run brute force key with JwtTool.

```sh title:"JwtTool Run Brute Force Key"
python3 jwt_tool.py -d "$wordlists" "$jwt_token"
```
<!-- cheat
import jwttool
var jwt_token
-->
