FROM alpine:latest

RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories
RUN apk --no-cache add autoconf automake build-base libressl libressl-dev boost-dev chrpath wget file gnupg libevent-dev libtool linux-headers zeromq-dev

ENV BERKELEYDB_VERSION=db-4.8.30.NC
ENV BERKELEYDB_PREFIX=/opt/${BERKELEYDB_VERSION}

WORKDIR /
RUN wget https://download.oracle.com/berkeley-db/${BERKELEYDB_VERSION}.tar.gz && \
    tar -xzf ${BERKELEYDB_VERSION}.tar.gz && \
    sed s/__atomic_compare_exchange/__atomic_compare_exchange_db/g -i ${BERKELEYDB_VERSION}/dbinc/atomic.h && \
    mkdir -p ${BERKELEYDB_PREFIX}
WORKDIR /${BERKELEYDB_VERSION}/build_unix    
RUN ../dist/configure --enable-cxx --disable-shared --with-pic --prefix=${BERKELEYDB_PREFIX}
RUN make -j$(nproc)
RUN make install
