{ pkgs, user, ... }:

{
  home.pointerCursor = {
#    package = pkgs.bibata-cursors;
#    name = "Bibata-Modern-Classic";
    package = pkgs.catppuccin-cursors.frappeDark;
    name = "Catppuccin-Frappe-Dark-Cursors";
    size = 16;
    gtk.enable = true;
  };
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };
}

