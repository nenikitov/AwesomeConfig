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
                    template = ''
                      {{- if or .Root .SSHSession (ne .Env.LOGNAME .UserName) -}}
                        <b><red>{{ .UserName }}</></b> {{- " " -}}
                      {{- end -}}
                    '';
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
                    template = ''
                      on <b><green>

                      {{- if .Detached -}}
                        detached {{- " " -}}
                        {{- if gt (len .Commit.Refs.Tags) 0 -}}
                          ${icon " " "@"}{{ index .Commit.Refs.Tags 0 }}
                        {{- else -}}
                          ${icon " " "#"}{{ printf "%.8s" .Commit.Sha }}
                        {{- end -}}
                      {{- else -}}
                        {{ .Ref }}
                      {{- end -}}

                      {{- " " -}}
                      {{- if or .Working.Changed .Staging.Changed -}}*{{- end -}}
                      {{- if gt .Behind 0 -}}↓{{- end -}}
                      {{- if gt .Ahead 0 -}}↑{{- end -}}
                      {{- " " -}}
                      {{- if .Rebase -}}${icon " " "b"}{{- end -}}
                      {{- if .CherryPick -}}${icon "⚡" "c"}{{- end -}}
                      {{- if .Revert -}}${icon " " "r"}{{- end -}}
                      {{- if .Merge -}}${icon " " "m"}{{- end -}}

                      </></b> {{- " " -}}
                    '';
                    properties = {
                      fetch_status = true;
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
                    foreground_templates = [
                      "{{ if eq .Code 0 }}magenta{{ end }}"
                      "{{ if eq .Code 130 143 }}yellow{{ end }}"
                      "{{ if eq .Code 127 }}lightRed{{ end }}"
                    ];
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
