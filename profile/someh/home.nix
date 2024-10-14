{ userSettings, ... }:

{
  imports = [
    ../../user/nushell.nix

    ../../shell
  ];

  home = {
    username = userSettings.profile;
    homeDirectory = "/home/${userSettings.profile}";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}