#!/usr/bin/export sh

sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories
apk --no-cache add build-base automake wget curl autoconf

cd /

BITCOIN_VERSION=0.21.1
BITCOIN_PREFIX=/opt/bitcoin-${BITCOIN_VERSION}

wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}.tar.gz && tar -xzf bitcoin-${BITCOIN_VERSION}.tar.gz

cd /bitcoin-${BITCOIN_VERSION}/depends
TRIPLE=$(sh config.guess)
make -j$(nproc) NO_QR=1 NO_WALLET=1 NO_QT=1 NO_BDB=1 NO_SQLITE=1

cd /bitcoin-${BITCOIN_VERSION}

sed -i '/AC_PREREQ/a\AR_FLAGS=cr' src/univalue/configure.ac && \
    sed -i '/AX_PROG_CC_FOR_BUILD/a\AR_FLAGS=cr' src/secp256k1/configure.ac && \
    sed -i s:sys/fcntl.h:fcntl.h: src/compat.h


export CONFIG_SITE=/bitcoin-${BITCOIN_VERSION}/depends/$TRIPLE/share/config.site

./autogen.sh
./configure \
    LDFLAGS=-L`ls -d /opt/db*`/lib/ \
    CPPFLAGS=-I`ls -d /opt/db*`/include/ \
    CXXFLAGS="-O3" \
    --prefix=${BITCOIN_PREFIX} \
    --mandir=/usr/share/man \
    --disable-tests \
    --disable-bench \
    --disable-ccache \
    --disable-wallet \
    --without-gui \
    --with-utils \
    --with-libs \
    --with-daemon
make -j4
make install


strip ${BITCOIN_PREFIX}/bin/bitcoin-cli
strip ${BITCOIN_PREFIX}/bin/bitcoin-tx
strip ${BITCOIN_PREFIX}/bin/bitcoind
strip ${BITCOIN_PREFIX}/lib/libbitcoinconsensus.a
strip ${BITCOIN_PREFIX}/lib/libbitcoinconsensus.so.0.0.0