#!/bin/bash
source default.env

OS=$(uname)
ARCH=$(uname -m)
LABELS=$OS-$ARCH

COMPOSE=docker-compose-mac.yml
if [ $ARCH == 'x86_64' ]; then
  COMPOSE=docker-compose.yml
fi

OWNER=$1
REPO=$2
REPO_NAME=$OWNER-$REPO
DOCKER_NAME=github-runner-$REPO_NAME
REPO_URL=https://github.com/$OWNER/$REPO
RUNNER_WORKDIR=/tmp/$DOCKER_NAME

mkdir "$REPO_NAME"

cat << EOF > "$REPO_NAME/repo.env"
DOCKER_NAME=$DOCKER_NAME
RUNNER_WORKDIR=$RUNNER_WORKDIR
REPO_URL=$REPO_URL
LABELS=$LABELS
EOF

cp $COMPOSE "$REPO_NAME"

ln -s ../compose.sh "$REPO_NAME/compose.sh"
