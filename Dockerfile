FROM ruby:2.3
MAINTAINER easySubsea <contact@easysubsea.com>

EXPOSE 80 2222

# Setup FreeTDS
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libc6-dev
RUN wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.00.27.tar.gz && tar -xzf freetds-1.00.27.tar.gz && cd freetds-1.00.27 && ./configure --prefix=/usr/local --with-tdsver=7.3 && make && make install

# Setup SSH
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update && apt-get install -y --no-install-recommends dialog && apt-get update && apt-get install -y --no-install-recommends openssh-server && echo "$SSH_PASSWD" | chpasswd
COPY sshd_config /etc/ssh/
RUN service ssh start
