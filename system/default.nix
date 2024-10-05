{ pkgs, ... }:

{
  system.stateVersion = "24.05";
  environment.systemPackages = [
    pkgs.wget
    pkgs.lazygit
  ];
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  users.users.nixos.shell = pkgs.nushell;
}