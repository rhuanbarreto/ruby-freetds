FROM ruby:2.3-alpine
MAINTAINER Rhuan Barreto <rhuan@rhuan.com.br>

EXPOSE 80

# Setup FreeTDS
RUN apk update && apk add --no-cache freetds-dev

# Setup Dependencies

ENV BUILD_PACKAGES="build-base"
ENV DEV_PACKAGES="libxml2-dev libxslt-dev sqlite-dev nodejs"
ENV RAILS_DEPS="ca-certificates tzdata"

RUN apk add --no-cache --update --upgrade --virtual .railsdeps \
		$BUILD_PACKAGES $DEV_PACKAGES \
	  && rm -rf /var/cache/apk/*

# Install Latest Bundler
RUN gem install bundler