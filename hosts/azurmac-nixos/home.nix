inputs@{ user, ... }:

{
  imports = [
	  ../../modules/programs/git.nix
  ];

  home = {
	  username = "${user}";
    homeDirectory = "/home/${user}";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";

  manual.manpages.enable = false;
}
