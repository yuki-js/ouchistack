FROM envoyproxy/envoy-alpine:v1.18-latest

COPY ./envoy.yml /etc/envoy/envoy.yml
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 555 /entrypoint.sh

# admin
EXPOSE 10000

# proxy
EXPOSE 443

# proxy
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]