inputs@{ user, ... }:

{
  imports = [
	  ../../modules/programs/git.nix
	  ../../modules/desktop/hyprland/home.nix
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
