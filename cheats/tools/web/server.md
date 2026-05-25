# Server

## Python Web server

### Python HTTP server

Start python HTTP server with Server.

Serve the current directory over HTTP. Standard staging server for payload delivery and file pulls.

```sh title:"Server Start Python HTTP Server"
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

Start python 2 HTTP server with Server.

Serve the current directory over HTTP with Python 2.

```sh title:"Server Start Python 2 HTTP Server"
python -m SimpleHTTPServer $lport
```
<!-- cheat
import lports
-->

### FTP w/auth

Read FTP w/auth with Server.

Authenticated writable FTP server via pyftpdlib. Use when you need a place to receive files from a target.

```sh title:"Server Read FTP W/auth"
python3 -m pyftpdlib -w -p $lport -u $user -P $pass
```
<!-- cheat
import webserver
import passwords
import users
import lports
-->

### FTP anonymous

Dump FTP anonymous with Server.

Anonymous writable FTP server. Quick exfil drop point when egress filtering is loose.

```sh title:"Server Dump FTP Anonymous"
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

Start PHP HTTP server with Server.

PHP built-in server, useful when you need PHP execution (e.g. delivering a `.php` payload that should run in-place).

```sh title:"Server Start PHP HTTP Server"
php -S 0.0.0.0:$lport $template
```
<!-- cheat
import webserver
import passwords
import users
import lports
var template
-->
