inputs@{ dotfiles, pkgs, user, ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      [
        "$mod, F, exec, firefox"
        ", Print, exec, grimblast copy area"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      ) ++ [
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
      ] ++ [
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ] ++ [
        "$mod, Return, exec, kitty"
        "$mod, Escape, exec, wlogout"
        "$mod, E, exec, nautilus"
        "$mod, Q, killactive"
        "$mod, M, exit"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen"
      ];
    bindm =
      [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    exec-once = [
      "eww open topbar & hyprpaper & fcitx5 & clash-verge & syncthingtray --wait"
    ];
  };
  #home.file.".config/eww".source = "${dotfiles}/eww";
  #home.file.".config/hypr".source = "${dotfiles}/hypr";
#  home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
#  home.file.".config/hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
#
#  # Note: the sessionVariables will be only set when home-manager manager a shell
#  # e.g. fish, bash
#  home.sessionVariables = {
#    EDITOR = "nvim";
#    BROWSER = "firefox";
#    TERMINAL = "kitty";
#
#    QT_QPA_PLATFORMTHEME = "gtk3";
#    QT_SCALE_FACTOR = "1";
#    MOZ_ENABLE_WAYLAND = "1";
#    SDL_VIDEODRIVER = "wayland";
#    _JAVA_AWT_WM_NONREPARENTING = "1";
#    QT_QPA_PLATFORM = "wayland";
#    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
#    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
#
#    # Hyprland launch
#    LIBVA_DRIVER_NAME = "nvidia";
#    WLR_NO_HARDWARE_CURSORS = "1";
#
#    # Force using GBM backend
#    # But With GBM_BACKEND = "nvidia-drm", firefox will crash.
#    # Obsidian will randomly freezes the entire system with hardware acceleration on,
#    # it has no thing to do with this line but some problem of the intel driver,
#    # See https://forum.obsidian.md/t/obsidian-randomly-freezes-the-entire-system/45683
#    # GBM_BACKEND = "nvidia-drm";
#    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
#
#    #CLUTTER_BACKEND = "wayland";
#
#    #vulkan
#    WLR_RENDERER = "vulkan";
#    #__NV_PRIME_RENDER_OFFLOAD="1";
#
#    XDG_CURRENT_DESKTOP = "Hyprland";
#    XDG_SESSION_DESKTOP = "Hyprland";
#    XDG_SESSION_TYPE = "wayland";
#    XDG_CACHE_HOME = "\${HOME}/.cache";
#    XDG_CONFIG_HOME = "\${HOME}/.config";
#    XDG_BIN_HOME = "\${HOME}/.local/bin";
#    XDG_DATA_HOME = "\${HOME}/.local/share";
#  };
}
