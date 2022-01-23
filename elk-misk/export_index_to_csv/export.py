#!/usr/bin/python3

# Requirements:
#  - elasticsearch (pip3 install elasticsearch)

# How to start:
# python3 <script>.py -i <index/alias> -f log -s <session> -h <host>
#
# Note: The output is not sorted and needs additional sorting!

import json
import sys
import elasticsearch
from elasticsearch import helpers
from elasticsearch import Elasticsearch
import getopt

fields = None
index = None
sessionID = None
queryJSON = None
host = None

#global queryJSON

queryJSON = """
{
   "query": {
	"bool": {
	  "must": [
		{
		  "range": {
			"@timestamp": {
			  "gte": "now-1d/d",
			  "lte": "now/d"
			}
		  }
		},
		{
			"match_phrase" : {
				"log" : {
					"query" : "Booking event processing time",
					"analyzer" : "standard"
				}
			}
		}
	  ]
	}
  }
}
"""


def export(docType, queryJson='{}', fields="logger", delimiter=","):
    # Define and set Elasticsearch host
    es = Elasticsearch("http://es.sofia.ifao.net:9200")

    # Define and set query for Elasticsearch
    query = json.loads(queryJson)

    # Assign and split found fields by comma
    fields = fields.split(",")

    # Set handler to Elasticsearch
    elasticsearchHelper = helpers.scan(client=es, query=query, scroll="10m", index="ccbd.app.*",
                                        size=2000, doc_type=docType, clear_scroll=True, request_timeout=3000)
    # Init new dictionary

    items = dict()
    t = False
    with open('output.txt', 'w') as f:
      sys.stdout = f # Change the standard output to the file we created.
      try:
          for row in elasticsearchHelper:
              for key, value in row['_source'].items():
                  if key in ('log', '@timestamp'):
                      items[key] = value
                      if t:
                          lineItem = str(items)
                          print(lineItem)
                      t = True
              t = False     
      except elasticsearch.exceptions.NotFoundError:
          print("Not found!")
          sys.exit(4)
      except elasticsearch.exceptions.RequestError:
          print("Request error!")
          sys.exit(5)

export("doc", queryJSON, "@timestamp", ",")
