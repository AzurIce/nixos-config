inputs@{ user, ... }:

{
  imports = [
    ../../modules/desktop/hyprland/home.nix
    ../../modules/programs/eww/home.nix

    ../../modules/programs/git.nix
    ../../modules/programs/nvim.nix
    ../../modules/fonts.nix
  ];

  home = {
      username = "${user}";
    homeDirectory = "/home/${user}";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";

  manual.manpages.enable = false;
}
