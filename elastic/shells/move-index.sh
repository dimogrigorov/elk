#!/bin/sh

# Move index from node to node and also locks its shards (which are moved)
# This also locks the index to work on this IP only

curl -XPOST "http://elastic0:9200/_cluster/reroute" -H 'Content-Type: application/json' -d'
{
  "commands": [
    {
      "move": {
        "index": "indexname",
        "shard": 0,
        "from_node": "elastic1",
        "to_node": "elastic4"
      }
    }
  ]
}'

curl -XPUT "http://localhost:9200/indexname/_settings" -H 'Content-Type: application/json' -d'
{
	"index.routing.allocation.include._ip" : "192.168.112.7"
}'