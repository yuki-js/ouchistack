FROM debian:11-slim
RUN apt-get update &&  apt-get install -y wget


RUN if [ "$(uname -m)" = "aarch64" ]; then \
      wget https://github.com/BitzenyCoreDevelopers/bitzeny/releases/download/z2.0.2/bitzeny-2.0.2-aarch64-linux-gnu.tar.gz; \
      tar -zvxf bitzeny-2.0.2-aarch64-linux-gnu.tar.gz; \
    else \
      wget https://github.com/BitzenyCoreDevelopers/bitzeny/releases/download/z2.0.2/bitzeny-2.0.2-x86_64-linux-gnu.tar.gz; \
      tar -zvxf bitzeny-2.0.2-x86_64-linux-gnu.tar.gz; \
    fi

RUN cp -r /bitzeny-2.0.2/* /usr/local/ && \
    rm -rf bitzeny-2.0.2* && \
    rm -rf /bitzeny-2.0.2

RUN adduser user
RUN mkdir /data
RUN chown user /data

COPY ./bitzeny.conf /bitzeny.conf
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
USER user

# RPC (internal use only)
EXPOSE 8332
# P2P (internal use only)
EXPOSE 8333
# ZMQ (internal use only)
EXPOSE 28332

VOLUME ["/data"]

ENTRYPOINT ["/entrypoint.sh"]