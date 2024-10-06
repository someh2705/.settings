{
  description = "A wsl settings with vscode";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixd.url = "github:nix-community/nixd";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs =
    {
      nixpkgs,
      nixos-wsl,
      home-manager,
      vscode-server,
      nixd,
      ...
    }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (import ./system)
          (import ./develop)

          (import ./system/wsl.nix)
          nixos-wsl.nixosModules.wsl

          (import ./system/vscode.nix)
          vscode-server.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nixos = (import ./home);
            };
          }

          { nixpkgs.overlays = [ nixd.overlays.default ]; }
        ];
      };
    };
}
