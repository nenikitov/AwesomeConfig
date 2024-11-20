{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./misc

    ./programs/firefox
    ./programs/neovim.nix
    ./programs/zsh
    ./programs/alacritty
  ];

  home.username = "nenikitov";
  home.homeDirectory = "/home/nenikitov";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    neofetch
    wl-clipboard
    discord
    git
    zip
    unzip
    git
    ripgrep
    python311
  ];

  programs = {
    home-manager.enable = true;

    chromium = {
      enable = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    options = "--delete-older-than +5";
  };
}
