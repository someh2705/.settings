{ vscode-server, ... }:

{
  imports = [
    vscode-server.nixosModules.default
  ];

  programs.nix-ld.enable = true;
  services.vscode-server.enable = true;
}
