FROM alpine:latest as builder

COPY ./build.sh /build.sh
RUN chmod +x /build.sh
RUN /build.sh

FROM alpine

ENV BITCOIN_VERSION=0.21.1
ENV BITCOIN_PREFIX=/opt/bitcoin-${BITCOIN_VERSION}

COPY --from=builder ${BITCOIN_PREFIX}/bin/bitcoind /usr/bin/bitcoind
COPY --from=builder ${BITCOIN_PREFIX}/bin/bitcoin-cli /usr/bin/bitcoin-cli

RUN apk add --no-cache boost libsodium libevent

RUN adduser -S user
RUN mkdir /data
RUN chown user /data

COPY ./bitcoin.conf /bitcoin.conf
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 555 /entrypoint.sh

USER user

RUN mkdir /data/blocks

VOLUME /data
# RPC port
EXPOSE 8332
# P2P port
EXPOSE 8333
# ZMQ 
EXPOSE 28332 
# ZMQ (mirrored, for compatibility with lnd)
EXPOSE 28333

ENTRYPOINT ["/entrypoint.sh"]