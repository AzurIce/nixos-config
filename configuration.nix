# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking.hostName = "AzurIce";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.05";
  };

  time.timeZone = "Asia/Shanghai";

  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.proxy.default = "127.0.0.1:7890";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  environment.variables = {
    XDG_CURRENT_DESKTOP = "Unity";
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    openssh = {
      enable = true;
    };
  };

  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  users.users.azurice = {
    isNormalUser = true;
    description = "AzurIce";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      (callPackage ./clash.nix { })
      firefox
      chromium
      obsidian
#     sway
      waybar
      hyprpaper
      libappindicator
      syncthing
      syncthing-tray
      config.nur.repos.iagocq.parsec
      config.nur.repos.xddxdd.wechat-uos
      config.nur.repos.xddxdd.wechat-uos-bin
      netease-cloud-music-gtk
#     fcitx5
      fcitx5-gtk
      fcitx5-lua
      fcitx5-configtool
    # config.nur.repos.rewine.electron-netease-cloud-music
    # config.nur.repos.xe.microsoft-edge-dev
    # todesk
    # thunderbird
    ];
  };

  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-rime
    fcitx5-chinese-addons
  ];

# Hyprland
  programs.hyprland = {
      enable = true;
  };

  programs.chromium.enable = true;

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  # xdg.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ntfs3g
    neovim
    neofetch
    vscode
    git
    wayland
    wl-clipboard
    python
    alacritty
    wofi
    kitty
    nerdfonts
    wget
    killall
    pipewire
    wireplumber
    alsa-lib
    alsa-utils
    pulsemixer
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
  programs.light.enable = true;
  programs.waybar.enable = true;

  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;


# syncthing
  services.syncthing = {
      enable = true;
      devices = {
        DESKTOP = {
            id = "D2KODQT-PE2DR2U-EOZPXTY-NF7VPYK-UM4GSC3-LC3XHYP-TBR5ZNQ-G3HDFA2";
        };
      };
      folders = {
          "/home/azurice/Files/Syncthing" = {
              id = "syncthing";
              devices = [ "DESKTOP" ];
          };
      };
  };
}
