FROM rust:latest

ENV CARGO_HOME=/usr/local/cargo \
    RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static \
    RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup \
    PATH=/usr/local/cargo/bin:$PATH

COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh && /tmp/build.sh && rm /tmp/build.sh

WORKDIR /workspace
ENTRYPOINT ["/usr/bin/fish"]
