FROM debian:stretch as debian
MAINTAINER LeBleu :: ZcashFR.io

ENV     ZCASH_URL=https://github.com/zcash/zcash.git \
        ZCASH_VERSION=v3.0.0 \
        ZCASH_CONF=/home/zcash/.zcash/zcash.conf


RUN apt-get update && apt-get -y install \
    build-essential pkg-config libc6-dev m4 \
    autoconf libtool ncurses-dev unzip git python python-zmq \
    zlib1g-dev wget curl bsdmainutils automake &&\
    mkdir -p /src/zcash/; cd /src/zcash; \
    git clone ${ZCASH_URL} zcash && cd zcash && git checkout ${ZCASH_VERSION}

RUN ln -s /usr/bin/g++ /usr/bin/aarch64-unknown-linux-gnu-g++

RUN ./zcutil/build.sh -j$(nproc) && \
    echo "Success"

FROM debian:stretch-slim

COPY --from=debian /src/zcash/zcash/src/zcash-cli /usr/local/bin/zcash-cli
COPY --from=debian /src/zcash/zcash/src/zcashd /usr/local/bin/zcashd
COPY --from=debian /src/zcash/zcash/src/zcash-gtest /usr/local/bin/zcash-gtest
COPY --from=debian /src/zcash/zcash/src/zcash-tx /usr/local/bin/zcash-tx
COPY --from=debian /src/zcash/zcash/zcutil/fetch-params.sh /usr/local/bin/fetch-params.sh


RUN useradd user
RUN mkdir /data
RUN chown user /data

COPY ./zcash.conf /zcash.conf
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