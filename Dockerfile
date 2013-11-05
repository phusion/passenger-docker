FROM ubuntu:12.04
MAINTAINER Hongli Lai <hongli@phusion.nl>

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

## Install Ruby 1.9.3.
RUN apt-get install -y ruby rake

## Install Nginx and Phusion Passenger.
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
RUN echo deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main > /etc/apt/sources.list.d/passenger.list
RUN apt-get update
RUN apt-get install -y rake nginx-extras passenger
