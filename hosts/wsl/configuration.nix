# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ lib, pkgs, config, modulesPath, ... }:

with lib;
{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
  ];

  wsl = {
    enable = true;
    wslConf.automount.root= "/mnt";
    defaultUser = "azurice";
    startMenuLaunchers = true;

    # Enable native Docker support
    # docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = true;

  };

#  imports =
#    [ # Include the results of the hardware scan.
#      ./hardware-configuration.nix
#    ] ++ ( import ../../modules/programs );

  programs.fish.enable = true;

  ##### User #####
  users.users.azurice = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "video" ];
    hashedPassword = "$6$po.VmTKXBpQj3xzb$ZjABnUQnWSboNO0TX2rlIySqTUvU.0TnSuopaq07u44WwHznIrIgLzCO.fkjVeFJ8PicTxbMiyKpOg.NisaPH/";
    packages = (with pkgs; [
      neofetch
      mpv
      imv

      rustup
      python
      gcc
      clang
      nodePackages.pnpm
      nodePackages.yarn
      nodejs
      go

      # htop
      btop
    ]);
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
  system.stateVersion = "22.05";

  ##### Nix and Nixpkgs settings #####
  nix = {
    package = pkgs.nixFlakes;
    settings = {
      auto-optimise-store = true;
      substituters = [
        "https://mirrors.bfsu.edu.cn/nix-channels/store"
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
#  networking = {
#    hostName = "laptop-blade";
#    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
#    proxy.default = "http://127.0.0.1:7890";
#  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
#  };
#
#  time.timeZone = "Asia/Shanghai";
#
#  services.openssh.enable = true;
#  services.dbus.enable = true;

  ##### System packages #####
  environment = {
    variables = rec {
      GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
    };
    systemPackages = with pkgs; [
      git

      neovim
      helix

      killall
      glib
      glibc
    ];
  };

}

