## 2.3.0 (release date: 2022-05-10)
 * Upgraded to Ruby 2.6.10
 * Upgraded to Ruby 2.7.6
 * Upgraded to Ruby 3.0.4
 * Upgraded to Ruby 3.1.2

## 2.2.0 (release date: 2022-03-29)
 * Upgraded to JRuby 9.3.4.0 (from 9.3.0.0).
 * Upgraded to Phusion Passenger 6.0.13 (from 6.0.12).
 * Added Ruby 3.1.1 image.

## 2.1.0 (release date: 2021-12-07)
 * Upgraded to Ruby 2.6.9
 * Upgraded to Ruby 2.7.5
 * Upgraded to Ruby 3.0.3
 * Switched the ruby shims to use rvm wrappers, to hopefully address some ruby-environment instability.

## 2.0.1 (release date: 2021-11-05)
 * Added tzdata for Ruby convienience.
 * Upgraded to Phusion Passenger 6.0.12 (from 6.0.11).
 * Upgraded Node 14 LTS -> 16 LTS.

## 2.0.0 (release date: 2021-10-01)
 * Upgraded to Phusion Passenger 6.0.11 (from 6.0.10).
 * Upgraded to latest baseimage.
 * Inlcude fix for expired Let's Encrypt root certificate.
 * Upgraded to JRuby 9.3.0.0 with openjdk-17.
 * Dropped ruby 2.4 and 2.5 images, they're EOL.

## 1.0.19 (release date: 2021-07-19)
 * Fixed wrong Ruby 3 being deleted (3.0.2 instead of 3.0.1 was deleted, 3.0.2 now restored and 3.0.1 removed).

## 1.0.18 (release date: 2021-07-19)
 * Fixed additional unwanted Rubies being present.

## 1.0.17 (release date: 2021-07-19)
 * Upgraded to Ruby 2.6.8
 * Upgraded to Ruby 2.7.4
 * Upgraded to Ruby 3.0.2

## 1.0.16 (release date: 2021-07-14)
 * Upgraded to Phusion Passenger 6.0.10 (from 6.0.9).

## 1.0.15 (release date: 2021-06-02)
 * Upgraded to Phusion Passenger 6.0.9 (from 6.0.8).
 * This version includes a workaround for issue #313, which will be fixed properly with Passsenger 6.0.10.

## 1.0.14 (release date: 2021-05-06)
 * Upgraded to Ruby 2.5.9
 * Upgraded to Ruby 2.6.7
 * Upgraded to Ruby 2.7.3
 * Upgraded to Ruby 3.0.1

## 1.0.13 (release date: 2021-04-01)
 * Upgraded to Phusion Passenger 6.0.8 (from 6.0.7).
 * Added support for Ruby 3.0.0.

## 1.0.12 (release date: 2020-11-18)
 * Upgraded to Phusion Passenger 6.0.7 (from 6.0.6).
 * Upgraded to Ruby 2.7.2 (from 2.7.1).
 * Default Ruby set to 2.7.2.
 * Upgraded to JRuby 9.2.13.0 with openjdk-14.
 * Upgraded to Node.js 14 LTS (from 10).
 * Switched image base to the baseimage-docker master tag.
 * Upgraded to Ubuntu 20.04.
 * Dropped support for Ruby 2.3.
 * Upgraded to Nginx 1.18.0.

## 1.0.11 (release date: 2020-07-14)
 * Upgraded to Phusion Passenger 6.0.6 (from 6.0.5).

## 1.0.10 (release date: 2020-05-29)
 * Upgraded to Ruby 2.4.10.
 * Upgraded to Ruby 2.5.8.
 * Upgraded to Ruby 2.6.6.
 * Upgraded to JRuby 9.2.11.1.
 * Added support for Ruby 2.7.1.
 * Default ruby set to 2.7.1.
 * Upgraded to Phusion Passenger 6.0.5 (from 6.0.4).

## 1.0.9 (release date: 2019-11-25)
 * Upgraded to Ruby 2.4.9.
 * Upgraded to Ruby 2.5.7.
 * Upgraded to Ruby 2.6.5.
 * Default ruby set to 2.6.5.

## 1.0.8 (release date: 2019-09-17)

 * Upgraded to Phusion Passenger 6.0.4 (from 6.0.3).

## 1.0.7 (release date: 2019-09-12)

 * Upgraded to Phusion Passenger 6.0.3 (from 6.0.2).

## 1.0.6 (release date: 2019-07-02)
 * Upgraded to Ruby 2.4.6.
 * Upgraded to Ruby 2.6.3.
 * reopen passenger logs in logrotate script. Closes GH-255.
 * Defers installing bundler to rvm. Closes GH-260.

## 1.0.5 (release date: 2019-03-15)
 * Upgraded to Ruby 2.5.5.

## 1.0.4 (release date: 2019-03-14)
 * Upgraded to Ruby 2.5.4.
 * Upgraded to Ruby 2.6.2.
 * Upgraded to JRuby 9.2.5.0.

