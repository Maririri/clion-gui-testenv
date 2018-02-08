FROM ubuntu:16.04

RUN groupadd -r --gid 1001 test \
 && useradd --no-log-init --create-home -g test -r --uid 1001 test \
 && mkdir -p /etc/sudoers.d \
 && echo "test ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/test \
 && chmod 0440 /etc/sudoers.d/test

RUN apt-get update && apt-get install -y --no-install-recommends \
    ant \
    sudo \
    build-essential \
    openjdk-8-jdk \
 && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /bin/sh sh /bin/dash 10 \
 && update-alternatives --install /bin/sh sh /bin/bash 100

USER test
WORKDIR /home/test