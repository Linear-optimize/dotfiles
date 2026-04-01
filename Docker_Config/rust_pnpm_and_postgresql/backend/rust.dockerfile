FROM rust:latest

ENV CARGO_HOME=/usr/local/cargo \
    RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static \
    RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -x && \
    sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
    apt-get update && apt-get install -y \
    gcc-x86-64-linux-gnu fish curl git pkg-config libssl-dev && \
    curl -sS https://starship.rs/install.sh | sh -s -- -y && \
    mkdir -p /etc/fish && \
    echo "starship init fish | source" >> /etc/fish/config.fish && \
    mkdir -p $CARGO_HOME && \
    printf '[source.crates-io]\nreplace-with = "ustc"\n[source.ustc]\nregistry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"\n' \
    > $CARGO_HOME/config.toml && \
    rustup target add x86_64-unknown-linux-musl && \
    apt-get autoclean && rm -rf /var/lib/apt/lists/*


WORKDIR /workspace
ENTRYPOINT ["/usr/bin/fish"]
