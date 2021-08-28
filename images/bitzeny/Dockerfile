FROM alpine:latest as builder

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
RUN make -j$(nproc)
RUN make install

WORKDIR /
ENV BITZENY_PREFIX=/opt/bitzeny

RUN mkdir /bitzeny-source && \
    wget https://github.com/BitzenyCoreDevelopers/bitzeny/archive/refs/tags/z2.0.2.tar.gz && \
    tar -C /bitzeny-source -xzf bitzeny-z2.0.2.tar.gz

WORKDIR /bitzeny-source

RUN sed -i '/AC_PREREQ/a\AR_FLAGS=cr' src/univalue/configure.ac && \
    sed -i '/AX_PROG_CC_FOR_BUILD/a\AR_FLAGS=cr' src/secp256k1/configure.ac && \
    sed -i s:sys/fcntl.h:fcntl.h: src/compat.h
RUN ./autogen.sh && \
    ./configure \
    LDFLAGS=-L`ls -d /opt/db*`/lib/ \
    CPPFLAGS=-I`ls -d /opt/db*`/include/ \
    --prefix=${BITZENY_PREFIX} \
    --mandir=/usr/share/man \
    --disable-tests \
    --disable-bench \
    --disable-ccache \
    --with-gui=no \
    --with-utils \
    --with-libs \
    --with-daemon
RUN make -j$(nproc)
RUN make install
RUN strip ${BITZENY_PREFIX}/bin/bitzeny-cli
RUN strip ${BITZENY_PREFIX}/bin/bitzeny-tx
RUN strip ${BITZENY_PREFIX}/bin/bitzenyd
RUN strip ${BITZENY_PREFIX}/lib/libbitzenyconsensus.a
RUN strip ${BITZENY_PREFIX}/lib/libbitzenyconsensus.so.0.0.0


FROM alpine

ENV BITZENY_DATA=/home/bitzeny/.bitzeny
ENV BITZENY_PREFIX=/opt/bitzeny

COPY --from=builder ${BITZENY_PREFIX}/bin/bitzenyd /usr/bin/bitzenyd
COPY --from=builder ${BITZENY_PREFIX}/bin/bitzeny-cli /usr/bin/bitzeny-cli


RUN adduser -S bitzeny
USER bitzeny

VOLUME ["/home/bitzeny/.bitzeny"]

EXPOSE 8332 8333 18332 18333 18444

ENTRYPOINT ["/usr/bin/bitzenyd"]
