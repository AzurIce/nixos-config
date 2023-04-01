{ pkgs, user, hyprland, ... }:

{
  imports = [ hyprland.nixosModules.default ];

  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
  };

  environment.systemPackages = with pkgs; [
    pamixer
    wl-clipboard
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
