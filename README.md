# A Docker base image for Ruby, Python, Node.js and Meteor web apps

<center><img src="http://blog.phusion.nl/wp-content/uploads/2012/07/Passenger_chair_256x256.jpg" width="196" height="196" alt="Phusion Passenger"> <img src="http://blog.phusion.nl/wp-content/uploads/2013/11/docker.png" width="233" height="196" alt="Docker"></center>

Passenger-docker is a [Docker](http://www.docker.io) image meant to serve as a good base for **Ruby, Python, Node.js and Meteor** web app images. In line with [Phusion Passenger](https://www.phusionpassenger.com/)'s goal, passenger-docker's goal is to make Docker image building for web apps much easier and faster.

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
 * [About passenger-docker](#about)
   * [What's included?](#whats_included)
   * [Memory efficiency](#memory_efficiency)
   * [Image variants](#image_variants)
 * [Inspecting the image](#inspecting_the_image)
 * [Using the image as base](#using)
   * [Getting started](#getting_started)
   * [The `app` user](#app_user)
   * [Using Nginx and Passenger](#nginx_passenger)
     * [Adding your web app to the image](#adding_web_app)
     * [Configuring Nginx](#configuring_nginx)
     * [Setting environment variables in Nginx](#nginx_env_vars)
   * [Using Redis](#redis)
   * [Using memcached](#memcached)
   * [Additional daemons](#additional_daemons)
   * [Selecting a default Ruby version](#selecting_default_ruby)
   * [Running scripts during container startup](#running_startup_scripts)
 * [Administering the image's system](#administering)
   * [Logging into the container with SSH](#login)
     * [Using the insecure key for one container only](#using_the_insecure_key_for_one_container_only)
     * [Enabling the insecure key permanently](#enabling_the_insecure_key_permanently)
     * [Using your own key](#using_your_own_key)
     * [The `docker-bash` tool](#docker_bash)
   * [Inspecting the status of your web app](#inspecting_web_app_status)
   * [Logs](#logs)
 * [Switching to Phusion Passenger Enterprise](#enterprise)
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

<a name="about"></a>
## About the image

<a name="whats_included"></a>
### What's included?

*Passenger-docker is built on top of a solid base: [baseimage-docker](http://phusion.github.io/baseimage-docker/).*

Basics (learn more at [baseimage-docker](http://phusion.github.io/baseimage-docker/)):

 * Ubuntu 14.04 LTS as base system.
 * A **correct** init process ([learn more](http://phusion.github.io/baseimage-docker/)).
 * Fixes APT incompatibilities with Docker.
 * syslog-ng.
 * The cron daemon.
 * The SSH server, so that you can easily login to your container to inspect or administer things. Password and challenge-response authentication are disabled by default. Only key authentication is allowed.
 * [Runit](http://smarden.org/runit/) for service supervision and management.

Language support:

 * Ruby 1.9.3, 2.0.0 and 2.1.0.
   * 2.1.0 is configured as the default.
   * Ruby is installed through [the Brightbox APT repository](https://launchpad.net/~brightbox/+archive/ruby-ng). We're not using RVM!
 * Python 2.7 and Python 3.0.
 * Node.js 0.10, through [Chris Lea's Node.js PPA](https://launchpad.net/~chris-lea/+archive/node.js/).
 * A build system, git, and development headers for many popular libraries, so that the most popular Ruby, Python and Node.js native extensions can be compiled without problems.

Web server and application server:

 * Nginx 1.6. Disabled by default.
 * [Phusion Passenger 4](https://www.phusionpassenger.com/). Disabled by default (because it starts along with Nginx).
   * This is a fast and lightweight tool for simplifying web application integration into Nginx.
   * It adds many production-grade features, such as process monitoring, administration and status inspection.
   * It replaces (G)Unicorn, Thin, Puma, uWSGI.
   * Node.js users: [watch this 4 minute intro video](http://vimeo.com/phusionnl/review/84945384/73fe7432ee) to learn why it's cool and useful.

Auxiliary services and tools:

 * Redis 2.6, through [Rowan's Redis PPA](https://launchpad.net/~rwky/+archive/redis). Disabled by default.
 * Memcached. Disabled by default.
 * [Pups](https://github.com/SamSaffron/pups), a lightweight tool for bootstrapping images.

<a name="memory_efficiency"></a>
### Memory efficiency

Passenger-docker is very lightweight on memory. In its default configuration, it only uses 10 MB of memory (the memory consumed by bash, runit, sshd, syslog-ng, etc).

<a name="image_variants"></a>
### Image variants

Passenger-docker consists of several images, each one tailor made for a specific user group.

**Ruby images**

 * `phusion/passenger-ruby19` - Ruby 1.9.
 * `phusion/passenger-ruby20` - Ruby 2.0.
 * `phusion/passenger-ruby21` - Ruby 2.1.

**Node.js and Meteor images**

 * `phusion/passenger-nodejs` - Node.js 0.11.

**Other images**

 * `phusion/passenger-full` - Contains everything in the above images. Ruby, Python, Node.js, all in a single image for your convenience.
 * `phusion/passenger-customizable` - Contains only the base system, as described in "What's included?". Ruby, Python and Node.js are not preinstalled. This image is meant to be further customized through your Dockerfile. For example, using this image you can create a custom image that contains only Ruby 2.0, Ruby 2.1 and Node.js.

In the rest of this document we're going to assume that the reader will be using `phusion/passenger-full`, unless otherwise stated. Simply substitute the name if you wish to use another image.

<a name="inspecting_the_image"></a>
## Inspecting the image

To look around in the image, run:

    docker run --rm -t -i phusion/passenger-full bash -l

You don't have to download anything manually. The above command will automatically pull the passenger-docker image from the Docker registry.

<a name="using"></a>
## Using the image as base

<a name="getting_started"></a>
### Getting started

There are several images, e.g. `phusion/passenger-ruby21` and `phusion/passenger-nodejs`. Choose the one you want. See [Image variants](#image_variants).

So put the following in your Dockerfile:

    # Use phusion/passenger-full as base image. To make your builds reproducible, make
    # sure you lock down to a specific version, not to `latest`!
    # See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
    # a list of version numbers.
    FROM phusion/passenger-full:<VERSION>
    # Or, instead of the 'full' variant, use one of these:
    #FROM phusion/passenger-ruby19:<VERSION>
    #FROM phusion/passenger-ruby20:<VERSION>
    #FROM phusion/passenger-ruby21:<VERSION>
    #FROM phusion/passenger-nodejs:<VERSION>
    #FROM phusion/passenger-customizable:<VERSION>
    
    # Set correct environment variables.
    ENV HOME /root
    
    # Use baseimage-docker's init process.
    CMD ["/sbin/my_init"]
    
    # If you're using the 'customizable' variant, you need to explicitly opt-in
    # for features. Uncomment the features you want:
    #
    #   Build system and git.
    #RUN /build/utilities.sh
    #   Ruby support.
    #RUN /build/ruby1.9.sh
    #RUN /build/ruby2.0.sh
    #RUN /build/ruby2.1.sh
    #   Python support.
    #RUN /build/python.sh
    #   Node.js and Meteor support.
    #RUN /build/nodejs.sh
    
    # ...put your own build instructions here...
    
    # Clean up APT when done.
    RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

<a name="app_user"></a>
### The `app` user

The image has an `app` user with UID 9999 and home directory `/home/app`. Your application is supposed to run as this user. Even though Docker itself provides some isolation from the host OS, running applications without root privileges is good security practice.

Your application should be placed inside /home/app.

<a name="nginx_passenger"></a>
### Using Nginx and Passenger

Before using Passenger, you should familiarise yourself with it by [reading its documentation](https://www.phusionpassenger.com).

Nginx and Passenger are disabled by default. Enable them like so:

    RUN rm -f /etc/service/nginx/down

<a name="adding_web_app"></a>
#### Adding your web app to the image

Passenger works like a `mod_ruby`, `mod_node`, etc. It changes Nginx into an application server and runs your app from Nginx. So to get your web app up and running, you just have to add a virtual host entry to Nginx which describes where you app is, and Passenger will take care of the rest.

You can add a virtual host entry (`server` block) by placing a .conf file in the directory `/etc/nginx/sites-enabled`. For example:

    # /etc/nginx/sites-enabled/webapp.conf:
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
        passenger_ruby /usr/bin/ruby2.1;
        # For Ruby 2.0
        passenger_ruby /usr/bin/ruby2.0;
        # For Ruby 1.9.3 (you can ignore the "1.9.1" suffix)
        #passenger_ruby /usr/bin/ruby1.9.1;
    }
    
    # Dockerfile:
    ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf
    RUN mkdir /home/app/webapp
    RUN ...commands to place your web app in /home/app/webapp...

<a name="configuring_nginx"></a>
#### Configuring Nginx

The best way to configure Nginx is by adding .conf files to `/etc/nginx/main.d` and `/etc/nginx/conf.d`. Files in `main.d` are included into the Nginx configuration's main context, while files in `conf.d` are included in the Nginx configuration's http context.

For example:

    # /etc/nginx/main.d/secret_key.conf:
    env SECRET_KEY 123456;
    
    # /etc/nginx/conf.d/gzip_max.conf:
    gzip_comp_level 9;
    
    # Dockerfile:
    ADD secret_key.conf /etc/nginx/main.d/secret_key.conf
    ADD gzip_max.conf /etc/nginx/conf.d/gzip_max.conf

<a name="nginx_env_vars"></a>
#### Setting environment variables in Nginx

By default Nginx [clears all environment variables](http://nginx.org/en/docs/ngx_core_module.html#env) (except `TZ`) for its child processes (Passenger being one of them). That's why any environment variables you set with `docker run -e`, Docker linking and `/etc/container_environment`, won't reach Nginx.

To preserve these variables, place a file ending in `*.conf` in the directory `/etc/nginx/main.d`. For example when linking a PostgreSQL container or MongoDB container:

    # /etc/nginx/main.d/postgres-env.conf:
    env POSTGRES_PORT_5432_TCP_ADDR;
    env POSTGRES_PORT_5432_TCP_PORT;
    
    # Dockerfile:
    ADD postgres-env.conf /etc/nginx/main.d/postgres-env.conf

By default, passenger-docker already contains a config file `/etc/nginx/main.d/default.conf` which preserves the `PATH` environment variable.

<a name="redis"></a>
### Using Redis

**Redis is only available in the passenger-customizable and passenger-full images!**

Install and enable Redis:

    # Opt-in for Redis if you're using the 'customizable' image.
    #RUN /build/redis.sh
    
    # Enable the Redis service.
    RUN rm -f /etc/service/redis/down

The configuration file is in /etc/redis/redis.conf. Modify it as you see fit, but make sure `daemonize no` is set.

<a name="memcached"></a>
### Using memcached

**Memcached is only available in the passenger-customizable and passenger-full images!**

Install and enable memcached:

    # Opt-in for Memcached if you're using the 'customizable' image.
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

    # Ruby 1.9.3 (you can ignore the "1.9.1" suffix)
    RUN ruby-switch --set ruby1.9.1
    # Ruby 2.0.0
    RUN ruby-switch --set ruby2.0
    # Ruby 2.1.0
    RUN ruby-switch --set ruby2.1
    
<a name="running_startup_scripts"></a>
### Running scripts during container startup

passenger-docker uses the [baseimage-docker](http://phusion.github.io/baseimage-docker/) init system, `/sbin/my_init`. This init system runs the following scripts during startup, in the following order:

 * All executable scripts in `/etc/my_init.d`, if this directory exists. The scripts are run during in lexicographic order.
 * The script `/etc/rc.local`, if this file exists.

All scripts must exit correctly, e.g. with exit code 0. If any script exits with a non-zero exit code, the booting will fail.

The following example shows how you can add a startup script. This script simply logs the time of boot to the file /tmp/boottime.txt.

    ### In logtime.sh (make sure this file is chmod +x):
    #!/bin/sh
    date > /tmp/boottime.txt

    ### In Dockerfile:
    RUN mkdir -p /etc/my_init.d
    ADD logtime.sh /etc/my_init.d/logtime.sh

<a name="administering"></a>
## Administering the image's system

<a name="login"></a>
### Logging into the container with SSH

You can use SSH to login to any container that is based on passenger-docker-docker.

The first thing that you need to do is to ensure that you have the right SSH keys installed inside the container. By default, no keys are installed, so you can't login. For convenience reasons, we provide [a pregenerated, insecure key](https://github.com/phusion/baseimage-docker/blob/master/image/insecure_key) [(PuTTY format)](https://github.com/phusion/baseimage-docker/blob/master/image/insecure_key.ppk) that you can easily enable. However, please be aware that using this key is for convenience only. It does not provide any security because this key (both the public and the private side) is publicly available. **In production environments, you should use your own keys**.

<a name="using_the_insecure_key_for_one_container_only"></a>
#### Using the insecure key for one container only

You can temporarily enable the insecure key for one container only. This means that the insecure key is installed at container boot. If you `docker stop` and `docker start` the container, the insecure key will still be there, but if you use `docker run` to start a new container then that container will not contain the insecure key.

Start a container with `--enable-insecure-key`:

    docker run YOUR_IMAGE /sbin/my_init --enable-insecure-key

Find out the ID of the container that you just ran:

    docker ps

Once you have the ID, look for its IP address with:

    docker inspect <ID> | grep IPAddress

Now SSH into the container as follows:

    curl -o insecure_key -fSL https://github.com/phusion/baseimage-docker/raw/master/image/insecure_key
    chmod 600 insecure_key
    ssh -i insecure_key root@<IP address>

<a name="enabling_the_insecure_key_permanently"></a>
#### Enabling the insecure key permanently

It is also possible to enable the insecure key in the image permanently. This is not generally recommended, but it suitable for e.g. temporary development or demo environments where security does not matter.

Edit your Dockerfile to install the insecure key permanently:

    RUN /usr/sbin/enable_insecure_key

Instructions for logging in the container is the same as in section [Using the insecure key for one container only](#using_the_insecure_key_for_one_container_only).

<a name="using_your_own_key"></a>
#### Using your own key

Edit your Dockerfile to install an SSH key:

    ## Install an SSH of your choice.
    ADD your_key /tmp/your_key
    RUN cat /tmp/your_key >> /root/.ssh/authorized_keys && rm -f /tmp/your_key

Then rebuild your image. Once you have that, start a container based on that image:

    docker run your-image-name

Find out the ID of the container that you just ran:

    docker ps

Once you have the ID, look for its IP address with:

    docker inspect <ID> | grep IPAddress

Now SSH into the container as follows:

    ssh -i /path-to/your_key root@<IP address>

<a name="docker_bash"></a>
#### The `docker-bash` tool

Looking up the IP of a container and running an SSH command quickly becomes tedious. Luckily, [baseimage-docker](https://github.com/phusion/baseimage-docker) provides the `docker-bash` tool which automates this process. This tool is to be run on the *Docker host*, not inside a Docker container.

First, install the tool on the Docker host:

    curl --fail -L -O https://github.com/phusion/baseimage-docker/archive/master.tar.gz && \
    tar xzf master.tar.gz && \
    sudo ./baseimage-docker-master/install-tools.sh

Then run the tool as follows to login to a container using SSH:

    docker-bash YOUR-CONTAINER-ID

You can lookup `YOUR-CONTAINER-ID` by running `docker ps`.

By default, `docker-bash` will open a Bash session. You can also tell it to run a command, and then exit:

    docker-bash YOUR-CONTAINER-ID echo hello world

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

<a name="enterprise"></a>
### Switching to Phusion Passenger Enterprise

If you are a [Phusion Passenger Enterprise](https://www.phusionpassenger.com/enterprise) customer, then you can switch to the Enterprise variant as follows.

 1. Login to the [Customer Area](https://www.phusionpassenger.com/orders).
 2. Download the license key and store it in the same directory as your Dockerfile.
 3. Insert into your Dockerfile:

        ADD passenger-enterprise-license /etc/passenger-enterprise-license
        RUN echo deb https://download:$DOWNLOAD_TOKEN@www.phusionpassenger.com/enterprise_apt trusty main > /etc/apt/sources.list.d/passenger.list
        RUN apt-get update && apt-get install -y passenger-enterprise nginx-extras

    Replace `$DOWNLOAD_TOKEN` with your actual download token, as found in the Customer Area.

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

Build one of the images:

    make build_ruby19
    make build_ruby20
    make build_ruby21
    make build_nodejs
    make build_customizable
    make build_full

If you want to call the resulting image something else, pass the NAME variable, like this:

    make build NAME=joe/passenger

<a name="conclusion"></a>
## Conclusion

 * Using passenger-docker? [Tweet about us](https://twitter.com/share) or [follow us on Twitter](https://twitter.com/phusion_nl).
 * Having problems? Please post a message at [the discussion forum](https://groups.google.com/d/forum/passenger-docker).
 * Looking for a minimal image containing only a correct base system? Take a look at [baseimage-docker](https://github.com/phusion/baseimage-docker).

[<img src="http://www.phusion.nl/assets/logo.png">](http://www.phusion.nl/)

Please enjoy passenger-docker, a product by [Phusion](http://www.phusion.nl/). :-)
