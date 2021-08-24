FROM alpine:latest

RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories
RUN apk --no-cache add autoconf automake build-base libressl boost-dev chrpath wget file gnupg libevent-dev libtool linux-headers zeromq-dev

ENV BERKELEYDB_VERSION=db-4.8.30.NC
ENV BERKELEYDB_PREFIX=/opt/${BERKELEYDB_VERSION}

WORKDIR /
RUN wget https://download.oracle.com/berkeley-db/${BERKELEYDB_VERSION}.tar.gz && \
    tar -xzf ${BERKELEYDB_VERSION}.tar.gz && \
    sed s/__atomic_compare_exchange/__atomic_compare_exchange_db/g -i ${BERKELEYDB_VERSION}/dbinc/atomic.h && \
    mkdir -p ${BERKELEYDB_PREFIX}
WORKDIR /${BERKELEYDB_VERSION}/build_unix    
RUN ../dist/configure --enable-cxx --disable-shared --with-pic --prefix=${BERKELEYDB_PREFIX}
RUN make -j4
RUN make install

WORKDIR /
ENV BITCOIN_VERSION=0.21.1
ENV BITCOIN_PREFIX=/opt/bitcoin-${BITCOIN_VERSION}

RUN wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}.tar.gz && tar -xzf bitcoin-${BITCOIN_VERSION}.tar.gz
WORKDIR /bitcoin-${BITCOIN_VERSION}

RUN sed -i '/AC_PREREQ/a\AR_FLAGS=cr' src/univalue/configure.ac && \
    sed -i '/AX_PROG_CC_FOR_BUILD/a\AR_FLAGS=cr' src/secp256k1/configure.ac && \
    sed -i s:sys/fcntl.h:fcntl.h: src/compat.h
RUN ./autogen.sh && \
    ./configure \
    LDFLAGS=-L`ls -d /opt/db*`/lib/ \
    CPPFLAGS=-I`ls -d /opt/db*`/include/ \
    --prefix=${BITCOIN_PREFIX} \
    --mandir=/usr/share/man \
    --disable-tests \
    --disable-bench \
    --disable-ccache \
    --with-gui=no \
    --with-utils \
    --with-libs \
    --with-daemon
RUN make -j4
RUN make install
RUN strip ${BITCOIN_PREFIX}/bin/bitcoin-cli
RUN strip ${BITCOIN_PREFIX}/bin/bitcoin-tx
RUN strip ${BITCOIN_PREFIX}/bin/bitcoind
RUN strip ${BITCOIN_PREFIX}/lib/libbitcoinconsensus.a
RUN strip ${BITCOIN_PREFIX}/lib/libbitcoinconsensus.so.0.0.0
