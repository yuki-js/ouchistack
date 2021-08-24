FROM alpine:3.13 as builder

RUN apk update
RUN apk add --no-cache zlib-dev bzip2-dev lz4-dev snappy-dev zstd-dev gflags-dev build-base linux-headers git bash perl
    
# build rocksdb
RUN git clone https://github.com/facebook/rocksdb.git && \
    cd rocksdb && \
    git checkout v6.8.1 && \
    CFLAGS=-fPIC CXXFLAGS=-fPIC make shared_lib && \
    sudo make install
    
ENV CGO_CFLAGS="-I/usr/local/include"
ENV CGO_LDFLAGS="-L/usr/local/lib -lrocksdb -lstdc++ -lm -lz -ldl -lbz2 -lsnappy -llz4"

# build blockbook
WORKDIR $GOPATH/src
RUN git clone https://github.com/trezor/blockbook.git
RUN cd blockbook && go build
