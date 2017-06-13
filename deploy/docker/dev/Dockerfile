FROM ubuntu:latest
MAINTAINER Xackery <xackery@gmail.com>

# Prep
ENV GOPATH /go
ENV USER root
COPY . /go/src/github.com/xackery/sr-stats
WORKDIR /go/src/github.com/xackery/sr-stats
#RUN git config --global url."https://${GITHUB_TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"
RUN cd /go/src/github.com/xackery/ \
 	&& git clone https://${GITHUB_TOKEN}:x-oauth-basic@github.com/xackery/sr-core

# Test
RUN cd /go/src/github.com/xackery/sr-stats
RUN go get -d -v
RUN go test github.com/xackery/sr-stats...

# Build
RUN mkdir -p /go/src/github.com/xackery/sr-stats
RUN go install
RUN go-wrapper download && go-wrapper install
COPY . /go/src/github.com/xackery/sr-stats
CMD ["go-wrapper", "run"]
0
