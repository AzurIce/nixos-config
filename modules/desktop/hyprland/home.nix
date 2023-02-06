{ pkgs, user, ... }:

{
    home.file.".config/hypr".source = ./hypr;
}
