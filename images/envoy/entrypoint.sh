#!/usr/bin/env sh

exec envoy -c /etc/envoy/envoy.yml "$@"