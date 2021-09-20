FROM ghcr.io/yuki-js/ouchistack/blockbook:base as builder

# build blockbook
RUN mkdir -p $GOPATH/src/github.com/trezor && \
    cd $GOPATH/src/github.com/trezor && \
    git clone https://github.com/trezor/blockbook.git
WORKDIR $GOPATH/src/github.com/trezor/blockbook
RUN go build -ldflags "-s -w"
RUN strip /go/src/github.com/trezor/blockbook/blockbook

FROM alpine:latest
RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories
RUN apk update
RUN apk add --no-cache zeromq lz4-libs libbz2 snappy gflags zstd-libs

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY --from=builder /go/src/github.com/trezor/blockbook/blockbook /blockbook/blockbook
COPY --from=builder /usr/local/lib/librocksdb.so.6.8 /usr/local/lib/librocksdb.so.6.8

RUN mkdir -p /go/src/github.com/trezor/blockbook/build/text/
RUN echo "Blockbook on ouchistack" > /go/src/github.com/trezor/blockbook/build/text/about
RUN echo "http://example.com" > /go/src/github.com/trezor/blockbook/build/text/tos_link


COPY ./run-blockbook.sh /run-blockbook.sh
RUN chmod +x /run-blockbook.sh
RUN adduser -S user
RUN mkdir /data
RUN chown user /data
USER user
RUN mkdir /data/blocks


VOLUME /data

# external port
EXPOSE 8000
# internal port
EXPOSE 9000

ENTRYPOINT ["/run-blockbook.sh"]
