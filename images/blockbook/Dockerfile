FROM golang:1.16.3-alpine as builder

RUN apk add --no-cache build-base git zlib-dev lz4-dev bzip2-dev snappy-dev zstd-dev libzmq

RUN cd /tmp && \
    git clone https://github.com/gflags/gflags.git && \
    cd gflags && \
    mkdir build && \
    cd build && \
    cmake -DBUILD_SHARED_LIBS=1 -DGFLAGS_INSTALL_SHARED_LIBS=1 .. && \
    make install && \
    cd /tmp && \
    rm -R /tmp/gflags/
    
# build rocksdb
RUN git clone https://github.com/facebook/rocksdb.git && \
    cd rocksdb && \
    git checkout v6.8.1 && \
    CFLAGS=-fPIC CXXFLAGS=-fPIC make release && \
    sudo make install
    
ENV CGO_CFLAGS="-I/usr/local/include"
ENV CGO_LDFLAGS="-L/usr/local/lib -lrocksdb -lstdc++ -lm -lz -ldl -lbz2 -lsnappy -llz4"

# build blockbook
WORKDIR $GOPATH/src
RUN git clone https://github.com/trezor/blockbook.git
RUN cd blockbook && go build
