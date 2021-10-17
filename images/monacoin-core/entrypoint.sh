#!/usr/bin/env bash

if [[ $NETWORK == "mainnet" ]]; then
  CHAIN="main"
elif [[ $NETWORK == "testnet" ]]; then
  CHAIN="test"
elif [[ $NETWORK == "regtest" ]]; then
  CHAIN="regtest"
elif [[ $NETWORK == "simnet" ]]; then
  CHAIN="simnet"
else
  echo "Unknown network: $NETWORK"
  exit 1
fi

exec /usr/bin/monacoind -conf=/monacoin.conf -chain=$CHAIN "$@"