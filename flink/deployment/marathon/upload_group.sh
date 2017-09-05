#!/bin/bash

MARATHON_URL=marathon.grabdata.info:8080

curl -i -H 'Content-Type: application/json' -d @$1 http://ds-user:2e79bed1-1e62-48e0-ac3e-b51332484649@$MARATHON_URL/v2/apps?force=true
