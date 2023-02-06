{ pkgs, user, ... }:

{
    home.file.".config/waybar".source = ./waybar;

    programs.waybar = {
        enable = true;
    };
}
