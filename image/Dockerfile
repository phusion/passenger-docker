FROM phusion/baseimage:master
MAINTAINER Phusion <info@phusion.nl>

ADD . /pd_build
RUN /pd_build/install.sh
CMD ["/sbin/my_init"]
EXPOSE 80 443
