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
ENV MONACOIN_VERSION=0.17.1
ENV MONACOIN_PREFIX=/opt/monacoin-${MONACOIN_VERSION}
RUN wget https://github.com/monacoinproject/monacoin/releases/download/monacoin-${MONACOIN_VERSION}/monacoin-${MONACOIN_VERSION}-x86_64-linux-gnu.tar.gz && \
    tar -xzf monacoin-${MONACOIN_VERSION}-x86_64-linux-gnu.tar.gz 

RUN sed -i '/AC_PREREQ/a\AR_FLAGS=cr' src/univalue/configure.ac && \
    sed -i '/AX_PROG_CC_FOR_BUILD/a\AR_FLAGS=cr' src/secp256k1/configure.ac && \
    sed -i s:sys/fcntl.h:fcntl.h: src/compat.h
RUN ./autogen.sh && \
    ./configure \
    LDFLAGS=-L`ls -d /opt/db*`/lib/ \
    CPPFLAGS=-I`ls -d /opt/db*`/include/ \
    --prefix=${MONACOIN_PREFIX} \
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
RUN strip ${MONACOIN_PREFIX}/bin/monacoin-cli
RUN strip ${MONACOIN_PREFIX}/bin/monacoin-tx
RUN strip ${MONACOIN_PREFIX}/bin/monacoind
RUN strip ${MONACOIN_PREFIX}/lib/libmonacoinconsensus.a
RUN strip ${MONACOIN_PREFIX}/lib/libmonacoinconsensus.so.0.0.0


FROM alpine

ENV MONACOIN_DATA=/home/monacoin/.monacoin
ENV MONACOIN_VERSION=0.17.1
ENV MONACOIN_PREFIX=/opt/monacoin-${MONACOIN_VERSION}

COPY --from=builder ${MONACOIN_PREFIX}/bin/monacoind /usr/bin/monacoind
COPY --from=builder ${MONACOIN_PREFIX}/bin/monacoin-cli /usr/bin/monacoin-cli


RUN adduser -S monacoin
USER monacoin

VOLUME ["/home/monacoin/.monacoin"]

EXPOSE 8332 8333 18332 18333 18444

ENTRYPOINT ["/usr/bin/monacoind"]
