{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.ne.apps.oh-my-posh;
  # TODO(nenikitov): Find a better TTY detector
  icon = icon: tty: ''{{ if eq .Env.TERM "linux" }}${tty}{{ else }}${icon}{{ end }}'';
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
                  # Username (if SHH or different from logged in)
                  {
                    type = "session";
                    template = concatStrings [
                      "{{ if or .Root .SSHSession (ne .Env.LOGNAME .UserName) }}"
                      "<b><red>{{- .UserName -}}</></b> "
                      "{{ end }}"
                    ];
                    foreground = "default";
                  }
                  # Path
                  {
                    type = "path";
                    template = "in <b><lightYellow>{{ .Path }}</></b> ";
                    properties = {
                      style = "agnoster_full";
                    };
                    foreground = "default";
                  }
                  # Git
                  {
                    type = "git";
                    template = concatStrings [
                      "on <b><green>{{- .HEAD -}}</></b> "
                    ];
                    properties = {
                      fetch_status = true;
                      # branch_icon = "";
                      # branch_identical_icon = "";
                      # branch_ahead_icon = "";
                      # branch_behind_icon = "";
                      # branch_gone_icon = "";
                    };
                    foreground = "default";
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
