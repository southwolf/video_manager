#!/usr/bin/env bash

docker-compose -f build/docker-compose/development.yml up

docker-compose -f build/docker-compose/development.yml stop
docker-compose -f build/docker-compose/development.yml rm -v -f