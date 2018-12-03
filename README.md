# ruby-freetds
A minimal docker container with ruby and FreeTDS for use in many environments.

[![docker](http://dockeri.co/image/rhuan/ruby-freetds "docker")](https://registry.hub.docker.com/u/rhuan/ruby-freetds/)

CI Status: [![Build Status](https://travis-ci.org/rhuanbarreto/ruby-freetds.svg?branch=master)](https://travis-ci.org/rhuanbarreto/ruby-freetds)

# Instructions

The base image is the [official ruby image](https://hub.docker.com/_/ruby/). More information on how to use it you can find on their documentation.

# Conttributions

All conttributions are welcome! Put a star in the repo and follow up the updates! If you need to add something on the image, please open a pull request and I will be glad to review your proposal!

# Supported tags and respective `Dockerfile` links

- 2.5 (2.5/stretch/Dockerfile)
- 2.5-slim (2.5/slim/Dockerfile)
- 2.4 (2.4/stretch/Dockerfile)
- 2.4-slim (2.4/slim/Dockerfile)
- 2.3 (2.3/stretch/Dockerfile)
- 2.3-slim (2.3/slim/Dockerfile)

# Quick reference

-	**Where to get help**:  
	[the Docker Community Forums](https://forums.docker.com/), [the Docker Community Slack](https://blog.docker.com/2016/11/introducing-docker-community-directory-docker-community-slack/), or [Stack Overflow](https://stackoverflow.com/search?tab=newest&q=docker)

-	**Where to file issues**:  
	[https://github.com/rhuanbarreto/ruby-freetds/issues](https://github.com/rhuanbarreto/ruby-freetds/issues)

-	**Maintained by**:  
	[Rhuan Samary Barreto](https://github.com/rhuanbarreto/)

-	**Supported architectures**: ([more info](https://github.com/docker-library/official-images#architectures-other-than-amd64))  
	[`amd64`](https://hub.docker.com/r/amd64/ruby/), [`arm32v5`](https://hub.docker.com/r/arm32v5/ruby/), [`arm32v6`](https://hub.docker.com/r/arm32v6/ruby/), [`arm32v7`](https://hub.docker.com/r/arm32v7/ruby/), [`arm64v8`](https://hub.docker.com/r/arm64v8/ruby/), [`i386`](https://hub.docker.com/r/i386/ruby/), [`ppc64le`](https://hub.docker.com/r/ppc64le/ruby/), [`s390x`](https://hub.docker.com/r/s390x/ruby/)

-	**Supported Docker versions**:  
	[the latest release](https://github.com/docker/docker-ce/releases/latest) (down to 1.6 on a best-effort basis)

# What is Ruby?

Ruby is a dynamic, reflective, object-oriented, general-purpose, open-source programming language. According to its authors, Ruby was influenced by Perl, Smalltalk, Eiffel, Ada, and Lisp. It supports multiple programming paradigms, including functional, object-oriented, and imperative. It also has a dynamic type system and automatic memory management.

> [wikipedia.org/wiki/Ruby_(programming_language)](https://en.wikipedia.org/wiki/Ruby_%28programming_language%29)

![logo](https://raw.githubusercontent.com/docker-library/docs/01c12653951b2fe592c1f93a13b4e289ada0e3a1/ruby/logo.png)

# How to use this image

## Create a `Dockerfile` in your Ruby app project

```dockerfile
FROM rhuan/ruby-freetds:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["./your-daemon-or-script.rb"]
```

Put this file in the root of your app, next to the `Gemfile`.

You can then build and run the Ruby image:

```console
$ docker build -t my-ruby-app .
$ docker run -it --name my-running-script my-ruby-app
```

### Generate a `Gemfile.lock`

The above example `Dockerfile` expects a `Gemfile.lock` in your app directory. This `docker run` will help you generate one. Run it in the root of your app, next to the `Gemfile`:

```console
$ docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.5 bundle install
```

## Run a single Ruby script

For many simple, single file projects, you may find it inconvenient to write a complete `Dockerfile`. In such cases, you can run a Ruby script by using the Ruby Docker image directly:

```console
$ docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp rhuan/ruby-freetds:2.5 ruby your-daemon-or-script.rb
```

## Encoding

By default, Ruby inherits the locale of the environment in which it is run. For most users running Ruby on their desktop systems, that means it's likely using some variation of `*.UTF-8` (`en_US.UTF-8`, etc). In Docker however, the default locale is `C`, which can have unexpected results. If your application needs to interact with UTF-8, it is recommended that you explicitly adjust the locale of your image/container via `-e LANG=C.UTF-8` or `ENV LANG C.UTF-8`.

## Image assumptions

This image sets several environment variables which change the behavior of Bundler and Gem for running a single application within a container (especially in such a way that the development sources of the application can be bind-mounted inside a container and not have `.bundle` from the host interfere with the proper functionality of the container).

The environment variables we set are canonically listed in the above-linked `Dockerfiles`, but some of them include `GEM_HOME`, `BUNDLE_PATH`, `BUNDLE_BIN`, `BUNDLE_SILENCE_ROOT_WARNING`, and `BUNDLE_APP_CONFIG`.

If these cause issues for your use case (running multiple Ruby applications in a single container, for example), setting them to the empty string *should* be sufficient for undoing their behavior.

# Image Variants

The `ruby-freetds` images come in many flavors, each designed for a specific use case.

## `rhuan/ruby-freetds:<version>`

This is the defacto image. If you are unsure about what your needs are, you probably want to use this one. It is designed to be used both as a throw away container (mount your source code and start the container to start your app), as well as the base to build other images off of.

This tag is based off of [`buildpack-deps`](https://hub.docker.com/_/buildpack-deps/). `buildpack-deps` is designed for the average user of Docker who has many images on their system. It, by design, has a large number of extremely common Debian packages. This reduces the number of packages that images that derive from it need to install, thus reducing the overall size of all images on your system.

Some of these tags may have names like jessie or stretch in them. These are the suite code names for releases of [Debian](https://wiki.debian.org/DebianReleases) and indicate which release the image is based on.

## `rhuan/ruby-freetds:<version>-slim`

This image does not contain the common packages contained in the default tag and only contains the minimal packages needed to run `ruby`. Unless you are working in an environment where *only* the `ruby` image will be deployed and you have space constraints, we highly recommend using the default image of this repository.
