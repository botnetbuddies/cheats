# Server

## Python Web server

### Python HTTP server

Serve the current directory over HTTP. Standard staging server for payload delivery and file pulls.

```sh title:"Serve cwd over HTTP for payload delivery"
python3 -m http.server $lport $template
```
<!-- cheat
import webserver
import passwords
import lports
import users
var template
-->

### Python 2 HTTP server

Serve the current directory over HTTP with Python 2.

```sh title:"Serve cwd over HTTP with Python 2"
python -m SimpleHTTPServer $lport
```
<!-- cheat
import lports
-->

### FTP w/auth

Authenticated writable FTP server via pyftpdlib. Use when you need a place to receive files from a target.

```sh title:"Authenticated writable FTP via pyftpdlib"
python3 -m pyftpdlib -w -p $lport -u $user -P $pass
```
<!-- cheat
import webserver
import passwords
import users
import lports
-->

### FTP anonymous

Anonymous writable FTP server. Quick exfil drop point when egress filtering is loose.

```sh title:"Anonymous writable FTP, quick exfil drop"
python -m pyftpdlib -w -p $lport $template
```
<!-- cheat
import webserver
import passwords
import users
import lports
var template
-->

## PHP Web server

### PHP HTTP server

PHP built-in server, useful when you need PHP execution (e.g. delivering a `.php` payload that should run in-place).

```sh title:"PHP built-in server, runs .php payloads in place"
php -S 0.0.0.0:$lport $template
```
<!-- cheat
import webserver
import passwords
import users
import lports
var template
-->
