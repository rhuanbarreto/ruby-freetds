FROM ruby:2.3
MAINTAINER Rhuan Barreto <rhuan@rhuan.com.br>

EXPOSE 80

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev nodejs libc6-dev openssl
# Setup FreeTDS
RUN wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.1.24.tar.gz && \
		tar -xzf freetds-1.1.24.tar.gz && \
		cd freetds-1.1.24 && \
		./configure --prefix=/usr/local --with-tdsver=7.3 && \
		make && \
		make install
# Install Latest Bundler
RUN gem install bundler
