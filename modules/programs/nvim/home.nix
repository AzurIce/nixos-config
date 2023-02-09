{ pkgs, user, ... }:

let
  nvim = pkgs.fetchFromGitHub {
    owner = "AzurIce";
    repo = "nvim";
    rev = "d2a238f3ebda604821befb099433694814e64643";
    sha256 = "sha256-J2Z53SJBuhRBpYlbWqbnXslBoX0NCYKvccWl7uEehyw=";
  };
#  nvim = builtins.fetchGit {
#    url = "https://github.com/AzurIce/nvim.git";
#    rev = "bef205c11f5553fc34d2c6b96ae2ff29a80299fe";
#  };
in {
  programs.neovim = {
      enable = true;
      defaultEditor = true; # Set env EDITOR = nvim
      viAlias = true;
      vimAlias = true;
  };

  home.file.".config/nvim".source = nvim;


#  home.file.".config/nvim".source = ./nvim;
}
