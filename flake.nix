{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # apple-silicon support
    nixos-apple-silicon.url = "github:tpwrules/nixos-apple-silicon";

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      allHosts = (import ./hosts inputs);
    in
    allHosts;
}
