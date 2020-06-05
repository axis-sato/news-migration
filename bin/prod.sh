#! /bin/bash

cd "$(dirname "$0")/.."

RUN="docker-compose -f docker-compose_prod.yaml run --rm -e MYSQL_DATABASE=${MYSQL_DATABASE} -e MYSQL_USER=${MYSQL_USER} -e MYSQL_PASSWORD=${MYSQL_PASSWORD} workspace"

case $1 in
  "migrate") ${RUN} sql-migrate ${2} -env="production" --config=configs/dbconf.yml;;
  "migrate!") ${RUN} sql-migrate ${2} -env="production" --config=configs/dbconf.yml -limit=0;;
  "seed") ${RUN} go run cmd/seeder/main.go ;;
  "reset") ./bin/prod.sh migrate! down && ./bin/prod.sh migrate! up && ./bin/prod.sh seed;;
         *) docker-compose $@ ;;
esac