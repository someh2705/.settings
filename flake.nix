{
  description = "A wsl settings with vscode";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixd.url = "github:nix-community/nixd";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = inputs@{ self, ... }:
    let 
      systemSettings = {
        system = "x86_64-linux";
      };

      userSettings = {
        profile = "someh";
      };

      pkgs = import inputs.nixpkgs {
        system = systemSettings.system;
        overlays = [ inputs.nix.overlays.default ];
      };

      lib = inputs.nixpkgs.lib;
      
      home-manager = inputs.home-manager;

      supportedSystems = [ "x86_64-linux" ];

      forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;
    in {
      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ (import ./home) ];
          specialArgs = {
            inherit userSettings;
          };
        };
      };

      nixosConfigurations = {
        system = lib.nixosSystem {
          system = systemSettings.system;
          modules = [ (import ./system) ];
          specialArgs = {
            inherit userSettings;
          };
        };
      };

      packages = forAllSystems (system: {
        default = self.packages.${system}.install;
      });

      app = forAllSystems (system: {
        default = self.apps.${system}.install;
      });
    };
}
