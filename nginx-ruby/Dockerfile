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
## - Chris Lea's Node.js
RUN echo deb http://archive.ubuntu.com/ubuntu precise main universe > /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise-updates main universe >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6
RUN echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu precise main > /etc/apt/sources.list.d/brightbox.list
RUN apt-get update
RUN apt-get install -y apt-transport-https python-software-properties
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
RUN echo deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main > /etc/apt/sources.list.d/passenger.list
## Or, if you're using Phusion Passenger Enterprise:
# RUN echo deb https://download:YOUR_DOWNLOAD_TOKEN@www.phusionpassenger.com/enterprise_apt precise main > /etc/apt/sources.list.d/passenger.list
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update

## Install runit and configure it as the init service.
RUN apt-get install -y runit
CMD ["/usr/sbin/runsvdir-start"]

## Install syslog-ng.
RUN apt-get install -y syslog-ng
RUN mkdir /etc/service/syslog-ng

## Install the SSH server.
RUN apt-get install -y openssh-server
RUN mkdir /etc/service/sshd
RUN mkdir /var/run/sshd
## Install default SSH key for root.
RUN mkdir /root/.ssh
RUN chmod 700 /root/.ssh
RUN chown root:root /root/.ssh

## Install useful utilities.
RUN apt-get install -y build-essential git

## Install Ruby 1.9.3 and 2.0.0.
RUN apt-get install -y ruby ruby1.9.3 ruby2.0 rake
RUN gem install bundler --no-rdoc --no-ri

## Install Node.js (also needed for Rails asset compilation)
RUN apt-get install -y nodejs

## Install Phusion Passenger.
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
RUN echo deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main > /etc/apt/sources.list.d/passenger.list
RUN apt-get update
RUN apt-get install -y passenger
## Or, if you're using Phusion Passenger Enterprise:
# RUN apt-get install -y passenger-enterprise

## Create a user for the web app.
RUN addgroup --gid 1000 app
RUN adduser --uid 1000 --gid 1000 --disabled-password --gecos "Application" app
RUN usermod -L app

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
