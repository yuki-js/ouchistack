FROM ghcr.io/yuki-js/ouchistack/bitcoin-core:base

# RPC (internal use only)
EXPOSE 8332
# P2P (internal use only)
EXPOSE 8333
# ZMQ (internal use only)
EXPOSE 28332

VOLUME ["/data"]

USER root
COPY ./bitcoin.conf /bitcoin.conf
COPY ./run-bitcoind.sh /run-bitcoind.sh
RUN chmod +x /run-bitcoind.sh
USER user
RUN mkdir /data/blocks

ENTRYPOINT ["/run-bitcoind.sh"]