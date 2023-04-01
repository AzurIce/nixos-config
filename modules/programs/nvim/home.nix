{ pkgs, user, nvim-config, ... }:

{
  programs.neovim = {
      enable = true;
      defaultEditor = true; # Set env EDITOR = nvim
      viAlias = true;
      vimAlias = true;
  };

  home.file.".config/nvim".source = nvim-config;
}
