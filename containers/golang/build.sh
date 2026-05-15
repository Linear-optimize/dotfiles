#!/bin/sh
set -e
set -x

if [ -f /etc/apt/sources.list.d/debian.sources ]; then
    sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
fi


apt-get update
apt-get install -y --no-install-recommends gcc libc6-dev make git curl fish


curl -sS https://starship.rs/install.sh | sh -s -- -y


mkdir -p /etc/fish/
echo "starship init fish | source" >> /etc/fish/config.fish


apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*