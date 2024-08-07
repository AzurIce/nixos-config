inputs@{ pkgs, user, mac, ... }:

{
    programs.eww = {
        enable = true;
        configDir = if mac then
          ./eww-mac
        else
          ./eww;
    };
}
