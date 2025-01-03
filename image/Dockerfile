# syntax=docker/dockerfile:1.4
ARG ARCH
ARG NAME
FROM $NAME-base:latest-$ARCH
MAINTAINER Phusion <info@phusion.nl>

ADD . /pd_build

ARG ARCH
ARG http_proxy
RUN --mount=type=cache,target=/build_cache \
    /usr/bin/nice /pd_build/install_image.sh

CMD ["/sbin/my_init"]
EXPOSE 80 443
