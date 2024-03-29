{ pkgs, user, nvim-config, ... }:

{
  imports = [
#      ../../modules/desktop/hyprland/home.nix
#      ../../modules/desktop/gtk/home.nix
      ../../modules/programs/nvim/home.nix
#      ../../modules/programs/vscode/home.nix
#      ../../modules/programs/obs-studio/home.nix
#      ../../modules/programs/ranger/home.nix
##      ../../modules/programs/eww/home.nix
#      ../../modules/programs/waybar/home.nix
#      ../../modules/programs/firefox/home.nix
      ../../modules/shell/fish/home.nix
      ../../modules/programs/git/home.nix
#      ../../modules/programs/kitty/home.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "22.05";

  manual.manpages.enable = false;
}

