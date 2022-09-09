#!/bin/bash
source ../default.env
source repo.env

export DOCKER_NAME
export RUNNER_WORKDIR

docker-compose "$@"