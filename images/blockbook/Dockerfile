FROM alpine:latest as builder

RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories
RUN apk update
RUN apk add --no-cache wget zlib-dev bzip2-dev lz4-dev snappy-dev zstd-dev gflags-dev build-base linux-headers git bash perl zeromq-dev

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

# build rocksdb
WORKDIR /workdir
RUN git clone https://github.com/facebook/rocksdb.git
WORKDIR /workdir/rocksdb
RUN git checkout v6.8.1 && \
    CFLAGS=-fPIC CXXFLAGS=-fPIC make -j$(nproc) shared_lib
RUN sed -i 's/install -C/install -c/g' Makefile && \
    make install-shared

# install go
RUN wget https://golang.org/dl/go1.14.2.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.14.2.linux-amd64.tar.gz && rm go1.14.2.linux-amd64.tar.gz
ENV GOPATH=$HOME/go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

ENV CGO_CFLAGS="-I/usr/local/include"
ENV CGO_LDFLAGS="-L/usr/local/lib -lrocksdb -lstdc++ -lm -lz -ldl -lbz2 -lsnappy -llz4"

# build blockbook
RUN mkdir -p $GOPATH/src/github.com/trezor && \
    cd $GOPATH/src/github.com/trezor && \
    git clone https://github.com/trezor/blockbook.git
WORKDIR $GOPATH/src/github.com/trezor/blockbook
RUN go build -ldflags "-s -w"

FROM alpine:latest
RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories
RUN apk update
RUN apk add --no-cache zeromq

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY --from=builder /go/src/github.com/trezor/blockbook /usr/local/bin/blockbook

# expose internal and external port
EXPOSE 8000 9000

ENTRYPOINT ["/usr/local/bin/blockbook"]
