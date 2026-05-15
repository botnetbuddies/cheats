---
technique: Elasticsearch Enumeration
category: databases
targets: Elasticsearch
protocols: HTTP
remote_capable: true
tags: network-services elasticsearch database search
---

# Elasticsearch Enumeration

Elasticsearch enumeration checks open REST API access, cluster health, nodes, indices, templates, and searchable documents.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 9200 | Requires Elasticsearch HTTP reachability |
| Credentials | Security may require basic auth or token auth |
| Data care | Search endpoints can return sensitive application data |

## Linux

### Root endpoint

#sh #curl #elasticsearch

Read the Elasticsearch root endpoint.

```sh title:"Read Elasticsearch root endpoint"
curl -sk "$elastic_url/"
```
<!-- cheat
var elastic_url
-->

### Cluster health

#sh #curl #elasticsearch

Read cluster health.

```sh title:"Read Elasticsearch cluster health"
curl -sk "$elastic_url/_cluster/health?pretty"
```
<!-- cheat
var elastic_url
-->

### Indices

#sh #curl #elasticsearch

List Elasticsearch indices.

```sh title:"List Elasticsearch indices"
curl -sk "$elastic_url/_cat/indices?v"
```
<!-- cheat
var elastic_url
-->

### Nodes

#sh #curl #elasticsearch

List Elasticsearch nodes.

```sh title:"List Elasticsearch nodes"
curl -sk "$elastic_url/_cat/nodes?v"
```
<!-- cheat
var elastic_url
-->

### Index search

#sh #curl #elasticsearch

Search an index for a term.

```sh title:"Search Elasticsearch index"
curl -sk "$elastic_url/$index_name/_search?q=$query&pretty=true"
```
<!-- cheat
var elastic_url
var index_name
var query
-->
