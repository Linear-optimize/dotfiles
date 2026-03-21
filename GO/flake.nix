{
  description = "Go development environment with isolated local GOPATH";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            go          
            gopls       
            go-tools    
            delve       
            impl
            gotests
            golangci-lint
          ];

          shellHook = ''
            # 1. 创建项目私有的 Go 目录
            mkdir -p .go/path .go/cache

            # 2. 隔离环境变量，只影响当前 Shell
            export GOPATH="$(pwd)/.go/path"
            export GOCACHE="$(pwd)/.go/cache"
            export GOENV="$(pwd)/.go/env"

            # 将私有 GOPATH 的 bin 加入 PATH，方便直接运行安装的工具
            export PATH="$GOPATH/bin:$PATH"

            # 3. 设置国内镜像加速 (锁定在当前环境)
            export GO111MODULE="on"
            export GOPROXY="https://goproxy.cn,direct"

            # 4. 自动创建本地 go.env (可选)
            if [ ! -f .go/env ]; then
              go env -w GOPROXY=https://goproxy.cn,direct
              go env -w GO111MODULE=on
            fi

            echo "🐹 Go Flakes 环境已激活!"
            echo "Go Version: $(go version)"
            echo "GOPATH (Isolated): $GOPATH"
            echo "GOPROXY: $GOPROXY"
            echo ""
            echo "📦 本地环境提示:"
            echo "  所有依赖包将下载至 .go/path"
            echo "  编译缓存将存储在 .go/cache"
          '';
        };
      }
    );
}
