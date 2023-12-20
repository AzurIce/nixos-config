{ user, config, pkgs, ... }:

{
  imports = [
    ../../modules/programs/git/home.nix
    ../../modules/programs/nvim/home.nix
    # ../../modules/programs/obs-studio/home.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/Users/${user}";
    packages = with pkgs; [
      btop
    ];
  };

  programs.alacritty = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
