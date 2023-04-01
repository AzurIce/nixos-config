{ pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [
    pamixer
    wl-clipboard
  ];

# programs.xwayland.enable = true;
# xdg.portal = {
#   enable = true;
#   wlr.enable = true;
# };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
