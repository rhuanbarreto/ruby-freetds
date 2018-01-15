FROM ruby:2.3-alpine
MAINTAINER easySubsea <contact@easysubsea.com>

EXPOSE 80 2222

# Setup FreeTDS
RUN apk update && apk add freetds
