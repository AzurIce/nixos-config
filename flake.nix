{
  nixConfig = {
    extra-substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];
    trusted-substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];
  };

  inputs = {
    dotfiles = {
      type = "github";
      owner = "AzurIce";
      repo = ".dotfiles";
      flake = false;
    };
    nvim-config = {
      type = "github";
      owner = "AzurIce";
      repo = "nvim";
      flake = false;
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # for wsl
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for macos
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    hyprland.url = "github:hyprwm/Hyprland";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    joshuto.url = "github:kamiyaa/joshuto";

    agenix.url = "github:ryantm/agenix";
    # optional, not necessary for the module
    #inputs.agenix.inputs.nixpkgs.follows = "nixpkgs";
    # optionally choose not to download darwin deps (saves some resources on Linux)
    #inputs.agenix.inputs.darwin.follows = "";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      allHosts = (import ./hosts inputs);
    in
    allHosts // {
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    };
}
