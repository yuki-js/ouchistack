#!/usr/bin/env sh

if [ ! -f $HEIMDALL_DIR/config/node_key.json ]; then
    heimdalld --home=$HEIMDALL_DIR --with-heimdall-config /heimdall-config.toml init
fi

if [ "$1" = 'bridge' ]; then
    shift
    exec bridge --home=$HEIMDALL_DIR --with-heimdall-config /heimdall-config.toml "$@"
fi

if [ "$1" = 'heimdallcli' ]; then
    shift
    exec heimdallcli --home=$HEIMDALL_DIR --with-heimdall-config /heimdall-config.toml "$@"
fi

exec heimdalld --home=$HEIMDALL_DIR --with-heimdall-config /heimdall-config.toml "$@"