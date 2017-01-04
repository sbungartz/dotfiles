FROM ubuntu:16.04

RUN apt-get update && \
    apt-get -y install sudo

RUN apt-get -y install git
RUN apt-get -y install zsh

RUN useradd -ms /bin/bash testuser && echo "testuser:pass" | chpasswd && adduser testuser sudo

USER testuser
WORKDIR /home/testuser
