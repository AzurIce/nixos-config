{ pkgs, user, ... }:

{
  home.file."Library/Application Support/abnerworks.Typora/themes".source = ./typora-themes;
}
