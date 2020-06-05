#! /bin/bash

cd "$(dirname "$0")/.."

case $1 in
  "migrate") docker-compose exec workspace sql-migrate ${2} -env="development.docker" --config=configs/dbconf.yml;;
  "migrate!") docker-compose exec workspace sql-migrate ${2} -env="development.docker" --config=configs/dbconf.yml -limit=0;;
  "seed") docker-compose exec workspace go run cmd/seeder/main.go ;;
  "reset") ./bin/dev.sh migrate! down && ./bin/dev.sh migrate! up && ./bin/dev.sh seed;;
         *) docker-compose $@ ;;
esac