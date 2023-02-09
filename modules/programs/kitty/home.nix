{ pkgs, user, ... }:

{
  programs.kitty = {
      enable = true;
      font = {
          name = "JetBrainsMono Nerdfont";
      };
  };
}
