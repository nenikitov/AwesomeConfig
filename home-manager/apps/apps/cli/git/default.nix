{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.ne.apps.git;
in
  with lib; {
    options = {
      ne.apps.git = {
        enable = mkEnableOption "git version control tool";
      };
    };
    config = mkIf cfg.enable {
      programs = {
        git = {
          enable = true;
          userName = "nenikitov";
        };
      };
    };
  }
