{ pkgs, user, ... }:

{
#    home.file.".config/eww".source = ./eww;

    programs.eww = {
        enable = true;
        configDir = ./eww;
    };
}
