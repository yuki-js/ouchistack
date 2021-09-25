FROM envoyproxy/envoy-distroless:latest

COPY ./envoy.yml /etc/envoy/envoy.yml
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 555 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]