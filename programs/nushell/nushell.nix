{ config, ... }:

{
  programs.nushell = {
    enable = true;

    envFile.source = ./env.nu;

    configFile.source = ./config.nu;
    extraConfig = ''
      use ${config.xdg.configHome}/starship/init.nu
    '';
  };
}
