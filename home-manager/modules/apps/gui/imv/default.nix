{
  config,
  lib,
  ...
}: let
  cfg = config.ne.apps.imv;
in
  with lib; {
    options.ne.apps.imv = {
      enable = mkEnableOption "imv image viewer";
    };
    config = mkIf cfg.enable {
      programs.imv = {
        enable = true;
      };
      # HACK(nenikitov): Add all options under `programs.imv` instead of writing to the file if this gets fixed
      # Because it auto-orders sections and `binds` is before `options.suppress_default_binds`
      # So custom binds get cleared
      # https://github.com/nix-community/home-manager/pull/3481#issuecomment-1584725951
      home.file.".config/imv/config".text =
        # dosini
        ''
          [options]
          background=checks
          overlay=true
          overlay_font=monospace:11
          suppress_default_binds=true

          [binds]
          q=quit
          l=next
        '';
    };
  }
