FROM node:20-slim
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"


RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
    apt-get update && apt-get install -y \
        gcc-x86-64-linux-gnu fish curl git pkg-config libssl-dev && \
    rm -rf /var/lib/apt/lists/*


RUN curl -sS https://starship.rs/install.sh | sh -s -- -y && \
    mkdir -p /etc/fish && \
    echo "starship init fish | source" >> /etc/fish/config.fish

RUN npm config set registry https://registry.npmmirror.com && \
    npm install -g pnpm && \
    pnpm config set registry https://registry.npmmirror.com

WORKDIR /app
EXPOSE 5173 8000
CMD ["sh", "-c", "tail -f /dev/null"]
