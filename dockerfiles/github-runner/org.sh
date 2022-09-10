#!/bin/bash
source default.env

OS=$(uname)
ARCH=$(uname -m)
LABELS=$OS-$ARCH

COMPOSE=docker-compose-mac.yml
if [ $ARCH == 'x86_64' ]; then
  COMPOSE=docker-compose.yml
fi

ORG_NAME=$1
RUNNER_SCOPE=org
DOCKER_NAME=github-runner-$ORG_NAME
RUNNER_WORKDIR=/tmp/$DOCKER_NAME

mkdir "$ORG_NAME"

cat << EOF > "$ORG_NAME/repo.env"
ORG_NAME=$ORG_NAME
RUNNER_SCOPE=$RUNNER_SCOPE
DOCKER_NAME=$DOCKER_NAME
RUNNER_WORKDIR=$RUNNER_WORKDIR
LABELS=$LABELS
EOF

cp $COMPOSE "$ORG_NAME/docker-compose.yml"

ln -s ../compose.sh "$ORG_NAME/compose.sh"
