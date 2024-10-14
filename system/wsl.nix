{ pkgs, nixos-wsl, userSettings, ... }:

{
  imports = [
    nixos-wsl.nixosModules.wsl
  ];

  wsl.enable = true;
  wsl.defaultUser = userSettings.profile;
  wsl.extraBin = with pkgs; [
    { src = "${coreutils}/bin/uname"; }
    { src = "${coreutils}/bin/dirname}"; }
    { src = "${coreutils}/bin/readlink"; }
  ];
}
