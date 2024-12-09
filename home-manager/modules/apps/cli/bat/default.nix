{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.ne.apps.bat;
in {
  options.ne.apps.bat = {
    enable = mkEnableOption "bat file previewer";
  };
  config = mkIf cfg.enable {
    programs = {
      bat = {
        enable = true;
        config = {
          paging = "always";
          theme = "netheme";
        };
        themes = {
          netheme = {
            src = ./netheme.tmTheme;
          };
        };
      };
    };
  };
}
