## 0.9.19 (release date: 2016-07-11)

 * Upgraded to baseimage-docker 0.9.19.
 * Upgraded to Ubuntu 16.04 with security updates as of July 11, 2016.
 * Upgraded to Phusion Passenger 5.0.29.
 * Upgraded Redis to 3.0.
 * We now use RVM to manage Ruby interpreters, instead of the Brightbox APT repository. Please see the README for rationale.
 * Removed support for Ruby 1.9.
 * Added support for Ruby 2.3.1.
 * Upgraded to Ruby 2.1.9 and 2.2.5.
 * Upgraded to JRuby 9.1.2.0. We are still on OpenJDK 8 because there is a problem with JRuby and OpenJDK 9.
 * Upgraded to Node.js 4.2.6.
 * ImageMagick is no longer included (needed by rmagick and minimagick). This shaves around 120 MB. If you need it you should install it yourself.
 * Man pages, documentation and non-English locales are now removed. This shaves around 64 MB.
 * Gzip support in Nginx is now correctly enabled by default. Closes GH-115.
 * Nginx log rotation has now been fixed. Closes GH-113.

## 0.9.18 (release date: 2015-12-08)

 * Upgraded to Phusion Passenger 5.0.22.
 * Upgraded to baseimage-docker 0.9.17.
 * Upgraded to Ruby 2.1.7 and 2.2.3.
 * Upgraded to JRuby 9.0.4.0.
 * Upgraded to Node.js 0.12.9.

## 0.9.17 (release date: 2015-08-04)

 * Upgraded to Phusion Passenger 5.0.15.
 * Upgraded to JRuby 9.0.0.0. Closes GH-99.
 * Fixed passenger-full containing Node.js 0.12 instead of 0.10. Closes GH-96.

## 0.9.16 (release date: 2015-07-15)

 * The latest OpenSSL updates have been pulled in. This fixes [CVE-2015-1793](http://openssl.org/news/secadv_20150709.txt). Upgrading is strongly recommended.
 * Upgraded to baseimage-docker 0.9.17.
 * Upgraded to Phusion Passenger 5.0.14.
 * Upgraded to Ruby 2.1.6 and 2.2.2.
 * Upgraded to JRuby 1.7.21.
 * Upgraded to Node.js 0.12.7.
 * Fixed Ruby tool shebang lines in the passenger-full image variant. Closes GH-78.

## 0.9.15 (release date: 2015-01-23)

 * Upgraded to baseimage-docker 0.9.16.
 * Upgraded to Phusion Passenger 4.0.58.
 * Support for Ruby 2.2. Closes GH-64.
 * Support for JRuby 1.7.18. Thanks to Per Lundberg. Closes GH-65.
 * It is now possible to allow users to override the value of `RAILS_ENV`, `NODE_ENV` etc at runtime. Please refer to the documentation for details ("Application environment name (`RAILS_ENV`, `NODE_ENV`, etc)").
 * In order to work around [an AUFS bug](https://github.com/docker/docker/issues/783), the `/build` directory has been renamed to `/pd_build`.
 * Pups has been removed.
 * Non-Ruby 1.9 images no longer contain Ruby 1.9. This is because a bug in the Phusion Passenger Debian packages has been fixed.
 * Qt has been removed from the Ruby images because it's not used by a lot of Ruby apps. This reduces the image size by ~150 MB. Closes GH-52.
 * Documentation updates, some of which are contributed by Olle Jonsson. Closes GH-33. Closes GH-62.

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
