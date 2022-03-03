#!/usr/bin/env sh
exec geth --datadir=/datadir --datadir.ancient=/ancient \
     --http --http.addr 0.0.0.0 --http.port 8545 \
     --ws --ws.addr 0.0.0.0 --ws.port 8546 \
     --ipcpath /datadir/geth.ipc \
     --http.vhosts "*" --http.corsdomain "*"