FROM debian:bookworm
RUN apt update
RUN apt install -y \
    python3 \
    python3-lxml \
    python3-markdown \
    python3-jinja2 \
    git \
    golang \
    graphicsmagick \
    jq

RUN \
    go install github.com/technosophos/dashing@master && \
    cp $(go env GOPATH)/bin/dashing /usr/local/bin
