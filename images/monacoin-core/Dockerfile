FROM ghcr.io/yuki-js/ouchistack/coind-builder:latest as builder

WORKDIR /
ENV MONACOIN_PREFIX=/opt/monacoin

RUN wget https://github.com/monacoinproject/monacoin/archive/refs/tags/monacoin-0.17.1.tar.gz && \
    tar -xzf monacoin-0.17.1.tar.gz

WORKDIR /monacoin-monacoin-0.17.1

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
