FROM envoyproxy/envoy-alpine:v1.18-latest

COPY ./envoy.yml /etc/envoy/envoy.yml
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 555 /entrypoint.sh

# admin
EXPORT 10000

# proxy
EXPORT 443

# proxy
EXPORT 80
ENTRYPOINT ["/entrypoint.sh"]