{config, pkgs, ...}:

{
    home = {
      username = "azurice";
      homeDirectory = "/Users/azurice";
      packages = with pkgs; [
        btop
      ];
    };

    programs.git = {
      enable = true;
      userName = "Azur冰弦";
      userEmail = "973562770@qq.com";
    };

    programs.alacritty = {
      enable = true;
    };

    programs.zsh = {
      enable = true;
    };

    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
}
