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

## Install system setup finalizer script.
ADD setup-system /usr/sbin/setup-system
RUN chmod +x /usr/sbin/setup-system
RUN echo "if [[ -f /usr/sbin/setup-system ]] && tty -s; then echo '*** Please run setup-system ***'; fi" >> /root/.bashrc

## Create runit services and install default SSH key.
ADD syslog-ng /etc/service/syslog-ng/run
ADD sshd /etc/service/sshd/run
ADD insecure_key.pub /root/.ssh/authorized_keys
RUN chmod 755 /root/.ssh/authorized_keys
RUN chown root:root /root/.ssh/authorized_keys

## Expose ports.
EXPOSE 22 80 443

## Clean up.
RUN apt-get clean
