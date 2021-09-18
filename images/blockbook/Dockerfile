FROM ghcr.io/yuki-js/ouchistack/blockbook:base as builder

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

COPY --from=builder /go/src/github.com/trezor/blockbook /usr/local/blockbook
COPY --from=builder /usr/local/lib/librocksdb.so.6.8 /usr/local/lib/librocksdb.so.6.8
# expose internal and external port
EXPOSE 8000 9000

ENTRYPOINT ["/usr/local/blockbook/bin/blockbook"]
