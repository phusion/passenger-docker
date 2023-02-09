ARG ARCH
FROM phusion/passenger-base:current-$ARCH
MAINTAINER Phusion <info@phusion.nl>

ADD . /pd_build

RUN /pd_build/install_image.sh

CMD ["/sbin/my_init"]
EXPOSE 80 443
