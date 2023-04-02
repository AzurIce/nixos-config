{ pkgs, user, ... }:

{
  programs.kitty = {
      enable = true;
      font = {
          name = "JetBrainsMono Nerdfont";
          size = 12; # Default: 8
      };
      settings = {
          background_opacity = "0.7";
      };
  };
}
