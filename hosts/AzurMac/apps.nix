{ pkgs, system, ... }: {

  imports = [
    ../../modules/programs/typora
  ];

  ##########################################################################
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    git
    # vim
    neovim
    helix
    alacritty
    nixpkgs-fmt
    # rnix-lsp
    android-tools
    # jdk8
    # oraclejdk8
    btop
    sops

    just
    nushell
    ffmpeg
    fzf
    # joshuto
    yazi

    deno
    bun
    nodejs_21
    nodePackages_latest.pnpm
    typst
    sqlite
    pandoc
    python3
    obsidian
    iterm2
    raycast
    vscode
    warp-terminal
    cargo
    lua51Packages.luarocks
    lua51Packages.lua

    localsend
    sing-box
  ];

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  environment.variables = {
    http_proxy = "http://127.0.0.1:7890";
    https_proxy = "http://127.0.0.1:7890";
    all_proxy = "socks5://127.0.0.1:7890";
  };

  programs.zsh.enable = true;
  environment.shells = with pkgs; [
    zsh
    nushell
  ];

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      # cleanup = "zap";
    };

    taps = [
      "homebrew/cask-fonts"
      "homebrew/services"
      "homebrew/cask-versions"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
	    # "sing-box"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "squirrel"
      "qq"
      "todesk"
      "github"
      "karabiner-elements"
      # "sfm"
    ];
  };
}
