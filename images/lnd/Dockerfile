FROM golang:alpine3.12 as builder

LABEL from="https://github.com/lightningnetwork/lnd/blob/master/dev.Dockerfile"

# Force Go to use the cgo based DNS resolver. This is required to ensure DNS
# queries required to connect to linked containers succeed.
ENV GODEBUG netdns=cgo

ARG checkout="v0.13.3-beta"

# Install dependencies and install/build lnd.
RUN apk add --no-cache --update alpine-sdk \
    git \
    make 

RUN git clone https://github.com/lightningnetwork/lnd.git /go/src/github.com/lightningnetwork/lnd

RUN cd /go/src/github.com/lightningnetwork/lnd \
    &&  git checkout $checkout \
    &&  make \
    &&  make install tags="signrpc walletrpc chainrpc invoicesrpc kvdb_etcd"

# Start a new, final image to reduce size.
FROM alpine:3.12 as final

# Expose lnd ports (server, rpc).
EXPOSE 9735 10009 8080

# Copy the binaries and entrypoint from the builder image.
COPY --from=builder /go/bin/lncli /bin/
COPY --from=builder /go/bin/lnd /bin/

# Create a default user.
# Recommended to override this with your own user via docker run -u.
RUN adduser -S user

RUN mkdir /data && chmod 777 /data
RUN mkdir /rpc && chmod 777 /rpc
RUN mkdir /.lnd && chmod 777 /.lnd
COPY "./docker/lnd/lnd.conf" /lnd.conf
COPY "./docker/lnd/run-lnd.sh" /run-lnd.sh
RUN chmod 444 /lnd.conf
RUN chmod 555 /run-lnd.sh


# Run the entrypoint script.

VOLUME ["/data"]
VOLUME ["/rpc"]

# gRPC (internal use only)
EXPOSE 10009
# P2P (external)
EXPOSE 9735
# Watchtower (external)
EXPOSE 9911


ENTRYPOINT ["/run-lnd.sh"]

CMD ["lnd"]