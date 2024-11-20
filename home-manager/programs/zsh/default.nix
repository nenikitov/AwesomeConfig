{
  pkgs,
  lib,
  ...
}: {
  programs = {
    zsh = let
      black = {
        normal = "0";
        bright = "8";
      };
      red = {
        normal = "1";
        bright = "9";
      };
      green = {
        normal = "2";
        bright = "10";
      };
      yellow = {
        normal = "3";
        bright = "11";
      };
      blue = {
        normal = "4";
        bright = "12";
      };
      magenta = {
        normal = "5";
        bright = "13";
      };
      cyan = {
        normal = "6";
        bright = "14";
      };
      white = {
        normal = "7";
        bright = "15";
      };
    in {
      enable = true;
      dotDir = ".config/zsh";

      history = {
        append = true;
        size = 100000;
      };

      enableVteIntegration = true;

      initExtra = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      '';

      defaultKeymap = "viins";

      autosuggestion = {
        enable = true;
        strategy = [
          "history"
          "completion"
        ];
      };

      completionInit =
        ''
          autoload -U compinit && compinit
          autoload -U bashcompinit && bashcompinit
          zmodload -i zsh/complist
        ''
        # Settings
        + ''

          zstyle ':completion:*' completer _extensions _complete _approximate

          zstyle ':completion:*' menu select
          zstyle ':completion:*' group-name ""
          zstyle ':completion:*' file-list all

          _comp_options+=(globdots)
          zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

        ''
        # Binds
        + ''
          bindkey -r '^I'

          bindkey '^ ' list-choices
          bindkey '^H' autosuggest-clear
          bindkey '^L' autosuggest-accept
          bindkey '^J' menu-complete
          bindkey -M menuselect '^J' undefined-key
          bindkey '^K' reverse-menu-complete
          bindkey -M menuselect '^K' reverse-menu-complete
        ''
        # Colors
        + ''
          zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}

          zstyle ':completion:*:descriptions' format '%F{${yellow.bright}}%B# %d %b%f'
          zstyle ':completion:*:corrections' format '%F{${yellow.normal}}%B%U? %d %e %u%b%f'
          zstyle ':completion:*:messages' format '%F{${white.normal}}- %d %f'
          zstyle ':completion:*:warnings' format '%F{${red.bright}}%B%U! no matches %u%b%f'

          # zstyle ':completion:*:options' list-colors '=(#b)*(-- *)=3${red.normal}=38;5;${black.bright}' '=*=3${red.normal}'
          # zstyle ':completion:*:argument-1' list-colors '=(#b)*(-- *)=3${red.normal}=38;5;${black.bright}' '=*=3${red.normal}'
          # zstyle ':completion:*:argument-1:*' list-colors '=(#b)*(-- *)=3${red.normal}=38;5;${black.bright}' '=*=3${red.normal}'

          zstyle ':completion:*:-command-:*:commands' list-colors '=(#b)*(-- *)=3${cyan.normal}=38;5;${black.bright}' '=*=3${cyan.normal}'
          zstyle ':completion:*:-command-:*:builtins' list-colors '=(#b)*(-- *)=3${cyan.normal}=38;5;${black.bright}' '=*=3${cyan.normal}'
          zstyle ':completion:*:-command-:*:functions' list-colors '=(#b)*(-- *)=3${blue.normal}=38;5;${black.bright}' '=*=3${blue.normal}'
          zstyle ':completion:*:-command-:*:aliases' list-colors '=(#b)*(-- *)=3${blue.normal}=38;5;${black.bright}' '=*=3${blue.normal}'
          zstyle ':completion:*:-command-:*:suffix-aliases' list-colors '=(#b)*(-- *)=3${blue.normal}=38;5;${black.bright}' '=*=3${blue.normal}'
          zstyle ':completion:*:-command-:*:reserved-words' list-colors '=(#b)*(-- *)=3${magenta.normal}=38;5;${black.bright}' '=*=3${magenta.normal}'
          zstyle ':completion:*:-command-:*:parameters' list-colors '=(#b)*(-- *)=3${red.normal}=38;5;${black.bright}' '=*=3${red.normal}'
        '';

      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          #"brackets"
        ];
        styles = {
          # Other
          unknown-token = "fg=${red.bright},bold,underline";
          default = "fg=${red.normal}";
          comment = "fg=${black.bright}";
          named-fd = "fg=${red.normal}";
          numeric-fd = "fg=${yellow.normal}";
          # Keyword
          reserved-word = "fg=${magenta.normal},bold";
          precommand = "fg=${magenta.normal}";
          # Alias
          alias = "fg=${blue.normal}";
          suffix-alias = "fg=${blue.normal}";
          global-alias = "fg=${blue.normal}";
          function = "fg=${blue.normal}";
          # Command
          command = "fg=${cyan.normal}";
          builtin = "fg=${cyan.normal}";
          hashed-command = "fg=${cyan.normal}";
          history-expansion = "fg=${cyan.normal}";
          # Operator
          commandseparator = "fg=${white.normal}";
          command-substitution-delimiter = "fg=${white.normal}";
          process-substitution-delimiter = "fg=${white.normal}";
          arithmetic-expansion = "fg=${white.normal}";
          back-quoted-argument-delimiter = "fg=${white.normal}";
          assign = "fg=${white.normal}";
          redirection = "fg=${white.normal}";
          # Path
          autodirectory = "fg=${yellow.bright}";
          path = "fg=${yellow.bright}";
          path_prefix = "fg=${yellow.bright}";
          globbing = "fg=${yellow.bright},bold,underline";
          # Options
          single-hyphen-option = "fg=${red.normal}";
          double-hyphen-option = "fg=${red.normal}";
          # Strings
          arg0 = "fg=${yellow.normal}";
          single-quoted-argument = "fg=${yellow.bright}";
          single-quoted-argument-unclosed = "fg=${yellow.bright},bold,underline";
          double-quoted-argument = "fg=${yellow.bright}";
          double-quoted-argument-unclosed = "fg=${yellow.bright},bold,underline";
          dollar-quoted-argument = "fg=${yellow.bright}";
          dollar-quoted-argument-unclosed = "fg=${yellow.bright},bold,underline";
          rc-quote = "fg=${cyan.normal}";
          back-double-quoted-argument = "fg=${cyan.normal}";
          back-dollar-quoted-argument = "fg=${cyan.normal}";
          dollar-double-quoted-argument = "fg=${red.normal}";
        };
      };
    };
  };
}
