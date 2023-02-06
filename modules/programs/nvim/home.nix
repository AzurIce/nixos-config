{ pkgs, user, ... }:

{
  home.file.".config/nvim".source = ./nvim;
}
