#!/usr/bin/env sh

# set working directory to this script's directory
cd "$(dirname "$0")"

# the list of arguments to pass to docker compose
ARGS=""
STACKS=stacks/*.yml

for STACK in $STACKS; do
  ARGS="${ARGS} -c ${STACK}"
done

docker stack deploy ${ARGS} ouchistack