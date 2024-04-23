inputs@{ user, config, pkgs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ../../modules/programs/git.nix
    ../../modules/programs/nvim.nix
    ../../modules/programs/typora/home.nix
    #../../modules/programs/maa/home.nix
    ../../modules/programs/alacritty.nix
    ../../modules/programs/kitty.nix
    ../../modules/programs/rime.nix
    # ../../modules/programs/obs-studio/home.nix
  ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age = {
      # sshKeyPaths = [ "/etc/ssh/ssh_host_ed25518_key" ];
      sshKeyPaths = [ ];
      keyFile = "/Users/${user}/Library/Application Support/sops/age/keys.txt";
      generateKey = true;
    };
    secrets.SSH_PVKEY = {
      mode = "0600";
      path = "/Users/${user}/.ssh/id_ed25519";
    };
  };

  home = {
    username = "${user}";
    homeDirectory = "/Users/${user}";
    packages = with pkgs; [
      btop
    ];
  };

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

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
