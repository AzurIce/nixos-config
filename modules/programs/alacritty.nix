{ pkgs, user, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 16.0;
        normal.family = "JetBrainsMono Nerd Font";
        window.opacity = 0.8;
      };
    };
  };
}
