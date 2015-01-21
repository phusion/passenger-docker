FROM phusion/baseimage:0.9.16
MAINTAINER Phusion <info@phusion.nl>

ENV HOME /root
ADD . /build
RUN /build/install.sh
CMD ["/sbin/my_init"]
EXPOSE 80 443
