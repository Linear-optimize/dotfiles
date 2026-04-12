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
       
            mkdir -p .go/path .go/cache

         
            export GOPATH="$(pwd)/.go/path"
            export GOCACHE="$(pwd)/.go/cache"
            export GOENV="$(pwd)/.go/env"

        
            export PATH="$GOPATH/bin:$PATH"

            export GO111MODULE="on"
            export GOPROXY="https://goproxy.cn,direct"

            
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
