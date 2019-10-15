FROM ruby:2.6
MAINTAINER Rhuan Barreto <rhuan@rhuan.com.br>

EXPOSE 80

# Setup FreeTDS
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev nodejs libc6-dev
RUN wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.1.6.tar.gz && \
		tar -xzf freetds-1.1.6.tar.gz && \
		cd freetds-1.1.6 && \
		./configure --prefix=/usr/local --with-tdsver=7.3 && \
		make && \
		make install
