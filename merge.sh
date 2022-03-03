#!/usr/bin/env sh

# set working directory to this script's directory
cd "$(dirname "$0")"

# usage
usage() {
  echo "Usage: STACKS=stack_list $0 [command/args]"
  echo "  command/args: arguments to pass to compose"
  echo "    will be up|down|restart|ps|etc."
  exit 1
}

# the list of arguments to pass to docker compose
ARGS=""
STACKS=stacks/*.yml

for STACK in $STACKS; do
  ARGS="${ARGS} -c ${STACK}"
done

docker stack deploy ${ARGS} ouchistack