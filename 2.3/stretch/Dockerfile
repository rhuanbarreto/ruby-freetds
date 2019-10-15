FROM ruby:2.3
MAINTAINER Rhuan Barreto <rhuan@rhuan.com.br>

EXPOSE 80

# Setup FreeTDS
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev nodejs libc6-dev openssl
RUN wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.1.6.tar.gz && \
		tar -xzf freetds-1.1.6.tar.gz && \
		cd freetds-1.1.6 && \
		./configure --prefix=/usr/local --with-tdsver=7.3 && \
		make && \
		make install
RUN gem install bundler
