{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.openjdk
    pkgs.gradle
  ];
}
