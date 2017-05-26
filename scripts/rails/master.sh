#!/bin/bash

exec &>> $HOME/logs/rails/master/run.log

echo --------------$(date)

docker pull rubybench/rails_trunk

docker run --name postgres -d postgres:9.3.5
docker run --name mysql -e \"MYSQL_ALLOW_EMPTY_PASSWORD=yes\" -d mysql:5.6.24
docker run --name redis -d redis:2.8.19

COMMIT_HASH = $1
API_NAME = $2
API_PASSWORD = $3
PATTERNS = $4

docker run --rm \
  --link postgres:postgres \
  --link mysql:mysql \
  --link redis:redis \
  -e "RAILS_COMMIT_HASH=$COMMIT_HASH" \
  -e "API_NAME=$API_NAME" \
  -e "API_PASSWORD=$API_PASSWORD" \
  -e "MYSQL2_PREPARED_STATEMENTS=1" \
  $PATTERNS \
  rubybench/rails_trunk

docker stop postgres mysql redis
docker rm -v postgres mysql redis
