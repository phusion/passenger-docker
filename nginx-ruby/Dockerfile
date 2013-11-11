FROM ubuntu:12.04
MAINTAINER Phusion <info@phusion.nl>

ENV HOME /root
RUN mkdir /build
ADD . /build

RUN /build/enable_repos.sh
RUN /build/prepare.sh
RUN /build/system_services.sh
RUN /build/utilities.sh
RUN /build/ruby.sh
RUN /build/nodejs.sh
RUN /build/passenger.sh
RUN /build/finalize.sh

CMD ["/sbin/my_init"]
EXPOSE 22 80 443
