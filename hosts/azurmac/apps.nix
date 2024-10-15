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
    git-lfs
    # vim
    helix
    alacritty
    nixpkgs-fmt
    # rnix-lsp
    android-tools
    # jdk8
    # oraclejdk8
    btop

    just
    nushell
    ffmpeg
    fzf
    yazi

    nil
    poetry
    bun
    nodejs_22
    nodePackages_latest.pnpm
    typst
    sqlite
    pandoc
    python3
    obsidian
    iterm2
    raycast
    vscode
    cargo
    lua51Packages.luarocks
    lua51Packages.lua
    jdk21

    localsend
    sing-box
  ];

  # services.postgresql = {
  #   enable = true;
  #   ensureDatabases = [ "mydatabase" ];
  #   authentication = pkgs.lib.mkOverride 10 ''
  #     #type database  DBuser  auth-method
  #     local all       all     trust
  #   '';
  # };

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

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    # config = {
    #   layout = "bsp";
    #   window_gap = 20;
    # };
    # extraConfig = ''
    #   yabai -m rule --add app='System Preferences' manage=off
    # '';
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      alt - return : alacritty
      alt - q : yabai -m window --close

      alt - 1 : yabai -m space --focus 1
      alt - 2 : yabai -m space --focus 2
      alt - 3 : yabai -m space --focus 3
      alt - 4 : yabai -m space --focus 4
      alt - 5 : yabai -m space --focus 5

      shift + alt - 1 : yabai -m window --space 1; yabai -m space --focus 1
      shift + alt - 2 : yabai -m window --space 2; yabai -m space --focus 2
      shift + alt - 3 : yabai -m window --space 3; yabai -m space --focus 3
      shift + alt - 4 : yabai -m window --space 4; yabai -m space --focus 4

      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east

      alt + shift - h : yabai -m window west --resize right:-20:0 2> /dev/null || /opt/homebrew/bin/yabai -m window --resize right:-20:0
      alt + shift - l : yabai -m window east --resize left:20:0 2> /dev/null || /opt/homebrew/bin/yabai -m window --resize left:20:0

      alt + shift - space : yabai -m window --toggle float
      alt + shift - t : yabai -m window --toggle topmost

      alt - b : yabai -m space --layout bsp
      alt - m : yabai -m space --layout stack

      # Rotate windows clockwise and anticlockwise
      alt - r         : yabai -m space --rotate 270
      shift + alt - r : yabai -m space --rotate 90

      # Rotate on X and Y Axis
      shift + alt - x : yabai -m space --mirror x-axis
      shift + alt - y : yabai -m space --mirror y-axis

      # Make window native fullscreen
      alt - f         : yabai -m window --toggle zoom-fullscreen
      # shift + alt - f : yabai -m window --toggle native-fullscreen
    '';
  };

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    taps = [
      "homebrew/services"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
	    # "sing-box"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "qq"
      "wechat"
      "typora"
      #"todesk"
      "github"
      # "karabiner-elements"
      # "sfm"
    ];
  };
}
