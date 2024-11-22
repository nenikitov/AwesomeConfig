{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.ne.apps.btop;
in
  with lib; {
    options.ne.apps.btop = {
      enable = mkEnableOption "btop system monitor";
    };
    config = mkIf cfg.enable {
      programs = {
        btop = {
          enable = true;
          settings = {
            color_theme = "TTY";
            theme_background = false;
            vim_keys = true;
          };
        };
      };
    };
  }
