inputs@{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  environment.sessionVariables.WLR_DRM_DEVICES = "/dev/dri/card0";

  environment.systemPackages = with pkgs; [
    eww
    jq
    socat
    
    kitty
    rofi-wayland
    wlogout
    hyprpaper
  ];
}
