{
  inputs = {
    nvim-config = {
      type = "github";
      owner = "AzurIce";
      repo = "nvim";
      flake = false;
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };
  outputs = { self, nixpkgs, hyprland, home-manager, nvim-config, nur, nixos-wsl, ... }:
  {
    nixosConfigurations = import ./hosts {
      inherit nixpkgs hyprland home-manager nvim-config nur nixos-wsl;
    };
  };
}
