{
  description = "WSL + Home Manager + nixos-unstable";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }:
  {
    nixosConfigurations.rene = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        nixos-wsl.nixosModules.wsl
        home-manager.nixosModules.home-manager
        
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.rene = import ./home.nix;
        }
     
        {
          nixpkgs.config.allowUnfree = true;
        }

        ./configuration.nix
      ];
    };
  };
}