{ ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/direnv.nix

    # shell
    ./programs/nushell/nushell.nix
  ];

  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}