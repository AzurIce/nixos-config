{ user, config, pkgs, ... }:

{
  imports = [
    ../../modules/programs/git/home.nix
    ../../modules/programs/nvim/home.nix
    ../../modules/programs/typora/home.nix
    ../../modules/programs/maa/home.nix
    # ../../modules/programs/obs-studio/home.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/Users/${user}";
    packages = with pkgs; [
      btop
    ];
  };


  programs.alacritty = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
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

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
