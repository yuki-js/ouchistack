FROM golang:1.16-buster as builder

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt upgrade -y && apt install git curl golang build-essential -y

RUN git clone https://github.com/maticnetwork/heimdall /workdir

WORKDIR /workdir

RUN make build network=mainnet

FROM debian:10-slim

ENV HEIMDALL_DIR=/data

RUN mkdir /data
COPY --from=builder /workdir/build/heimdalld /usr/local/bin
COPY --from=builder /workdir/build/heimdallcli /usr/local/bin
COPY --from=builder /workdir/bridge /usr/local/bin
COPY config /data/config
COPY entrypoint.sh /entrypoint.sh


EXPOSE 1317 26656 26657
VOLUME ["/data"]

ENTRYPOINT ["/entrypoint.sh"]