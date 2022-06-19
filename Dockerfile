FROM ubuntu:20.04
MAINTAINER BiomeHub
ENV DEBIAN_FRONTEND noninteractive

LABEL version="1.1"
LABEL software.version="1.1"
LABEL software="fastuniq"

# install dependencies and cleanup apt garbage
RUN apt-get update && apt-get -y install \
 wget \
 ca-certificates \
 build-essential libtool automake zlib1g-dev libbz2-dev pkg-config \
 make \
 g++ \
 rsync \
 cpanminus \
 bash 

# perl module required for kraken2-build
RUN cpanm Getopt::Std


# DL Kraken2, unpack, and install
RUN wget https://sourceforge.net/projects/fastuniq/files/latest/download -O fastuniq.tar.gz  && \
 tar -xzf fastuniq.tar.gz && \
 rm -rf fastuniq.tar.gz && \
 cd FastUniq/source && \
 make
 
RUN mv  FastUniq/source/fastuniq .

ENV PATH ./:$PATH