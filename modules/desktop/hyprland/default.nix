{ pkgs, user, hyprland, ... }:

{
  imports = [ hyprland.nixosModules.default ];

  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    pamixer
    wl-clipboard

    eww-wayland
    jq
    socat
    xwayland

    rofi-wayland
    wlogout
    hyprpaper
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
