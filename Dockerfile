FROM debian:buster
RUN apt update
RUN apt install -y \
    pipenv \
    git \
    golang \
    graphicsmagick \
    jq

RUN \
    go get -u github.com/technosophos/dashing && \
    cp $(go env GOPATH)/bin/dashing /usr/local/bin
