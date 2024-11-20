{pkgs, ...}: {
  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Mononoki" "NerdFontsSymbolsOnly"];})
    jost
    corefonts
    vistafonts
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["Mononoki Nerd Font"];
      sansSerif = ["Jost*" "Symbols Nerd Font"];
      serif = ["Jost*" "Symbols Nerd Font"];
    };
  };
}
