FROM ubuntu:12.04
MAINTAINER Phusion <info@phusion.nl>

ENV HOME /root
RUN mkdir /build
ADD . /build

RUN /build/enable_repos.sh && /build/prepare.sh
RUN /build/system_services.sh && /build/utilities.sh
RUN /build/ruby.sh && /build/python.sh && /build/nodejs.sh && /build/passenger.sh
RUN /build/finalize.sh

CMD ["/sbin/my_init"]
EXPOSE 22 80 443
