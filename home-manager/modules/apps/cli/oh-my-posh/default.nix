{
  config,
  lib,
  ...
}: let
  cfg = config.ne.apps.oh-my-posh;
  # TODO(nenikitov): Find a better TTY detector
  icon = icon: tty:
  # gotmpl
  ''{{- if eq .Env.TERM "linux" -}}{{- "${tty}" -}}{{- else -}}{{- "${icon}" -}}{{- end -}}'';
in
  with lib; {
    options.ne.apps.oh-my-posh = {
      enable = mkEnableOption "Oh My Posh prompt";
    };
    config = mkIf cfg.enable {
      programs = {
        oh-my-posh = {
          enable = true;
          settings = {
            version = 3;
            final_space = true;
            console_title_template =
              #gotmpl
              ''
                {{- if or .Env.SSH_CONNECTION .Env.SSH_CLIENT .Env.SSH_TTY -}}
                  {{- .UserName -}}@{{- .HostName -}}{{- " " -}}
                {{- else if or .Root (ne .Env.LOGNAME .UserName) -}}
                  {{- .UserName -}}{{- " " -}}
                {{- end -}}

                in {{ .PWD }} via {{ .Shell -}}
              '';
            secondary_prompt = {
              template =
                # gotmpl
                ''<b>.</b>{{ " " }}'';
              foreground = "magenta";
            };
            blocks = [
              {
                type = "prompt";
                alignment = "left";
                segments = [
                  # Username (if SHH or different from logged in)
                  {
                    type = "session";
                    template =
                      # gotmpl
                      ''
                        {{- if .SSHSession -}}
                          <b><red>{{- .UserName -}}@{{- .HostName -}}</></b>{{- " " -}}
                        {{- else if or .Root (ne .Env.LOGNAME .UserName) -}}
                          <b><red>{{- .UserName -}}</></b>{{- " " -}}
                        {{- end -}}
                      '';
                    foreground = "default";
                  }
                  # Path
                  {
                    type = "path";
                    template =
                      #gotmpl
                      ''in <b><lightYellow>{{- .Path -}}</></b>{{- " " -}}'';
                    properties = {
                      style = "agnoster_full";
                    };
                    foreground = "default";
                  }
                  # Git
                  {
                    type = "git";
                    template =
                      #gotmpl
                      ''
                        on <b><green>

                        {{- if .Detached -}}
                          detached {{- " " -}}
                          {{- if gt (len .Commit.Refs.Tags) 0 -}}
                            ${icon " " "@"}{{- index .Commit.Refs.Tags 0 -}}
                          {{- else -}}
                            ${icon " " "#"}{{- printf "%.8s" .Commit.Sha -}}
                          {{- end -}}
                        {{- else -}}
                          {{- .Ref -}}
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

                        </></b>{{- " " -}}
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
                alignment = "right";
                segments = let
                  lang = {
                    type,
                    icon,
                    properties ? {},
                  }: {
                    inherit type;
                    inherit properties;
                    template =
                      # gotmpl
                      ''
                        {{- " " -}}<b><blue>
                        ${icon}
                        {{- " " -}}
                        {{- if .Error -}}{{- .Error -}}{{- else -}}{{- .Full -}}{{- end -}}
                        </></b>{{- "" -}}
                      '';
                    foreground = "default";
                  };
                in [
                  # Node
                  (lang {
                    type = "node";
                    icon =
                      #gotmpl
                      ''
                        {{- if eq .PackageManagerIcon "pnpm" -}}${icon "󰋁" "pnpm"}{{- end -}}
                        {{- if eq .PackageManagerIcon "yarn" -}}${icon "" "yarn"}{{- end -}}
                        {{- if eq .PackageManagerIcon "npm" -}}${icon " " "npm"}{{- end -}}
                      '';
                    properties = {
                      fetch_package_manager = true;
                      pnpm_icon = "pnmp";
                      yarn_icon = "yarn";
                      npm_icon = "npm";
                    };
                  })
                  # Lua
                  (lang {
                    type = "lua";
                    icon = icon "" "lua";
                  })
                  # Rust
                  (lang {
                    type = "rust";
                    icon = icon "" "rs";
                  })
                  # TODO(nenikitov): Add more languages
                ];
              }
              {
                type = "prompt";
                alignment = "left";
                newline = true;
                segments = [
                  # Sudo privileges (if still active)
                  # Character and sudo privileges (if still active)
                  {
                    type = "command";
                    template =
                      #gotmpl
                      ''
                        <b>
                          {{- if eq .Output "0" -}}!{{- end -}}
                          {{- ">" -}}
                        </b>{{- "" -}}
                      '';
                    properties = {
                      command =
                        #bash
                        ''sudo -vn &>/dev/null; echo $?'';
                    };
                    foreground = "red";
                    foreground_templates = [
                      #gotmpl
                      ''{{ if eq .Code 0 }}magenta{{ end }}''
                      #gotmpl
                      ''{{ if eq .Code 130 143 }}yellow{{ end }}''
                      #gotmpl
                      ''{{ if eq .Code 127 }}lightRed{{ end }}''
                    ];
                  }
                ];
              }
              {
                type = "rprompt";
                overflow = "hidden";
                segments = [
                  # Execution time (if long)
                  {
                    type = "executiontime";
                    properties = {
                      style = "lucky7";
                    };
                    template =
                      #gotmpl
                      ''{{- "  " -}}<b><cyan>{{ .FormattedMs | replace " " "" }}</></b>'';
                    foreground = "default";
                  }
                  # Exit code (if non-zero)
                  {
                    type = "status";
                    template =
                      #gotmpl
                      ''{{- " " -}}<b><blue>{{ .String }}</></blue>'';
                    foreground = "default";
                  }
                ];
              }
            ];
          };
        };
      };
    };
  }
