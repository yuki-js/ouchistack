#!/usr/bin/env sh

if [[ $NETWORK == "mainnet" ]]; then
  CHAIN="mainnet"
elif [[ $NETWORK == "testnet" ]]; then
  CHAIN="testnet"
  echo "Unknown network: $NETWORK"
  exit 1
fi

exec /usr/local/bin/zcashd -conf=/zcash.conf -$CHAIN "$@"