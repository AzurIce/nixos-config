inputs@{ pkgs, user, mac, ... }:

{
#    home.file.".config/eww".source = ./eww;

    programs.eww = {
        enable = true;
        configDir = if mac then
          ./eww-mac
        else
          ./eww;
    };
}
