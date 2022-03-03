FROM golang:1.16-buster as builder

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt upgrade -y && apt install git curl golang build-essential -y

RUN git clone https://github.com/maticnetwork/bor /workdir

WORKDIR /workdir

RUN make bor-all



FROM debian:10-slim

COPY --from=builder /workdir/build/bin/* /usr/local/bin/

RUN mkdir /datadir
RUN mkdir /ancient

COPY genesis.json /genesis.json

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN useradd user
USER user
RUN chown user /datadir && chown user /ancient

EXPOSE 8545 8546 30303 30303/udp


ENTRYPOINT ["/entrypoint.sh"]