{ config, ... }:

{
  programs.starship = {
    enable = true;
    enableNushellIntegration = false;
  };

  home.file."${config.xdg.configHome}/starship/starship.toml" = {
    source = ./starship.toml;
    recursive = true;
  };

  home.file."${config.xdg.configHome}/starship/init.nu" = {
    text = ''
      export-env { $env.STARSHIP_SHELL = "nu"; load-env {
          STARSHIP_SESSION_KEY: (random chars -l 16)
          STARSHIP_CONFIG: '${config.xdg.configHome}/starship/starship.toml'
          PROMPT_MULTILINE_INDICATOR: (
              ^/etc/profiles/per-user/nixos/bin/starship prompt --continuation
          )

          PROMPT_INDICATOR: ""

          PROMPT_COMMAND: {||
              (
                  ^/etc/profiles/per-user/nixos/bin/starship prompt
                      --cmd-duration $env.CMD_DURATION_MS
                      $"--status=($env.LAST_EXIT_CODE)"
                      --terminal-width (term size).columns
              )
          }

          config: ($env.config? | default {} | merge {
              render_right_prompt_on_last_line: true
          })

          PROMPT_COMMAND_RIGHT: {||
              (
                  ^/etc/profiles/per-user/nixos/bin/starship prompt
                      --right
                      --cmd-duration $env.CMD_DURATION_MS
                      $"--status=($env.LAST_EXIT_CODE)"
                      --terminal-width (term size).columns
              )
          }
      }}
    '';
    recursive = true;
  };
}