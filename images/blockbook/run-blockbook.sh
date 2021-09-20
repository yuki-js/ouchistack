#!/usr/bin/env sh

exec /blockbook/blockbook -sync -blockchaincfg /chaincfg.json -datadir /data -internal :9000 -public :8000 -log_dir /log "$@"