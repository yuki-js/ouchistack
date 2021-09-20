FROM ghcr.io/yuki-js/ouchistack/monacoin-core:base

# RPC (internal use only)
EXPOSE 8332
# P2P (internal use only)
EXPOSE 8333
# ZMQ (internal use only)
EXPOSE 28332

VOLUME ["/data"]

USER root
COPY ./monacoin.conf /monacoin.conf
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
USER user
RUN mkdir /data/blocks

ENTRYPOINT ["/entrypoint.sh"]