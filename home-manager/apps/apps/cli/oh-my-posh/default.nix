{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.ne.apps.oh-my-posh;
in
  with lib; {
    options = {
      ne.apps.oh-my-posh = {
        enable = mkEnableOption "Oh My Posh prompt";
      };
    };
    config = mkIf cfg.enable {
      programs = {
        oh-my-posh = {
          enable = true;
          settings = {
            version = 3;
            final_space = true;
            blocks = [
              {
                type = "prompt";
                alignment = "left";
                segments = [
                  {
                    type = "session";
                    template = concatStrings [
                      "{{ if or .Root .SSHSession (ne .Env.LOGNAME .UserName) }}"
                      "<b><red>{{- .UserName -}}</></b> in "
                      "{{ end }}"
                    ];
                    foreground = "default";
                  }
                  {
                    type = "path";
                    template = "<b>{{ .Path }}</b>";
                    properties = {
                      style = "agnoster_full";
                    };
                    foreground = "lightYellow";
                  }
                ];
              }
              {
                type = "prompt";
                alignment = "left";
                newline = true;
                segments = [
                  {
                    type = "text";
                    template = "<b>\></b>";
                    foreground = "red";
                  }
                ];
              }
            ];
          };
        };
      };
    };
  }
