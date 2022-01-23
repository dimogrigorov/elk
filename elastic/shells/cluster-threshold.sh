#!/bin/sh

# Make cluster threshold enabled and up to 90%
# Note, this should be executed when loggen into the VM where cluster is hosted

curl -XPUT "http://localhost:9200/_cluster/settings" -H 'Content-Type: application/json' -d'
{
  "persistent": {
    "cluster.routing.allocation.disk.threshold_enabled": true,
    "cluster.routing.allocation.disk.watermark.high": "90%",
    "cluster.info.update.interval": "1m"
  }
}'