FROM debian:10-slim as builder

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt upgrade -y && apt install git curl golang build-essential -y

RUN git clone https://github.com/maticnetwork/heimdall /workdir

WORKDIR /workdir

RUN make install network=mainnet

FROM debian:10-slim

ARG HEIMDALL_DIR=/heimdall
ENV HEIMDALL_DIR=$HEIMDALL_DIR

COPY --from=builder /workdir/heimdalld /usr/local/bin/
COPY --from=builder /workdir/heimdallcli /usr/local/bin/
COPY --from=builder /workdir/bridge /usr/local/bin/
COPY genesis-mainnet.json /heimdall


EXPOSE 1317 26656 26657

ENTRYPOINT ["entrypoint.sh"]