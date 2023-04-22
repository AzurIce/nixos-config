# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, user, nur, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/hardware/nvidia.nix
      ../../modules/desktop/hyprland
    ] ++ ( import ../../modules/programs );

  # Bluetooth
  hardware.bluetooth.enable = true;
#  servives.blueman.enable = true;

  ##### Booting #####
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##### Display #####
  specialisation = {
    external-display.configuration = {
      system.nixos.tags = [ "external-display" ];
      hardware.nvidia.prime.offload.enable = lib.mkForce false;
      hardware.nvidia.powerManagement.enable = lib.mkForce false;
      environment.variables = {
        WLR_DRM_DEVICES = "/dev/dri/card0";
      };
    };
  };


  nixpkgs.overlays = [
    (self: super: {
       waybar = super.waybar.overrideAttrs (oldAttrs: {
         mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
         });
    })
  ];


  programs.fish.enable = true;

  ##### User #####
  users.users.azurice = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "video" ];
    hashedPassword = "$6$po.VmTKXBpQj3xzb$ZjABnUQnWSboNO0TX2rlIySqTUvU.0TnSuopaq07u44WwHznIrIgLzCO.fkjVeFJ8PicTxbMiyKpOg.NisaPH/";
    packages = (with config.nur.repos; [ xddxdd.wechat-uos]) ++ (with pkgs; [
#      kitty
      rofi-wayland
      wofi
      neofetch
      hyprpaper
      mpv
      imv
#      papirus-icon-theme

      rustup
      python
      gcc
      clang
      nodePackages.pnpm
      nodePackages.yarn
      nodejs
      go

      ghostwriter
      libreoffice
      gnome.nautilus
      dolphin
      cinnamon.nemo
      ranger
      # htop
      btop
      wlogout
      hyprpaper
      chromium
      microsoft-edge
      netease-cloud-music-gtk
      obsidian
    ]);
  };

  programs.light.enable = true;

  # fcitx5-rime
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
        fcitx5-rime
        fcitx5-gtk
    ];
    # fcitx5.enableRimeData = true;
  };

  ##### fonts #####
  fonts = {
    fonts = with pkgs; [
      jetbrains-mono
      nerdfonts
      noto-fonts-emoji
      lxgw-wenkai
      wqy_microhei
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontconfig.hinting.autohint = true;
  };

  ##### System #####
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  ##### Nix and Nixpkgs settings #####
  nix = {
    settings = {
      auto-optimise-store = true;
      # Hyprland Cachix
      substituters = [
        "https://hyprland.cachix.org"
        "https://mirrors.bfsu.edu.cn/nix-channels/store"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
    "electron-19.0.7"
    "electron-21.4.0"
  ];

  ##### Networking #####
  networking = {
    hostName = "laptop-blade";
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    proxy.default = "http://127.0.0.1:7890";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  time.timeZone = "Asia/Shanghai";

  services.openssh.enable = true;
  services.dbus.enable = true;

  ##### System packages #####
  environment = {
    systemPackages = with pkgs; [
      git

      neovim
      helix

      killall
      ntfs3g
      glib
      glibc
      webkitgtk
    ];
  };

}

