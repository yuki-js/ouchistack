FROM alpine:3.13 as builder

RUN apk update
RUN apk add --no-cache wget zlib-dev bzip2-dev lz4-dev snappy-dev zstd-dev gflags-dev build-base linux-headers git bash perl
    
# build rocksdb
WORKDIR /workdir
RUN git clone https://github.com/facebook/rocksdb.git
WORKDIR /workdir/rocksdb
RUN git checkout v6.8.1 && \
    CFLAGS=-fPIC CXXFLAGS=-fPIC make release
RUN sed -i 's/install -C/install -c/g' Makefile && \
    make install

# install go
RUN wget https://golang.org/dl/go1.14.2.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.14.2.linux-amd64.tar.gz
ENV GOPATH=$HOME/go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

ENV CGO_CFLAGS="-I/usr/local/include"
ENV CGO_LDFLAGS="-L/usr/local/lib -lrocksdb -lstdc++ -lm -lz -ldl -lbz2 -lsnappy -llz4"

# build blockbook
RUN mkdir -p $GOPATH/src/github.com/trezor && \
    cd $GOPATH/src/github.com/trezor && \
    git clone https://github.com/trezor/blockbook.git
WORKDIR $GOPATH/src/github.com/trezor/blockbook
RUN /usr/local/go/bin/go build
