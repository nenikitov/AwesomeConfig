{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.ne.apps.alacritty;
in {
  options.ne.apps.alacritty = {
    enable = mkEnableOption "Alacritty terminal emulator";
  };
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          dynamic_padding = true;
          padding = {
            x = 6;
            y = 6;
          };
        };
        # TODO(nenikitov): See if theme can be somehow separated
        colors = {
          primary = {
            background = "#171A22";
            foreground = "#B7C2C8";
          };
          normal = {
            black = "#20232B";
            red = "#DA5261";
            green = "#56B877";
            yellow = "#DB8878";
            blue = "#4788F0";
            magenta = "#AF6ADB";
            cyan = "#49B2BB";
            white = "#8B909D";
          };
          bright = {
            black = "#555A66";
            red = "#fa788e";
            green = "#A7FA9C";
            yellow = "#F9C097";
            blue = "#81B5FF";
            magenta = "#D9A1FF";
            cyan = "#69F3FF";
            white = "#DDEBF2";
          };
        };
        selection.save_to_clipboard = true;
      };
    };
  };
}
