FROM golang:1.13-alpine as builder
RUN apk add git gcc libc-dev make
WORKDIR "/go/src/github.com/TechLoCo/ride-locust"
COPY . .
ENV GO111MODULE=on\
    TZ=Asia/Tokyo
RUN go get -u golang.org/x/lint/golint
RUN make all

FROM alpine
RUN apk update && apk add ca-certificates tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    rm -rf /var/cache/apk/*
ENV TZ=Asia/Tokyo

COPY --from=builder /go/src/github.com/TechLoCo/ride-locust/bin/ride-locust ./


#FROM golang:1.13-stretch
#
#LABEL maintainer fukumoto
#
#SHELL ["/bin/bash", "-c"]
#ENV GO111MODULE on
#WORKDIR /ride-locust
#
## install mysql<=いらない
#RUN apt update
#RUN apt install -y mysql-client vim zip unzip
#RUN apt-get install -y default-libmysqlclient-dev
#
## install ruby<=いらない
#RUN apt-cache search zlib dev
#RUN apt-get install -y bzip2 libssl-dev libreadline-dev zlib1g-dev zlib1g-dev
#RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
#RUN cd ~/.rbenv && src/configure && make -C src
#ENV PATH /root/.rbenv/bin:$PATH
#RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
#RUN source ~/.bashrc
#RUN mkdir -p "$(rbenv root)"/plugins
#RUN git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
#RUN rbenv install 2.6.3
#RUN rbenv global 2.6.3
#
## install bundler
#RUN rbenv exec gem install bundler && rbenv rehash
#
## install ja utf-8 for ruby stdout and stderr
#RUN apt-get install -y locales
#RUN sed -i 's/#.*ja_JP\.UTF/ja_JP\.UTF/' /etc/locale.gen
#RUN locale-gen
#RUN update-locale LANG=ja_JP.UTF-8
#ENV LANG ja_JP.UTF-8
#ENV LC_CTYPE ja_JP.UTF-8