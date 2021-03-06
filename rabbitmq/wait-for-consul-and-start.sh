#!/bin/bash

# Modify consul host if you plain to use other name
# hostname must be exactly the same in docker compose file, or curl will always get DNS resolve error.
CONSUL_HOST=consul


# 1. Check consul service
until curl get http://${CONSUL_HOST}:8500/v1/agent/services ; do
    >&2 echo "[$(date +'%Y/%m/%d %T')] Consul - Service for RabbitMQ auto cluster is unavailable, sleep 10 seconds."
    sleep 10
done
>&2 echo "[$(date +'%Y/%m/%d %T')] Consul - Service for RabbitMQ auto cluster is available, start RabbitMQ Server."


# 2. Start RabbitMQ service, must use EntryPoint shell script trigger service, official repository does not mention it !!
/usr/local/bin/docker-entrypoint.sh rabbitmq-server
