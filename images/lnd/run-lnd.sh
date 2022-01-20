#!/usr/bin/env sh
set -e

if [ -z "$RPCPASS" ]; then 
  RPCPASS=`cat /run/secrets/bitcoind_rpcpass`
fi

if [[ $NETWORK == "mainnet" ]]; then
  CHAIN="mainnet"
elif [[ $NETWORK == "testnet" ]]; then
  CHAIN="testnet"
elif [[ $NETWORK == "regtest" ]]; then
  CHAIN="regtest"
elif [[ $NETWORK == "simnet" ]]; then
  CHAIN="simnet"
elif [[ $NETWORK == "signet" ]]; then
  CHAIN="signet"
else
  echo "Unknown network: $NETWORK"
  exit 1
fi

sleep 3 # wait for bitcoind to start
exec /bin/lnd --configfile=/lnd.conf --bitcoin.$CHAIN --bitcoind.rpcpass="$RPCPASS" "$@" 