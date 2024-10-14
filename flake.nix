{
  description = "A wsl settings with vscode";

  outputs = input@{ self, nixpkgs, nixos-wsl, home-manager, vscode-server, nixd, ... }:
    let
      system = "x86_64-linux";
      profile = "nixos";
      pkgs = (import nixpkgs {
        inherit system;
      });
    in {
      nixosConfigurations."${profile}" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (./. + "/profile" + ("/" + profile) + "/configuration.nix")

          nixos-wsl.nixosModules.default
          vscode-server.nixosModules.default
          home-manager.nixosModules.default

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users."${profile}" = (./. + "/profile" + ("/" + profile) + "/home.nix");
            };
          }

          { nixpkgs.overlays = [ nixd.overlays.default ]; }
        ];
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixd.url = "github:nix-community/nixd";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };
}
