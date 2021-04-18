#!/usr/bin/env bash

set -e

cd $(dirname "$BASH_SOURCE")

docker-compose up -d 

docker exec -it ubuntu bash -c "apt update && apt install -y python"

ansible-playbook playbook/site.yml --vault-password-file password -i playbook/inventory/prod.yml

docker-compose down
