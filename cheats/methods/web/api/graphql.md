---
technique: GraphQL Testing
category: api
targets: GraphQL APIs
protocols: HTTP, GraphQL
remote_capable: true
tags: web graphql api introspection
---

# GraphQL Testing

GraphQL testing checks introspection, schema exposure, authorization on object fields, batching behavior, and query cost controls.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Endpoint | Requires a GraphQL HTTP endpoint |
| Query body | Keep GraphQL request JSON in a variable or file |
| Auth | Compare anonymous and authenticated schema visibility |

## Linux

### Endpoint probe

#sh #curl #graphql

Send a prepared GraphQL request body.

```sh title:"Send GraphQL request body"
curl -sk -X POST -H "Content-Type: application/json" --data "$graphql_body" "$url"
```
<!-- cheat
var graphql_body
var url
-->

### Request file

#sh #curl #graphql

Send a GraphQL request body from a file.

```sh title:"Send GraphQL request file"
curl -sk -X POST -H "Content-Type: application/json" --data-binary "@$graphql_file" "$url"
```
<!-- cheat
var graphql_file
var url
-->

### Authenticated query

#sh #curl #graphql

Send an authenticated GraphQL request.

```sh title:"Send authenticated GraphQL request"
curl -sk -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $token" --data-binary "@$graphql_file" "$url"
```
<!-- cheat
var token
var graphql_file
var url
-->

### GraphQL map

#sh #graphqlmap #graphql

Run GraphQLMap against an endpoint.

```sh title:"Run GraphQLMap"
graphqlmap -u "$url"
```
<!-- cheat
var url
-->
