#!/bin/sh

# Get node attributes defined by Elasticsearch.yml
curl -XGET "http://localhost:9200/_cat/nodeattrs?v"

# Analyze that index doesn't have any restrictions regarding node preferences and where it should live
curl -XGET "http://localhost:9200/indexname/_settings"

# Get all permissions of the index and its 0 shard
curl -XGET "http://localhost:9200/_cluster/allocation/explain" -H 'Content-Type: application/json' -d'
{
  "index": "indexname",
  "shard": 0,
  "primary": true
}'

# Move entire index to this node
# This includes also shards because it applies policy to enabled node
# Note, storage=hot/cold/no are defined in elasticsearch.yml of each node
curl -XPUT "http://localhost:9200/indexname/_settings" -H 'Content-Type: application/json' -d'
{
	"index.routing.allocation.include._name" : "elastic4",
	"index.routing.allocation.include.storage": "cold"
}'