{ pkgs, user, ... }:

{
  programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
  };
}
