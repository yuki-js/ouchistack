FROM ghcr.io/yuki-js/ouchistack/bitzeny:base

USER user

VOLUME /data
# RPC port
EXPOSE 8332
# P2P port
EXPOSE 8333
# ZMQ raw block port
EXPOSE 28332 
# ZMQ raw tx port
EXPOSE 28333

ENTRYPOINT ["/usr/local/bin/bitzenyd"]