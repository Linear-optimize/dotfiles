FROM node:20-slim

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"


RUN npm config set registry https://registry.npmmirror.com && \
    npm install -g pnpm && \
    pnpm config set registry https://registry.npmmirror.com

WORKDIR /app

EXPOSE 5173 8000


CMD [ "sh", "-c", "tail -f /dev/null" ]
