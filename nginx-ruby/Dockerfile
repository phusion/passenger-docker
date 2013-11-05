FROM ubuntu:12.04
MAINTAINER Phusion <info@phusion.nl>

## Fix some issues with APT packages.
## See https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

## Enable the following repositories:
## - Ubuntu Universe
## - Brightbox Ruby 1.9.3
## - Phusion Passenger
RUN echo deb http://archive.ubuntu.com/ubuntu precise main universe > /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise-updates main universe >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6
RUN echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu precise main > /etc/apt/sources.list.d/brightbox.list
RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
RUN echo deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main > /etc/apt/sources.list.d/passenger.list
## Or, if you're using Phusion Passenger Enterprise:
# RUN echo deb https://download:YOUR_DOWNLOAD_TOKEN@www.phusionpassenger.com/enterprise_apt precise main > /etc/apt/sources.list.d/passenger.list
RUN apt-get update

## Install runit and configure it as the init service.
RUN apt-get install -y runit
CMD ["/usr/sbin/runsvdir-start"]

## Install syslog-ng.
RUN apt-get install -y syslog-ng
RUN mkdir /etc/service/syslog-ng
ADD syslog-ng /etc/service/syslog-ng/run
RUN chmod +x /etc/service/syslog-ng/run

## Install the SSH server.
RUN apt-get install -y openssh-server
RUN mkdir /etc/service/sshd
ADD sshd /etc/service/sshd/run
RUN chmod +x /etc/service/sshd/run
RUN mkdir /var/run/sshd
EXPOSE 22
## Install default SSH key for root.
RUN mkdir /root/.ssh
RUN chmod 700 /root/.ssh
RUN chown root:root /root/.ssh
ADD insecure_key.pub /root/.ssh/authorized_keys
RUN chmod 755 /root/.ssh/authorized_keys
RUN chown root:root /root/.ssh/authorized_keys

## Install Ruby 1.9.3.
RUN apt-get install -y ruby rake

## Install Nginx and Phusion Passenger.
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
RUN echo deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main > /etc/apt/sources.list.d/passenger.list
RUN apt-get update
RUN apt-get install -y passenger
## Or, if you're using Phusion Passenger Enterprise:
# RUN apt-get install -y passenger-enterprise
EXPOSE 80

## Create a user for the web app.
RUN addgroup --gid 1000 app
RUN adduser --uid 1000 --gid 1000 --disabled-password --gecos "Application" app
RUN echo app:app | chpasswd

## Clean up.
RUN apt-get clean
