{ config, pkgs, ... }:

{
  home.stateVersion = "23.05";

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fish.enable = true;
  programs.starship.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    fish
    starship
    neovim

    gnumake
    pkg-config
    unzip

    nodejs
    pnpm
    git
    coreutils
    fzf
    lazygit

    xclip
    curl
    fastfetch
    cmake
    ninja
    llvmPackages.clang

    llvmPackages.lldb
    clang-tools
    bear
    valgrind
   usbutils 
   
   		
    noto-fonts-cjk-sans
    qt6.qtbase

    (python3.withPackages (p: with p; [
      numpy
      matplotlib
      scipy
      pandas
      pyqt6
      pylatexenc
      
    ]))

    maple-mono.NF-CN-unhinted
    kitty
    noto-fonts-color-emoji

    yazi
    tree-sitter	     
    btop
    ripgrep
   	fd	
	imagemagick
	ghostscript
	tectonic
	trash-cli
	sqlite
	mermaid-cli
   kmod       
    pciutils
    vulkan-tools 
    mesa-demos    
   mesa	 	 	

   just		
   tmux
  ];
}