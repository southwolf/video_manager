#!/usr/bin/env bash

docker-compose -f build/docker-compose/test.yml run --rm api

result=$?

docker-compose -f build/docker-compose/test.yml stop
docker-compose -f build/docker-compose/test.yml rm -v -f

exit $result