## 1.0.3 (release date: 2019-02-25)

 * Upgraded to Phusion Passenger 6.0.2 (from 6.0.1).

## 1.0.2 (release date: 2019-02-06)

 * Update signing keys from rvm.io. Closes GH-234.
 * Upgraded to Phusion Passenger 6.0.1 (from 6.0.0).

## 1.0.1 (release date: 2018-11-30)

 * Upgraded to Phusion Passenger 6.0.0 (from 5.3.6).

## 1.0.0 (release date: 2018-11-06)

 * Upgraded to baseimage-docker 0.11.
 * Upgraded to Ubuntu 18.04.
 * Upgraded to Phusion Passenger 5.3.6.
 * Upgraded to Nginx 1.14.0.
 * Upgraded to Ruby 2.5.3.
 * Upgraded to Ruby 2.4.5.
 * Upgraded to Ruby 2.3.8.
 * Upgraded to JRuby 9.2.0.0.
 * Upgraded to Redis 4.0.
 * Dropped Ruby 2.0, 2.1 and 2.2.

## 0.9.35 (release date: 2018-08-01)

 * Upgraded to Phusion Passenger 5.3.4 (from 5.3.3).

## 0.9.34 (release date: 2018-06-26)

 * Upgraded to Phusion Passenger 5.3.3 (from 5.3.2).

## 0.9.33 (release date: 2018-06-12)

 * Upgraded to Phusion Passenger 5.3.2 (from 5.3.1).
 * Upgraded to baseimage-docker 0.10.1 (from 0.9.22).

## 0.9.32 (release date: 2018-05-14)

 * Upgraded to Phusion Passenger 5.3.1 (from 5.3.0).

## 0.9.31 (release date: 2018-05-09)

 * Upgraded to Phusion Passenger 5.3.0 (from 5.2.3).

## 0.9.30 (release date: 2018-04-06)

 * Upgraded to Phusion Passenger 5.2.3 (from 5.2.1).
 * Upgraded to Node.js 8.11.1 LTS Carbon (from 8.9.4).
 * Thanks to contribution by ledermann (PR 214):
   - Upgraded to Ruby 2.5.1 (from 2.5.0).
   - Upgraded to Ruby 2.4.4 (from 2.4.2).
   - Upgraded to Ruby 2.3.7 (from 2.3.6).
   - Upgraded to Ruby 2.2.10 (from 2.2.9).


## 0.9.29 (release date: 2018-02-27)

 * Upgraded to Phusion Passenger 5.2.1 (from 5.2.0).
 * Hints about app permission in container. Thanks to contribution by skunkworker (PR 206)
 * Thanks to contribution by ledermann (PR 204):
   - Added build for Ruby 2.5 (2.5.0). 
   - Upgraded to Ruby 2.4.3 (from 2.4.2).
   - Upgraded to Ruby 2.3.6 (from 2.3.5).
   - Upgraded to Ruby 2.2.9 (from 2.2.8).
 * Upgraded to Node.js 8.9.4 LTS (from 7.10.0, sticking to LTS releases from now).
 * Updated Makefile to also push latest tag. Closes GH-197.

## 0.9.28 (release date: 2018-01-29)

 * Upgraded to Phusion Passenger 5.2.0 (from 5.1.12).

## 0.9.27 (release date: 2017-11-23)

 * Upgraded to Phusion Passenger 5.1.12 (from 5.1.11).

## 0.9.26 (release date: 2017-10-16)

 * Upgraded to Phusion Passenger 5.1.11 (from 5.1.8).
 * Upgraded to Ruby 2.4.2 (from 2.4.1).
 * Upgraded to Ruby 2.3.5 (from 2.3.3).
 * Upgraded to Ruby 2.2.8 (from 2.2.5).

## 0.9.25 (release date: 2017-08-23)

 * Upgraded to Phusion Passenger 5.1.8 (from 5.1.7).

## 0.9.24 (release date: 2017-08-01)

 * Upgraded to Phusion Passenger 5.1.7 (from 5.1.6).

## 0.9.23 (release date: 2017-07-24)

 * Upgraded to Phusion Passenger 5.1.6 (from 5.1.5).

## 0.9.22 (release date: 2017-06-19)

 * Upgraded to Phusion Passenger 5.1.5 (from 5.1.4).
 * Upgraded to Ruby 2.4.1 (from 2.4.0).
 * Upgraded to baseimage-docker 0.9.22 (from 0.9.21).

## 0.9.21 (release date: 2017-05-18)

 * Upgraded to Phusion Passenger 5.1.4.
 * Upgraded to baseimage-docker 0.9.21.
 * Upgraded to Node.js 7.10.0.
 * Fixed RVM warning about the PATH unnecessarily. Closes GH-150 and GH-178.
 * Fixed a race condition in nginx-log-forwarder. Closes GH-183 and GH-182.

## 0.9.20 (release date: 2017-01-10)

 * Upgraded to Phusion Passenger 5.1.1.
 * Upgraded to Ruby 2.3.3.
 * Added support for Ruby 2.4.0.

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
