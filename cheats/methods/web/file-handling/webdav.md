---
technique: WebDAV Testing
category: file-handling
targets: WebDAV
protocols: HTTP, WebDAV
remote_capable: true
tags: web webdav upload methods
---

# WebDAV Testing

WebDAV testing checks enabled methods, authenticated file operations, and unsafe upload or overwrite behavior.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| WebDAV endpoint | Requires an in-scope WebDAV-enabled path |
| Credentials | Many deployments require HTTP auth |
| Test file | Use benign proof files for write checks |

## Linux

### Method check

#sh #curl #webdav

Check allowed methods.

```sh title:"Check WebDAV methods"
curl -sk -X OPTIONS "$url" -i
```
<!-- cheat
var url
-->

### PUT file

#sh #curl #webdav

Upload a file with PUT.

```sh title:"Upload file with WebDAV PUT"
curl -sk -T "$local_file" "$url/$remote_name"
```
<!-- cheat
var local_file
var url
var remote_name
-->

### DELETE file

#sh #curl #webdav

Delete an authorized test file.

```sh title:"Delete WebDAV test file"
curl -sk -X DELETE "$url/$remote_name"
```
<!-- cheat
var url
var remote_name
-->
