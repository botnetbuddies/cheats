---
technique: File Upload Testing
category: file-handling
targets: Web Applications
protocols: HTTP, Multipart
remote_capable: true
tags: web file-upload multipart
---

# File Upload Testing

File upload testing checks extension controls, content-type handling, server-side storage, path handling, and execution risk.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Upload endpoint | Requires an authorized upload route |
| Test file | Use benign proof files unless exploit testing is approved |
| Retrieval path | Impact depends on whether uploaded content is reachable or executable |

## Linux

### Multipart upload

#sh #curl #upload

Upload a file with multipart form data.

```sh title:"Upload file with multipart form"
curl -sk -F "$field=@$local_file" "$url"
```
<!-- cheat
var field
var local_file
var url
-->

### Content-type override

#sh #curl #upload

Upload a file with an explicit content type.

```sh title:"Upload file with content type"
curl -sk -F "$field=@$local_file;type=$content_type" "$url"
```
<!-- cheat
var field
var local_file
var content_type
var url
-->

### Filename override

#sh #curl #upload

Upload a file with an explicit filename.

```sh title:"Upload file with filename override"
curl -sk -F "$field=@$local_file;filename=$remote_name" "$url"
```
<!-- cheat
var field
var local_file
var remote_name
var url
-->
