#!/bin/bash

export HOST_UID=$(id -u) && export HOST_GID=$(id -g)
docker compose down
rm -rf clickhouse/logs/*.log
