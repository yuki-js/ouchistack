FROM debian:11-slim
RUN apt-get update &&  apt-get install -y wget


RUN if [ "$(uname -m)" = "aarch64" ]; then \
      wget https://github.com/monacoinproject/monacoin/releases/download/monacoin-0.17.1/monacoin-0.17.1-aarch64-linux-gnu.tar.gz; \
      tar -zvxf monacoin-0.17.1-aarch64-linux-gnu.tar.gz; \
    else \
      wget https://github.com/monacoinproject/monacoin/releases/download/monacoin-0.17.1/monacoin-0.17.1-x86_64-linux-gnu.tar.gz; \
      tar -zvxf monacoin-0.17.1-x86_64-linux-gnu.tar.gz; \
    fi


RUN cp -r /monacoin-0.17.1/* /usr/local/ && \
    rm -rf /monacoin-0.17.1* && \
    rm -rf /monacoin-0.17.1

RUN adduser user
RUN mkdir /data
RUN chown user /data

COPY ./monacoin.conf /monacoin.conf
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