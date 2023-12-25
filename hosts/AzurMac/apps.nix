{ pkgs, ... }: {

  imports = [ ../../modules/programs/typora ];

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
    neovim
    helix
    alacritty
    nixpkgs-fmt
    rnix-lsp
  ];

  environment.variables = {
    http_proxy = "http://127.0.0.1:7890";
    https_proxy = "http://127.0.0.1:7890";
    all_proxy = "socks5://127.0.0.1:7890";
  };

  programs.zsh.enable = true;
  environment.shells = [
    pkgs.zsh
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
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/services"
      "homebrew/cask-versions"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "btop"
      "bun"
      "deno"
      "ffmpeg"
      "fzf"
      "go"
      "joshuto"
      "node"
      "openjdk"
      "pandoc"
      "pnpm"
      "python"
      "sqlite"
      "typst"
      # "aria2"  # download tool
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "warp"
      "github"
      "iterm2"
      "obsidian"
      "todesk"
      "karabiner-elements"
      "raycast"
      "visual-studio-code"
    ];
  };
}
