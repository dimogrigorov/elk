#!/bin/sh

# Arguments:
#  - $1 - username
#  - $2 - password
#  - $3 - Jenkins url
#  - $4 - Jenkins port
#  - $5 - job name

curl -s http:///$1:$2@$3:$4/job/$5/config.xml > $5.xml