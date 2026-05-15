---
technique: XXE Testing
category: injection
targets: XML Endpoints
protocols: HTTP, XML
remote_capable: true
tags: web xxe injection xml
---

# XXE Testing

XXE testing checks whether XML parsers resolve external entities, local files, or out-of-band callbacks.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| XML endpoint | Requires an endpoint that parses XML |
| Payload file | Keep XML payloads outside command blocks |
| Callback | Blind XXE needs an authorized listener or collaborator endpoint |

## Linux

### XML POST

#sh #curl #xxe

Send a prepared XML payload to an endpoint.

```sh title:"POST prepared XML payload"
curl -sk -X POST -H "Content-Type: application/xml" --data-binary "$xml_payload" "$url"
```
<!-- cheat
var xml_payload
var url
-->

### XML request file

#sh #curl #xxe

Replay a prepared XML request body from a file.

```sh title:"POST XML payload file"
curl -sk -X POST -H "Content-Type: application/xml" --data-binary "@$xml_file" "$url"
```
<!-- cheat
var xml_file
var url
-->

### SOAP request file

#sh #curl #xxe

Replay a prepared SOAP XML request body from a file.

```sh title:"POST SOAP XML payload file"
curl -sk -X POST -H "Content-Type: text/xml" --data-binary "@$xml_file" "$url"
```
<!-- cheat
var xml_file
var url
-->
