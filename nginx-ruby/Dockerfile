FROM ubuntu:12.04
MAINTAINER Phusion <info@phusion.nl>

ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
RUN mkdir /build
ADD . /build

RUN /build/prepare.sh
RUN /build/enable_repos.sh
RUN /build/system_services.sh
RUN /build/ruby.sh
RUN /build/nodejs.sh
RUN /build/passenger.sh
RUN /build/finalize.sh

CMD ["/usr/sbin/runsvdir-start"]
EXPOSE 22 80 443
