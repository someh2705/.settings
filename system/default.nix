{ pkgs, ... }:

{
  system.stateVersion = "24.05";
  environment.systemPackages = [
    pkgs.wget
    pkgs.lazygit
    pkgs.nixd
  ];
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  users.users.nixos.shell = pkgs.nushell;
}