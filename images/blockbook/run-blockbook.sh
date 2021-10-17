#!/usr/bin/env sh
cd /go/src/github.com/trezor/blockbook
rm /data/LOCK || true
exec /go/src/github.com/trezor/blockbook/blockbook -sync -blockchaincfg /chaincfg.json -datadir /data -internal :9000 -public :8000 -log_dir /log -workers=1 -dbcache=0 "$@"