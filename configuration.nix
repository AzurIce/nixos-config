# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.proxy.default = "127.0.0.1:7890";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  users.users.azurice = {
    isNormalUser = true;
    description = "AzurIce";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      (callPackage ./clash.nix { })
      firefox
      obsidian
      sway
      waybar
    # thunderbird
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ntfs3g
    neovim
    git
    wayland
    wl-clipboard
    python
    alacritty
    nerdfonts
    wget
  ];

  fonts.fonts = [
      pkgs.nerdfonts
  ];

  programs.sway.enable = true;
  programs.sway.extraPackages = with pkgs; [
    wlogout
    dmenu
    swayidle
    light
    wluma
  ];
  programs.waybar.enable = true;

  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;


  system.stateVersion = "22.05"; # Did you read the comment?

}
