{ pkgs, ... }:

{
  system.stateVersion = "24.05";
  environment.systemPackages = [
    pkgs.wget
  ];
  users.users.nixos.shell = pkgs.nushell;
}