{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        dynamic_padding = true;
        dimensions = {
          columns = 120;
          lines = 35;
        };
        padding = {
          x = 6;
          y = 6;
        };
      };
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
    };
  };
}
