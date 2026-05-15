# flake.nix
{
  description = "Rust development environment with Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        
       
        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" "clippy" "rustfmt" ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            rustToolchain
            pkg-config
            openssl
            cargo-edit
            bacon
            cargo-cache
          ];

          shellHook = ''
            mkdir -p .cargo
            if [ ! -f .cargo/config.toml ]; then
              cat > .cargo/config.toml << 'EOF'
[source.crates-io]
replace-with = 'aliyun'

[source.aliyun]
registry = "sparse+https://mirrors.aliyun.com/crates.io-index/"

[net]
git-fetch-with-cli = true
EOF
            fi
            export CARGO_HOME="$(pwd)/.cargo"
            
           
            export RUST_SRC_PATH="${rustToolchain}/lib/rustlib/src/rust/library"
            
            echo "🚀 Rust Flakes 环境已激活!"
            echo "Rustc: $(rustc --version)"
            echo "Cargo: $(cargo --version)"
            echo "Rust Analyzer: $(rust-analyzer --version)"
            echo ""
            echo "📦 可用命令:"
            echo "  cargo add <pkg>    # 添加依赖"
            echo "  bacon              # 后台检查工具"
            echo "  cargo fmt          # 代码格式化"
            echo "  cargo clippy       # 代码检查"
          '';
        };
      }
    );
}