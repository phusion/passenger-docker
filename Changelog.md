## 0.9.14 (release date: 2014-10-03)

 * Upgraded to baseimage-docker 0.9.15, which fixes the setuid bit on /usr/bin/sudo. This problem was caused by Docker bug #6828.

## 0.9.13 (release date: 2014-10-01)

 * Upgraded to baseimage-docker 0.9.14. This applies all the latest Ubuntu security updates, and patches Shellshock among other things.
 * Upgraded to Phusion Passenger 4.0.53 and Nginx 1.6.2.
 * Some documentation updates by Martijn Heemels.

## 0.9.12 (release date: 2014-08-22)

 * Upgraded to baseimage-docker 0.9.13.
 * Upgraded to Phusion Passenger 4.0.49 and Nginx 1.6.1.
 * Fixed some bugs in ruby-switch. Thanks to John C Banks. Closes GH-47.
 * Code cleanups thanks to Aris Pikeas. Closes GH-43.
 * Fixed passenger-customizable build scripts from failing due to absence of `ruby_switch`. Closes GH-34.
 * The build scripts in passenger-customizable now automatically run `apt-get update` when necessary.
 * Development headers are now included by default in all Ruby images. Closes GH-44.

## 0.9.11 (release date: 2014-06-25)

 * Upgraded to baseimage-docker 0.9.11.
 * Upgraded to Phusion Passenger 4.0.45.
 * The baseimage-docker insecure key was erroneously still installed by default for the 'app' user. It has now been removed.
 * The 'full' image didn't properly include Python 2.7. This has been fixed.
 * Nginx error logs are now forwarded to the Docker logs.

## 0.9.10 (release date: 2014-05-13)

 * Upgraded to baseimage-docker 0.9.10 and Ubuntu 14.04.
 * Upgraded to Nginx 1.6.0.
 * Upgraded to Phusion Passenger 4.0.42.
 * Ruby 1.8 support has been removed because it is no longer available on Ubuntu 14.04.
 * It is now possible to put additional Nginx configuration in the directory /etc/nginx/main.d. This works like /etc/nginx/conf.d, but config files are included in the main context, not in the http context. It is ideal for adding things like `env` directives. Thanks to javereec for documentation contribution.
 * The Phusion Passenger native extension is now precompiled for for all Ruby interpreters.

## 0.9.9 (release date: 2014-03-25)

 * Upgraded to baseimage-docker 0.9.9.
 * Upgraded to Phusion Passenger 4.0.40.
 * Upgraded to Nginx 1.4.7. This also fixes several Nginx vulnerabilities.
 * Ports 80 and 443 are now by default made available for Docker linking.
 * Redis and Memcached have been reintroduced, but only in the `passenger-customizable` and `passenger-full` images.
 * Various minor improvements. (Amir Gur)

## 0.9.8 (release date: 2014-02-26)

 * Upgraded to baseimage-docker 0.9.8.

## 0.9.7 (release date: 2014-02-25)

 * Upgraded to baseimage-docker 0.9.7.

## 0.9.6 (release date 2013-02-06)

 * Upgraded to baseimage-docker 0.9.5.

## 0.9.5 (release date 2013-02-03)

 * Upgraded to baseimage-docker 0.9.4, which fixes a syslog-ng startup problem.

## 0.9.4 (release date 2013-02-01)

 * Upgraded to Phusion Passenger 4.0.37, which improves Node.js and Meteor support and fixes many bugs.
 * Upgraded to baseimage-docker 0.9.3.
 * Added support for Ruby 2.1. This is available in the phusion/passenger-ruby21 image.
 * Reintroduced the phusion/passenger-full image.

## 0.9.3 (release date 2013-12-12)

 * Upgraded to Phusion Passenger 4.0.28.
 * Upgraded to baseimage-docker 0.9.2.
 * passenger-docker has been split into multiple versions, each one targeted at only a single programming language. The following images are now available on the Docker index: phusion/passenger-ruby18, phusion/passenger-ruby19, phusion/passenger-ruby20, phusion/passenger-python, phusion/passenger-nodejs. There is also a phusion/passenger-customizable image which allows you to easily have multiple languages in a single container.

## 0.9.2 (release date 2013-11-13)

 * Fixed the pups wrapper script.

## 0.9.1 (release date 2013-11-12)

 * Upgraded to baseimage-docker 0.9.1.

## 0.9.0 (release date 2013-11-12)

 * Initial release.
