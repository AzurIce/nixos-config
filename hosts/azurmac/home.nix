inputs@{ user, config, pkgs, ... }:

{
  imports = [
    ../../modules/fonts.nix
    ../../modules/programs/git.nix
    ../../modules/programs/nvim.nix
    ../../modules/programs/typora/home.nix
    #../../modules/programs/maa/home.nix
    ../../modules/programs/alacritty.nix
    ../../modules/programs/kitty.nix
    #../../modules/programs/rime.nix
    # ../../modules/programs/obs-studio/home.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/Users/${user}";
    packages = with pkgs; [
      btop
    ];
  };

  home.file.".yabairc".text = ''
    # layout
    yabai -m config layout bsp

    # paddings and gaps
    yabai -m config top_padding    4
    yabai -m config bottom_padding 4
    yabai -m config left_padding   4
    yabai -m config right_padding  4
    yabai -m config window_gap     8

    # rules
    yabai -m rule --add app="^Karabiner-Elements$" manage=off
    yabai -m rule --add app="^Clash Nyanpasu$" manage=off
    yabai -m rule --add app="^访达$" manage=off
    yabai -m rule --add app="^GitHub Desktop$" manage=off
    yabai -m rule --add app="^微信$" manage=off
    yabai -m rule --add app="^网易云音乐$" manage=off
    yabai -m rule --add app="^系统设置$" manage=off
  '';

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    initExtra = ''
      export PATH=$PATH:/Users/azurice/.cargo/bin
    '';
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "ag"
        "aliases"
        # "colored-man-page"
        "colorize"
        "copypath"
        "direnv"
        # "zsh-autosuggestions"
      ];
    };
  };

  programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
  };

  # programs.starship = {
  #   enable = true;
  #   # 自定义配置
  #   settings = {
  #     add_newline = false;
  #     # aws.disabled = true;
  #     # gcloud.disabled = true;
  #     # line_break.disabled = true;
  #   };
  # };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
