#!/bin/sh
set -x

sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources

apt-get update && apt-get install -y \
    gcc-x86-64-linux-gnu fish curl git pkg-config libssl-dev


curl -sS https://starship.rs/install.sh | sh -s -- -y
mkdir -p /etc/fish && echo "starship init fish | source" >> /etc/fish/config.fish


mkdir -p $CARGO_HOME
cat << EOF > $CARGO_HOME/config.toml
[source.crates-io]
replace-with = 'ustc'
[source.ustc]
registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"
EOF

rustup target add x86_64-unknown-linux-musl


apt-get autoclean && rm -rf /var/lib/apt/lists/*