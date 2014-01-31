# A Docker base image for Ruby, Python, Node.js and Meteor web apps

<center><img src="http://blog.phusion.nl/wp-content/uploads/2012/07/Passenger_chair_256x256.jpg" width="196" height="196" alt="Phusion Passenger"> <img src="http://blog.phusion.nl/wp-content/uploads/2013/11/docker.png" width="233" height="196" alt="Docker"></center>

Passenger-docker is a [Docker](http://www.docker.io) image meant to serve as a good base for Ruby, Python, Node.js and Meteor web app images. In line with [Phusion Passenger](https://www.phusionpassenger.com/)'s goal, passenger-docker's goal is to make Docker image building for web apps much easier and faster.

Why is this image called "passenger"? It's to represent the ease: you just have to sit back and watch most of the heavy lifting being done for you. Passenger-docker is part of a larger and more ambitious project: to make web app deployment ridiculously simple, to heights never achieved before.

**Relevant links:**
 [Github](https://github.com/phusion/passenger-docker) |
 [Docker registry](https://index.docker.io/u/phusion/passenger-full/) |
 [Discussion forum](https://groups.google.com/d/forum/passenger-docker) |
 [Twitter](https://twitter.com/phusion_nl) |
 [Blog](http://blog.phusion.nl/)

---------------------------------------

**Table of contents**

 * [Why use passenger-docker?](#why_use)
 * [What's inside the image?](#whats_inside)
   * [Memory efficiency](#memory_efficiency)
   * [Full vs minimal image](#full_vs_minimal)
 * [Inspecting the image](#inspecting_the_image)
 * [Using the image as base](#using)
   * [Getting started](#getting_started)
   * [The `app` user](#app_user)
   * [Using Nginx and Passenger](#nginx_passenger)
   * [Using Redis](#redis)
   * [Using memcached](#memcached)
   * [Additional daemons](#additional_daemons)
   * [Selecting a default Ruby version](#selecting_default_ruby)
 * [Administering the image's system](#administering)
   * [Logging into the container](#login)
   * [Inspecting the status of your web app](#inspecting_web_app_status)
   * [Logs](#logs)
 * [Building the image yourself](#building)
 * [Conclusion](#conclusion)

---------------------------------------

<a name="why_use"></a>
## Why use passenger-docker?

Why use passenger-docker instead of doing everything yourself in Dockerfile?

 * Your Dockerfile can be smaller.
 * It reduces the time needed to write a correct Dockerfile. You won't have to worry about the base system and the stack, you can focus on just your app.
 * It sets up the base system **correctly**. It's very easy to get the base system wrong, but this image does everything correctly. [Learn more.](https://github.com/phusion/baseimage-docker#contents)
 * It drastically reduces the time needed to run `docker build`, allowing you to iterate your Dockerfile more quickly.
 * It reduces download time during redeploys. Docker only needs to download the base image once: during the first deploy. On every subsequent deploys, only the changes you make on top of the base image are downloaded.

<a name="whats_inside"></a>
## What's inside the image?

*Passenger-docker is built on top of a solid base: [baseimage-docker](https://github.com/phusion/baseimage-docker).*

Basics (learn more at [baseimage-docker](https://github.com/phusion/baseimage-docker#readme)):

 * Ubuntu 12.04 LTS as base system.
 * A **correct** init process ([learn more](https://github.com/phusion/baseimage-docker#contents)).
 * Fixes APT incompatibilities with Docker.
 * syslog-ng.
 * The cron daemon.
 * The SSH server, so that you can easily login to your container to inspect or administer things.
   * Password and challenge-response authentication are disabled by default. Only key authentication is allowed.
   * It allows an predefined key by default to make debugging easy. You should replace this ASAP. See instructions.
 * [Runit](http://smarden.org/runit/) for service supervision and management.

Language support:

 * Ruby 1.8.7, 1.9.3, 2.0.0 and 2.1.0.
   * 2.1.0 is configured as the default.
   * Ruby is installed through [the Brightbox APT repository](https://launchpad.net/~brightbox/+archive/ruby-ng). We're not using RVM!
 * Python 2.7 and Python 3.0.
 * Node.js 0.10, through [Chris Lea's Node.js PPA](https://launchpad.net/~chris-lea/+archive/node.js/).
 * A build system, git, and development headers for many popular libraries, so that the most popular Ruby, Python and Node.js native extensions can be compiled without problems.

Web server and application server:

 * Nginx 1.4. Disabled by default.
 * [Phusion Passenger 4](https://www.phusionpassenger.com/). Disabled by default (because it starts along with Nginx).
   * This is a fast and lightweight tool for simplifying web application integration into Nginx.
   * It adds many production-grade features, such as process monitoring, administration and status inspection.
   * It replaces (G)Unicorn, Thin, Puma, uWSGI.

Auxiliary services and tools:

 * Redis 2.6, through [Rowan's Redis PPA](https://launchpad.net/~rwky/+archive/redis). Disabed by default.
 * Memcached. Disabled by default.
 * [Pups](https://github.com/SamSaffron/pups), a lightweight tool for bootstrapping images.

<a name="memory_efficiency"></a>
### Memory efficiency

Passenger-docker is very lightweight on memory. In its default configuration, it only uses 10 MB of memory (the memory consumed by bash, runit, sshd, syslog-ng, etc).

<a name="full_vs_minimal"></a>
### Full vs minimal image

Passenger-docker comes in two variants: `phusion/passenger-full` and `phusion/passenger-minimal`.

 * `phusion/passenger-full` contains everything that's listed in the "Contents" section, though not everything is enabled by default. This variant is ideal for those who want to set up a container quickly. Almost everything is taken care of automatically for you.
 * `phusion/passenger-minimal` contains only the base system, Nginx + Passenger and Pups. You have to explicitly opt-in for everything else. This variant is ideal for those who prefer disk space savings over convenience.

We believe that `phusion/passenger-full` should be the variant of choice for most people because disk space simply shouldn't be an issue. Docker only needs to download the base image once: during the first deploy. On every subsequent deploys, only the changes you make on top of the base image are downloaded. So on many deploys, the size of the base image is negligible.

In the rest of this document we're going to assume that the reader will be using `phusion/passenger-full`, unless otherwise stated. Simply substitute the name if you wish to use `phusion/passenger-minimal`.

<a name="inspecting_the_image"></a>
## Inspecting the image

To look around in the image, run:

    docker run -rm -t -i phusion/passenger-full bash -l

You don't have to download anything manually. The above command will automatically pull the passenger-docker image from the Docker registry.

<a name="using"></a>
## Using the image as base

<a name="getting_started"></a>
### Getting started

There are two images, `phusion/passenger-full` and `phusion/passenger-minimal`. See "Full vs minimal image".

By default, it allows SSH access for the key in `image/insecure_key`. This makes it easy for you to login to the container, but you should replace this key as soon as possible.

So put the following in your Dockerfile:

    # Use phusion/passenger-full as base image. To make your builds reproducible, make
    # sure you lock down to a specific version, not to `latest`!
    # See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
    # a list of version numbers.
    FROM phusion/passenger-full:<VERSION>
    # Or use the 'minimal' variant:
    #FROM phusion/passenger-minimal:<VERSION>
    
    # Set correct environment variables.
    ENV HOME /root
    
    # Remove authentication rights for insecure_key.
    RUN rm -f /root/.ssh/authorized_keys /home/*/.ssh/authorized_keys
    
    # Use baseimage-docker's init process.
    CMD ["/sbin/my_init"]

    # If you're using the 'minimal' variant, you need to explicitly opt-in
    # for features. Uncomment the features you want:
    #
    #   Build system and git.
    #/build/utilities.sh
    #   Ruby support.
    #/build/ruby1.8.sh
    #/build/ruby1.9.sh
    #/build/ruby2.0.sh
    #   Common development headers necessary for many Ruby gems,
    #   e.g. libxml for Nokogiri.
    #/build/devheaders.sh
    #   Python support.
    #/build/python.sh
    #   Node.js and Meteor support.
    #/build/nodejs.sh
    
    # ...put other build instructions here...
    
    # Clean up APT when done.
    RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

<a name="app_user"></a>
### The `app` user

The image has an `app` user with UID 9999 and home directory `/home/app`. Your application is supposed to run as this user. Even though Docker itself provides some isolation from the host OS, running applications without root privileges is good security practice.

Your application should be placed inside /home/app.

<a name="nginx_passenger"></a>
### Using Nginx and Passenger

Enable Nginx and Passenger:

    RUN rm -f /etc/service/nginx/down

You can add a virtual host entry (`server` block) by placing a file in the directory `/etc/nginx/sites-enabled`. You can modify Nginx `http` block settings by placing a file in the directory `/etc/nginx/conf.d`.

For example:

    # webapp.conf:
    server {
        listen 80;
        server_name www.webapp.com;
        root /home/app/webapp/public;
        
        # The following deploys your Ruby/Python/Node.js/Meteor app on Passenger.

        # Not familiar with Passenger, and used (G)Unicorn/Thin/Puma/pure Node before?
        # Yes, this is all you need to deploy on Passenger! All the reverse proxying,
        # socket setup, process management, etc are all taken care automatically for
        # you! Learn more at https://www.phusionpassenger.com/.
        passenger_enabled on;
        passenger_user app;

        # If this is a Ruby app, specify a Ruby version:
        passenger_ruby /usr/bin/ruby2.0;
        # For Ruby 1.9.3 (you can ignore the "1.9.1" suffix)
        #passenger_ruby /usr/bin/ruby1.9.1;
        # For Ruby 1.8.7
        #passenger_ruby /usr/bin/ruby1.8;
    }

    # Dockerfile:
    ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf
    RUN mkdir /home/app/webapp
    RUN ...commands to place your web app in /home/app/webapp...

<a name="redis"></a>
### Using Redis

Install and enable Redis:

    # Opt-in for Redis if you're using the 'minimal' image.
    #RUN /build/redis.sh
    
    # Enable the Redis service.
    RUN rm -f /etc/service/redis/down

The configuration file is in /etc/redis/redis.conf. Modify it as you see fit, but make sure `daemonize no` is set.

<a name="memcached"></a>
### Using memcached

Install and enable memcached:

    # Opt-in for Memcached if you're using the 'minimal' image.
    #RUN /build/memcached.sh

    # Enable the memcached service.
    RUN rm -f /etc/service/memcached/down

The configuration file is in /etc/memcached.conf. Note that it does not follow the Debian/Ubuntu format, but our own, in order to make it work well with runit. The default contents are:

    # These arguments are passed to the memcached daemon.
    MEMCACHED_OPTS="-l 127.0.0.1"

<a name="additional_daemons"></a>
### Additional daemons

You can add additional daemons to the image by creating runit entries. You only have to write a small shell script which runs your daemon, and runit will keep it up and running for you, restarting it when it crashes, etc.

The shell script must be called `run`, must be executable, and is to be placed in the directory `/etc/service/<NAME>`.

Here's an example showing you how to a memached server runit entry can be made.

    ### In memcached.sh (make sure this file is chmod +x):
    #!/bin/sh
    # `chpst` is part of running. `chpst -u memcache` runs the given command
    # as the user `memcache`. If you omit this, the command will be run as root.
    exec chpst -u memcache /usr/bin/memcached >>/var/log/memcached.log 2>&1

    ### In Dockerfile:
    RUN mkdir /etc/service/memcached
    ADD memcached.sh /etc/service/memcached/run

Note that the shell script must run the daemon **without letting it daemonize/fork it**. Usually, daemons provide a command line flag or a config file option for that.

**Tip**: If you're thinking about running your web app, consider deploying it on Passenger instead of on runit. Passenger relieves you from even having to write a shell script, and adds all sorts of useful production features like process scaling, introspection, etc. These are not available when you're only using runit.

<a name="selecting_default_ruby"></a>
### Selecting a default Ruby version

The default Ruby (what the `/usr/bin/ruby` command executes) is the latest Ruby version that you've chosen to install. You can use `ruby-switch` to select a different version as default.

    # Ruby 1.8.7
    RUN ruby-switch --set 1.8
    # Ruby 1.9.3 (you can ignore the "1.9.1" suffix)
    RUN ruby-switch --set 1.9.1
    # Ruby 2.0.0
    RUN ruby-switch --set 2.0

<a name="administering"></a>
## Administering the image's system

<a name="login"></a>
### Logging into the container

You can use SSH to administer any container that is based on passenger-docker.

Start a container based on passenger-docker (or a container based on an image based on passenger-docker):

    docker run [options] phusion/passenger-full [more options]

Find out the ID of the container that you just ran:

    docker ps

Once you have the ID, look for its IP address with:

    docker inspect <ID> | grep IPAddress

Now SSH into the container. In this example we're using [the default insecure key](https://github.com/phusion/passenger-docker/blob/master/image/insecure_key), but if you're followed the instructions well then you've already replaced that with your own key. You did replace the key, didn't you?

    ssh -i insecure_key root@<IP address>

<a name="inspecting_web_app_status"></a>
### Inspecting the status of your web app

If you use Passenger to deploy your web app, run:

    passenger-status
    passenger-memory-stats

<a name="logs"></a>
### Logs

If anything goes wrong, consult the log files in /var/log. The following log files are especially important:

 * /var/log/nginx/error.log
 * /var/log/syslog
 * Your app's log file in /home/app.

<a name="building"></a>
## Building the image yourself

If for whatever reason you want to build the image yourself instead of downloading it from the Docker registry, follow these instructions.

Clone this repository:

    git clone https://github.com/phusion/passenger-docker.git
    cd passenger-docker

Start a virtual machine with Docker in it. You can use the Vagrantfile that we've already provided.

    vagrant up
    vagrant ssh
    cd /vagrant

Build the image:

    make build

If you want to call the resulting image something else, pass the NAME variable, like this:

    make build NAME=joe/passenger

<a name="conclusion"></a>
## Conclusion

 * Using passenger-docker? [Tweet about us](https://twitter.com/share) or [follow us on Twitter](https://twitter.com/phusion_nl).
 * Having problems? Please post a message at [the discussion forum](https://groups.google.com/d/forum/passenger-docker).
 * Looking for a minimal image containing only a correct base system? Take a look at [baseimage-docker](https://github.com/phusion/baseimage-docker).

[<img src="http://www.phusion.nl/assets/logo.png">](http://www.phusion.nl/)

Please enjoy passenger-docker, a product by [Phusion](http://www.phusion.nl/). :-)
