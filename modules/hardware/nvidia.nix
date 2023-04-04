{ config, pkgs, lib, ... }:

let nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  # A command ine utility for Linux to save laptop battery power
  # check:
  #   https://wiki.archlinux.org/title/TLP
  #   https://linrunner.de/tlp/index.html
  services.tlp.enable = true;

  # Automatic CPU speed & power optimizer
  # check:
  #   https://github.com/AdnanHodzic/auto-cpufreq
  services.auto-cpufreq.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  boot.kernelParams = [
      "nvidia-drm.modeset=1"
  ];
  hardware.nvidia = {
    open = false; # Don't use open source kernel module
    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
    modesetting.enable = true;
    powerManagement.enable = true;
    prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true; # Enable support of Direct Render for 32-bit apps
    extraPackages = with pkgs; [ # Add OpenCL drivers, VA-API/VDPAU drivers etc
      intel-media-driver
      vaapiIntel
      nvidia-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.systemPackages = with pkgs; [
    nvidia-offload
    qt5ct
    libva # An implementation for VA-API(Video Acceleration API)
    libva-utils
    glxinfo # Test utilities for OpenGL
  ];
}

