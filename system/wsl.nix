{ pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.extraBin = with pkgs; [
    { src = "${coreutils}/bin/uname"; }
    { src = "${coreutils}/bin/dirname}"; }
    { src = "${coreutils}/bin/readlink"; }
  ];
}
