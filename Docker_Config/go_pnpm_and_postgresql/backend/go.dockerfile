FROM golang:latest


ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct \
    CGO_ENABLED=0 \
    GOPATH=/go \
    PATH=$PATH:/go/bin


COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh && /tmp/build.sh 

WORKDIR /workspace

ENTRYPOINT ["/usr/bin/fish"]