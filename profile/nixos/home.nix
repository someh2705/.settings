{ ... }:

{
  imports = [
    ../../programs/nushell/nushell.nix
    ../../programs/git.nix
  ];

  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}