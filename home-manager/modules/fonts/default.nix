{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.ne.fonts;
in
  with lib; {
    options.ne.fonts = {
      enable = mkEnableOption "Custom fonts";
    };
    config = mkIf cfg.enable {
      fonts.fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = ["Mononoki" "Symbols Nerd Font"];
          sansSerif = ["Jost*" "Symbols Nerd Font"];
          serif = ["Jost*" "Symbols Nerd Font"];
        };
      };

      home.packages = with pkgs; [
        mononoki
        jost
        comfortaa
        corefonts
        vistafonts
        (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
      ];
    };
  }
