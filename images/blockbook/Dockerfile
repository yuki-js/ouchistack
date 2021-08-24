FROM golang:1.16.3-alpine as builder

ARG COIN=btc


RUN apk add --no-cache git make gcc gflags-dev zlib-dev lz4-dev bzip2-dev snappy-dev zstd-dev libzmq

# build rocksdb
RUN git clone https://github.com/facebook/rocksdb.git && \
    cd rocksdb && \
    git checkout v6.8.1 && \
    CFLAGS=-fPIC CXXFLAGS=-fPIC make release
    
ENV CGO_CFLAGS="-I/usr/local/include"
ENV CGO_LDFLAGS="-L/usr/local/lib -lrocksdb -lstdc++ -lm -lz -ldl -lbz2 -lsnappy -llz4"

# build blockbook
WORKDIR $GOPATH/src
RUN git clone https://github.com/trezor/blockbook.git
RUN cd blockbook && go build
