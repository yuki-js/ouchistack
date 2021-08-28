FROM debian:11-slim
RUN apt-get update &&  apt-get install -y wget
RUN wget https://github.com/BitzenyCoreDevelopers/bitzeny/releases/download/z2.0.2/bitzeny-2.0.2-x86_64-linux-gnu.tar.gz && \
    tar -zvxf bitzeny-2.0.2-x86_64-linux-gnu.tar.gz && \
    mv /bitzeny-2.0.2 /usr/local && \
    rm bitzeny-2.0.2-x86_64-linux-gnu.tar.gz

ENTRYPOINT ["/usr/local/bin/bitzenyd"]