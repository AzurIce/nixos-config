{ pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [
      pamixer
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
