# Server

## Python Web server

### Python HTTP server

Start python HTTP server with Server.

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

```sh title:"Server Start Python 2 HTTP Server"
python -m SimpleHTTPServer $lport
```
<!-- cheat
import lports
-->

### FTP w/auth

Read FTP w/auth with Server.

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
