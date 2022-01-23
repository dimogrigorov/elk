#!/bin/sh


# Creates the Docker Swarm configuration in Raft database for Kibana
# This configuration is targeted to replace kibana.yml inside container
docker config create kibana kibana.yml

# Deploys entire new stack with 3 Kibana instances
# These instances are all connected to same endpoint because of FQDN
# - perhaps this should be replaced by local callback with 0:9200 because Elasticsearch coordination node is already exposed
docker stack deploy -c swarm-kibana.yml k
