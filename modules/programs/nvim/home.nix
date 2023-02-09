{ pkgs, user, ... }:

{
  programs.neovim = {
      enable = true;
      defaultEditor = true; # Set env EDITOR = nvim
      viAlias = true;
      vimAlias = true;
  };

  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "AzurIce";
    repo = "nvim";
    rev = "bef205c11f5553fc34d2c6b96ae2ff29a80299fe";
    sha256 = "sha256-42mBjoIsc2AcKrMgOr7TW46QfoJ02vHKBbvVopnB6dw=";
  };

#  home.file.".config/nvim".source = builtins.fetchGit {
#    url = "https://github.com/AzurIce/nvim.git";
#    # rev = "bef205c11f5553fc34d2c6b96ae2ff29a80299fe";
#  };

#  home.file.".config/nvim".source = ./nvim;
}
