{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.gcc
    pkgs.gdb
    pkgs.cmake
    pkgs.ninja
    pkgs.vcpkg
  ];
}