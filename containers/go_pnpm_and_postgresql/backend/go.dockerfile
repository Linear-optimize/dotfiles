FROM golang:latest
ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct \
    CGO_ENABLED=0 \
    GOPATH=/go \
    PATH=$PATH:/go/bin
RUN set -x && \
    sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
    apt-get update && apt-get install -y --no-install-recommends  \
    gcc libc6-dev make git curl fish && \
    curl -sS https://starship.rs/install.sh | sh -s -- -y && \
    mkdir -p /etc/fish && \
    echo "starship init fish | source" >> /etc/fish/config.fish && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    go install golang.org/x/tools/gopls@lates &&\
    rm -rf /tmp/* 

WORKDIR /workspace    
ENTRYPOINT ["/usr/bin/fish"]    