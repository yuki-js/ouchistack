#!/usr/bin/env sh

exec /go/src/github.com/trezor/blockbook/blockbook -sync -blockchaincfg /chaincfg.json -datadir /data -internal :9000 -public :8000 -log_dir /log "$@"