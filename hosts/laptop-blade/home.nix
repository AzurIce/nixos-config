{ pkgs, user, ... }:

{
  imports = [
      ../../modules/desktop/hyprland/home.nix
      ../../modules/programs/nvim/home.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "22.11";

  programs.git = {
    enable = true;
    userName = "AzurIce";
    userEmail = "973562770@qq.com";
  };

  manual.manpages.enable = false;
}
