FROM ubuntu:xenial
LABEL description="GenieACS Box - GenieACS + GUI"
LABEL version="1.0"
LABEL maintainer="Jonas Moura - jonas.w.moura@gmail.com"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq > /dev/null 2>&1 && \
    apt-get upgrade -qq -y > /dev/null 2>&1 && \
    apt-get install -qq -y --no-install-recommends \
    apt-utils \
    bash-completion \
    apt-transport-https \
    iputils-ping \
    netstat-nat \
    net-tools \
    nano \
    unzip \
    wget \
    curl \
    dos2unix \
    build-essential \
    git \
    software-properties-common \
    python-software-properties \
    sudo \
    tzdata \
    autoconf \
    bison \
    build-essential \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm3 \
    libgdbm-dev \
libsqlite3-dev > /dev/null 2>&1
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - > /dev/null 2>&1 && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - > /dev/null 2>&1 && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list > /dev/null 2>&1 && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 > /dev/null 2>&1 && \
    echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list > /dev/null 2>&1 && \
    apt-get update -qq > /dev/null 2>&1 && \
    apt-get install -qq -y --no-install-recommends nodejs yarn mongodb-org > /dev/null 2>&1 && \
rm -rf /var/lib/apt/lists/*

COPY bootscript.sh install.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*

ENTRYPOINT /usr/local/bin/bootscript.sh && /bin/bash
