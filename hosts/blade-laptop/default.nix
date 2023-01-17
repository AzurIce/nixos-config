# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
  launch-hyprland = pkgs.writeShellScriptBin "launch-hyprland" ''
    export LIBVA_DRIVER_NAME=nvidia
    export XDG_SESSION_TYPE=wayland
    export GBM_BACKEND=nvidia-drm
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export WLR_NO_HARDWARE_CURSORS=1

    exec Hyprland
  '';
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  ##### Nix and Nixpkgs settings #####
  nix.settings = {
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
  nixpkgs.config.allowUnfree = true;

  ##### Booting #####
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
      "nvidia-drm.modeset=1"
  ];

  ##### Networking #####
  networking = {
    hostName = "laptop-blade";
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    proxy.default = "127.0.0.1:7890";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  time.timeZone = "Asia/Shanghai";

  ##### localization #####
  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  ##### Display #####
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
  };
  xdg.portal = {
      enable = true;
      wlr.enable = true;
  };
  services = {
      pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          jack.enable = true;
      };
  };
  environment.systemPackages = with pkgs; [
    nvidia-offload
    launch-hyprland
    ntfs3g
  ];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = true;
  hardware.nvidia.prime = {
    offload.enable = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  specialisation = {
    external-display.configuration = {
      system.nixos.tags = [ "external-display" ];
      hardware.nvidia.prime.offload.enable = lib.mkForce false;
      hardware.nvidia.powerManagement.enable = lib.mkForce false;
    };
  };

  ##### Keymap #####
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  ##### User #####
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.azurice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      git
      neovim
      helix

      kitty
      wofi
      neofetch

      python

      gnome.nautilus
      dolphin
      ranger
      syncthingtray
      wlogout
      waybar
      hyprpaper
      firefox
      chromium
      obsidian
      (callPackage ./clash.nix { })
      killall

      qt5ct
      libva
      nvidia-vaapi-driver

      obs-studio
    ];
  };

  services.syncthing = {
      enable = true;
      user = "azurice";
      dataDir = "/home/azurice/Documents";
      configDir = "/home/azurice/Documents/.config/syncthing";
      folders = {
          "/home/azurice/File/__Syncthing__/Notes" = {
              id = "Notes";
          };
      };
      devices = {
          DESKTOP-AORUS = {
              id = "PFCP7N4-5QOYSNB-GQ5LUV3-W7BPLAZ-5AXLAMG-NHRH2OK-YPTX4LU-EFIRAAU";
          };
          DESKTOP = {
              id = "D2KODQT-PE2DR2U-EOZPXTY-NF7VPYK-UM4GSC3-LC3XHYP-TBR5ZNQ-G3HDFA2";
          };
      };
  };

  ##### fonts #####
  fonts.fonts = with pkgs; [
    nerdfonts
    noto-fonts-emoji
    wqy_microhei
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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

}
