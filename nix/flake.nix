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

  outputs = { nixpkgs, home-manager, nixos-wsl, ... }:
    let
      system = "x86_64-linux";
      username = "rene";
    in {
      nixosConfigurations.${username} = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          nixos-wsl.nixosModules.wsl
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.${username} = import ./home.nix;
          }
          {
            nixpkgs.config.allowUnfree = true;
          }
          ./configuration.nix
        ];
      };
    };
}